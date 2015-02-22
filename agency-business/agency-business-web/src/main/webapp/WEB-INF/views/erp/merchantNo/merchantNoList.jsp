<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<html> 
	<head>
		<meta http-equiv="Expires" content="0">   
		<meta http-equiv="Cache-Control" content="no-cache">   
		<meta http-equiv="Pragma" content="no-cache">  
		<title>商家商户号查询</title>
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
					merchantNo: $("#merchantNoSearch").val()
					
					<%-- merchantId: $("#merchantIdSearch").combobox('getValue')--%>
				});
	        }
	        
	        //重置查询条件
	        function resetQueryCondition() {
	        	$("#merchantNoSearch").val('');
			//	$("#merchantIdSearch").combobox('clear');
	        }
	        
	        //费率
	        function rate() {
	        	
	        	var row = $("#dg").datagrid("getSelected");
	            
	            if (row) {
	        		
	            	//加载要修改的记录，用于初始化页面表单元素
                    $("#dgRate").datagrid({
			        	url: '${pageContext.request.contextPath}/erp/merchantRate/findAllMerchantRate?merchantNoId=' + row.id
			        });
			        
			        //设置hidden
			        $("#merchantNoId_rate").val(row.id);
                    
                    //设置对话框标题
	        		$("#ratedlg").dialog("open").dialog('setTitle', '分期费率和预付款比例');
	            } else {
	            	$.messager.show({
	                    title: '提示',
	                    msg: "请选择一条记录！"
	                });
	            }
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
	        //订单查询
	        function order() {
	        	var row = $("#dg").datagrid("getSelected");
	            
	            if (row) {
			        var href = '${pageContext.request.contextPath}/erp/order/list?merchantNoId=' + row.id + '&merchantNo=' + row.merchantNo;
			        addSubTab("商户号" + row.merchantNo + "的订单列表", href);
	            } else {
	            	$.messager.show({
	                    title: '提示',
	                    msg: "请选择一条记录！"
	                });
	            }
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
						<%--
						<td style="white-space: nowrap;">所属商家</td>
						<td>
							<input id="merchantIdSearch" name="merchantIdSearch" class="easyui-combobox" 
	   							data-options="valueField:'id',textField:'merchantName',editable:false,url:'${pageContext.request.contextPath}/erp/merchant/findAllMerchantToSelect'"/>
						</td>
						 --%>
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
		    	<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-tip',plain:true" onclick="rate()">费率</a>
		    	<%-- 
			    <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-back',plain:true" onclick="order()">订单</a>
			    --%>
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
			    url: '${pageContext.request.contextPath}/erp/merchantNo/findAllMerchantNo?type=1',
			    onClickCell:onClickCell,
			    onLoadSuccess:merchantNoDataLoadSuccess
			    ">
			    <thead>
				    <tr>
				    	<th data-options="field:'id',width:50,hidden:true">主键ID</th>
				    	<th data-options="field:'merchantNo',width:50">商户号</th>
				    	<th data-options="field:'merchantNoName',width:80">商户号名称</th>
				    	<th data-options="field:'merchantName',width:100">所属商家</th>
					    <th data-options="field:'serviceRate',width:50">服务费费率</th>
					    <th data-options="field:'serviceRateForPlat',width:50">平台服务费分成比例</th>
					    <th data-options="field:'serviceForRateInvestment',width:50">出资方服务费分成比例</th>
					    <th data-options="field:'hesitationDay',width:50">犹豫期(天)</th>
					    <th data-options="field:'investmentNo',width:50">关联出资方商户号</th>
					    <th data-options="field:'platformNo',width:50">管理平台商户号</th>
					    <th data-options="field:'status',width:50,formatter:function(value,row){
					        if(row.status=='1') {
					        	return '已启用';
					        } else {
					        	return '未启用';
					        }
						}">状态</th>

                        <th data-options="field:'account110',width:50,formatter:function(value,row){
					        if(row.account110==undefined || row.account110=='') {
					        	return '加载中..';
					        } else {
					        	return row.account110;
					        }
						}">商家本金应收</th>
                        <th data-options="field:'account111',width:50,formatter:function(value,row){
					        if(row.account111==undefined || row.account111=='') {
					        	return '加载中..';
					        } else {
					        	return row.account111;
					        }
						}">商家本金实收</th>
                        <th data-options="field:'account112',width:50,formatter:function(value,row){
					        if(row.account112==undefined || row.account112=='') {
					        	return '加载中..';
					        } else {
					        	return row.account112;
					        }
						}">商家对用户服务费应收</th>
                        <th data-options="field:'account113',width:50,formatter:function(value,row){
					        if(row.account113==undefined || row.account113=='') {
					        	return '加载中..';
					        } else {
					        	return row.account113;
					        }
						}">商家对用户服务费实收</th>
                        <th data-options="field:'account114',width:50,formatter:function(value,row){
					        if(row.account114==undefined || row.account114=='') {
					        	return '加载中..';
					        } else {
					        	return row.account114;
					        }
						}">商家服务费应付</th>
                        <th data-options="field:'account115',width:50,formatter:function(value,row){
					        if(row.account115==undefined || row.account115=='') {
					        	return '加载中..';
					        } else {
					        	return row.account115;
					        }
						}">商家服务费实付</th>

				    </tr>
			    </thead>
		    </table>
	    	
	    	<!-- 费率配置 -->
		    <div id="ratedlg" class="easyui-dialog" style="width: 600px; height: 400px; padding: 0;" closed="true">
			 	<div class="easyui-layout" fit="true">
				    <div data-options="region:'center', border:false">
				        <table id="dgRate" fit="true" class="easyui-datagrid" title="" 
						    data-options="
						    iconCls: 'icon-tip',
						    singleSelect: true,
						    url: '',
						    fitColumns:true,
						    toolbar: '#tbRate',
						    method: 'post',
						    onClickCell:onClickCell
				    	">
				    		<thead>
							    <tr>
							    	<th data-options="field:'id',width:100,hidden:true">主键ID</th>
							    	<th data-options="field:'installment',width:100">分期期数</th>
							    	<th data-options="field:'rate',width:100">分期费率</th>
							    	<th data-options="field:'rateForInvestment',width:200">分期费率出资方分成比例</th>
							    	<th data-options="field:'rateForPlat',width:200">分期费率平台分成比例</th>
							    	<th data-options="field:'rateForMerchant',width:200">分期费率商家分成比例</th>
							    	<th data-options="field:'prepayRate',width:100">预付款比例</th>
							    </tr>
				    		</thead>
				    	</table>
				    </div>
			 	</div>
			 </div>
	    	
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
						    toolbar: '#tbAccount',
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
								        if(row.type=='110') {
								        	return '商家本金应收';
								        } else if(row.type=='111') {
								        	return '商家本金实收';
								        } else if(row.type=='112') {
								        	return '商家对用户服务费应收';
								        } else if(row.type=='113') {
								        	return '商家对用户服务费实收';
								        } else if(row.type=='114') {
								        	return '商家服务费应付';
								        } else if(row.type=='115') {
								        	return '商家服务费实付';
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
