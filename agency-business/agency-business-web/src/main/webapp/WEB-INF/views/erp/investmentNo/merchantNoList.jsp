<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<html> 
	<head>
		<meta http-equiv="Expires" content="0">   
		<meta http-equiv="Cache-Control" content="no-cache">   
		<meta http-equiv="Pragma" content="no-cache">  
		<title>出资方商户号查询</title>
		<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/themes/default/easyui.css">
		<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/themes/icon.css">
		<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/query.css">
		<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.8.0.min.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.easyui.min.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/js/easyui-lang-zh_CN.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/js/json.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/js/cferp.js"></script>
		
		<style type="text/css">
		    #fm
		    {
		        margin: 0;
		        padding: 10px 30px;
		    }
		    .ftitle
		    {
		        font-size: 14px;
		        font-weight: bold;
		        padding: 5px 0;
		        margin-bottom: 10px;
		        border-bottom: 1px solid #ccc;
		    }
		    .fitem
		    {
		        margin-bottom: 5px;
		    }
		    .fitem label
		    {
		        display: inline-block;
		        width: 80px;
		    }
		</style>
		
		<script type="text/javascript">
			$.ajaxSetup({cache:false});
			$(function(){
				$('#p').panel('close');
			});
		</script>
		
		<!-- 页面操作脚本 -->    
		<script type="text/javascript">

	        var url;
	        
	        //查询商户号信息
	        function searchMeachant() {
	        	$('#dg').datagrid('load',{
					merchantNo: $("#merchantNoSearch").val(),
					merchantId: $("#merchantIdSearch").combobox('getValue')
				});
	        }
	        
	        //重置查询条件
	        function resetQueryCondition() {
	        	$("#merchantNoSearch").val('');
				$("#merchantIdSearch").combobox('clear');
	        }



            //商户号加载成功后
            var merchantNoTableColumnFieldsWithAccount = [];
            function merchantNoDataLoadSuccess(merchantNoRowsData){
                if(merchantNoTableColumnFieldsWithAccount.length==0){
                    var tempColumnFields = $('#dg').datagrid('getColumnFields');
                    for(var targetTempColumnsIndex in tempColumnFields){
                        var targetTempField = tempColumnFields[targetTempColumnsIndex];
                        if(targetTempField.indexOf('account1') == 0){
                            merchantNoTableColumnFieldsWithAccount.push(targetTempField);
                        }
                    }
                }

                var merchantNoRows = merchantNoRowsData.rows;
                for(var merchantNoRowIndex in merchantNoRows){
                    updateMerchantNoRowAccount(merchantNoRowIndex,merchantNoRows);
                }
            }
            function updateMerchantNoRowAccount(merchantNoRowIndex,merchantNoRows){
                var merchantNoRow = merchantNoRows[merchantNoRowIndex];
                $.getJSON(
                        '${pageContext.request.contextPath}/erp/merchantAccount/findAllMerchantAccount?merchantNoId=' + merchantNoRow.id + '&merchantNo=' + merchantNoRow.merchantNo+'&date='+new Date(),
                        function(merchantAccounts){
                            var needUpdateData = {};
                            for(var merchantNoTableColumnFieldsWithAccountIndex in merchantNoTableColumnFieldsWithAccount){
                                merchantNoRow[merchantNoTableColumnFieldsWithAccount[merchantNoTableColumnFieldsWithAccountIndex]] = '--';
                                needUpdateData[merchantNoTableColumnFieldsWithAccount[merchantNoTableColumnFieldsWithAccountIndex]] = '--';
                            }
                            for(var merchantAccountIndex in merchantAccounts){
                                var merchantAccount = merchantAccounts[merchantAccountIndex];
                                merchantNoRow['account'+merchantAccount.type] = merchantAccount.totalAsset;
                                needUpdateData['account'+merchantAccount.type] = merchantAccount.totalAsset;
                            }

                            $('#dg').datagrid('updateRow',{
                                index: merchantNoRowIndex,
                                row: needUpdateData
                            });
                        }
                );
            }
	        
	    </script>
	</head>
	
    <body class="easyui-layout" data-options="fit:true,border:false">
		<div data-options="region:'north',border:false">
			<!-- 查询 -->
			<div id="toolbar">
				<table class="query">
					<tr>
						<td style="white-space: nowrap;">商户号</td>
						<td><input id="merchantNoSearch" name="merchantNoSearch"  /></td>
						<td style="white-space: nowrap;">所属出资方</td>
						<td>
							<input id="merchantIdSearch" name="merchantIdSearch" class="easyui-combobox" 
	   							data-options="valueField:'id',textField:'merchantName',editable:false,url:'${pageContext.request.contextPath}/erp/investment/findAllMerchantToSelect'"/>
						</td>
						<td>
							<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search',plain:false" onclick="searchMeachant()"><span style="white-space: nowrap;">查询</span></a>
						</td>
						<td>
							<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-undo',plain:false" onclick="resetQueryCondition()"><span style="white-space: nowrap;">重置</span></a>
						</td>
					</tr>
				</table>
			</div>
		</div>
		  
		<div data-options="region:'center',border:false">
		    <!-- 表格操作工具栏 -->
		    <div id="tb" style="height:auto">
		    </div>
		    
		    <!-- 商户号信息表 -->
		    <table id="dg" fit="true" class="easyui-datagrid" title="" style="width:'1024px';height:auto" 
			    data-options="
			    iconCls: 'icon-edit',
			    pageNumber:1,
			    pageSize:15,
			    pageList: [15,30,50],
			    pagination:true,
			    singleSelect: true,
			    fitColumns:true,
			    toolbar: '#tb',
			    url: '${pageContext.request.contextPath}/erp/merchantNo/findAllMerchantNo?type=2',
			    onClickCell:onClickCell,
			    onLoadSuccess:merchantNoDataLoadSuccess
			    ">
			    <thead>
				    <tr>
				    	<th data-options="field:'id',width:50,hidden:true">主键ID</th>
				    	<th data-options="field:'merchantNo',width:50">商户号</th>
				    	<th data-options="field:'merchantNoName',width:80">商户号名称</th>
				    	<th data-options="field:'merchantName',width:100">所属出资方</th>
					    <th data-options="field:'ratio',width:50">分成比例</th>
					    <th data-options="field:'status',width:50,formatter:function(value,row){
					        if(row.status=='1') {
					        	return '已启用';
					        } else {
					        	return '未启用';
					        }
						}">状态</th>
                        <th data-options="field:'account100',width:50,formatter:function(value,row){
					        if(row.account100==undefined || row.account100=='') {
					        	return '加载中..';
					        } else {
					        	return row.account100;
					        }
						}">出资方贷款户</th>
                        <th data-options="field:'account101',width:50,formatter:function(value,row){
					        if(row.account101==undefined || row.account101=='') {
					        	return '加载中..';
					        } else {
					        	return row.account101;
					        }
						}">出资方结算应付户</th>
                        <th data-options="field:'account102',width:50,formatter:function(value,row){
					        if(row.account102==undefined || row.account102=='') {
					        	return '加载中..';
					        } else {
					        	return row.account102;
					        }
						}">出资方结算应收户</th>
                        <th data-options="field:'account103',width:50,formatter:function(value,row){
					        if(row.account103==undefined || row.account103=='') {
					        	return '加载中..';
					        } else {
					        	return row.account103;
					        }
						}">出资方结算实收户</th>
                        <th data-options="field:'account104',width:50,formatter:function(value,row){
					        if(row.account104==undefined || row.account104=='') {
					        	return '加载中..';
					        } else {
					        	return row.account104;
					        }
						}">出资方对用户服务费应收</th>
                        <th data-options="field:'account105',width:50,formatter:function(value,row){
					        if(row.account105==undefined || row.account105=='') {
					        	return '加载中..';
					        } else {
					        	return row.account105;
					        }
						}">出资方对用户服务费实收</th>
                        <th data-options="field:'account106',width:50,formatter:function(value,row){
					        if(row.account106==undefined || row.account106=='') {
					        	return '加载中..';
					        } else {
					        	return row.account106;
					        }
						}">出资方对用户罚金应收</th>
                        <th data-options="field:'account107',width:50,formatter:function(value,row){
					        if(row.account107==undefined || row.account107=='') {
					        	return '加载中..';
					        } else {
					        	return row.account107;
					        }
						}">出资方对用户罚金实收</th>
                        <th data-options="field:'account108',width:50,formatter:function(value,row){
					        if(row.account108==undefined || row.account108=='') {
					        	return '加载中..';
					        } else {
					        	return row.account108;
					        }
						}">出资方对商家服务费应收</th>
                        <th data-options="field:'account109',width:50,formatter:function(value,row){
					        if(row.account109==undefined || row.account109=='') {
					        	return '加载中..';
					        } else {
					        	return row.account109;
					        }
						}">出资方对商家服务费实收</th>
				    </tr>
			    </thead>
		    </table>
		    
	    	<!-- 账户配置 -->
		    <div id="accountdlg" class="easyui-dialog" style="width: 600px; height: 400px; padding: 0;" closed="true">
			 	<div class="easyui-layout" fit="true">
				    <div data-options="region:'center', border:false">
				        <table id="dgAccount" fit="true" class="easyui-datagrid" title="" 
						    data-options="
						    iconCls: 'icon-tip',
						    singleSelect: true,
						    url: '',
						    fitColumns:true,
						    method: 'post',
						    onClickCell:onClickCell
				    	">
				    		<thead>
							    <tr>
							    	<th data-options="field:'id',width:100,hidden:true">主键ID</th>
							    	<th data-options="field:'account',width:100">账户</th>
							    	<th data-options="field:'accountName',width:100">账户名称</th>
							    	<th data-options="field:'ower',width:100">账户所有者</th>
							    	<th data-options="field:'totalAsset',width:100">金额</th>
							    	<th data-options="field:'type',width:100,formatter:function(value,row){
								        if(row.type=='100') {
								        	return '出资方贷款户';
								        } else if(row.type=='101') {
								        	return '出资方结算应付户';
								        } else if(row.type=='102') {
								        	return '出资方结算应收户';
								        } else if(row.type=='103') {
								        	return '出资方结算实收户';
								        } else if(row.type=='104') {
								        	return '出资方对用户服务费应收';
								        } else if(row.type=='105') {
								        	return '出资方对用户服务费实收';
								        } else if(row.type=='106') {
								        	return '出资方对用户罚金应收';
								        } else if(row.type=='107') {
								        	return '出资方对用户罚金实收';
								        } else if(row.type=='108') {
								        	return '出资方对商家服务费应收';
								        } else if(row.type=='109') {
								        	return '出资方对商家服务费实收';
								        }
									}">类型</th>
									
							    </tr>
				    		</thead>
				    	</table>
				    </div>
			 	</div>
			 </div>
			 
	    </div>
    
		<script type="text/javascript">
		    var editIndex = null;
			function onClickCell(index, field) {
				editIndex = index;
			}
		</script>
    </body>
    </html>
