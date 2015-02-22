<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<html> 
	<head>
		<meta http-equiv="Expires" content="0">   
		<meta http-equiv="Cache-Control" content="no-cache">   
		<meta http-equiv="Pragma" content="no-cache">  
		<title>平台商户号查询</title>
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
				});
	        }
	        
	        //重置查询条件
	        function resetQueryCondition() {
	        	$("#merchantNoSearch").val('');
	        }

            //平台商户加载成功后
            var merchantNoTableColumnFieldsWithAccount = [];
            function merchantNoDataLoadSuccess(platformMerchantRowsData){
                if(merchantNoTableColumnFieldsWithAccount.length==0){
                    var tempColumnFields = $('#dg').datagrid('getColumnFields');
                    for(var targetTempColumnsIndex in tempColumnFields){
                        var targetTempField = tempColumnFields[targetTempColumnsIndex];
                        if(targetTempField.indexOf('account1') == 0){
                            merchantNoTableColumnFieldsWithAccount.push(targetTempField);
                        }
                    }
                }

                var platformMerchantRows = platformMerchantRowsData.rows;
                for(var platformMerchantRowIndex in platformMerchantRows){
                    updatePlatformMerchantRow(platformMerchantRowIndex,platformMerchantRows);
                }
            }
            function updatePlatformMerchantRow(platformMerchantRowIndex,platformMerchantRows){
                var platformMerchantRow = platformMerchantRows[platformMerchantRowIndex];
                $.getJSON(
                        '${pageContext.request.contextPath}/erp/merchantAccount/findAllMerchantAccount?merchantNoId=' + platformMerchantRow.id + '&merchantNo=' + platformMerchantRow.merchantNo+'&date='+new Date(),
                        function(merchantAccounts){
                            var needUpdateData = {};
                            for(var merchantNoTableColumnFieldsWithAccountIndex in merchantNoTableColumnFieldsWithAccount){
                                platformMerchantRow[merchantNoTableColumnFieldsWithAccount[merchantNoTableColumnFieldsWithAccountIndex]] = '--';
                                needUpdateData[merchantNoTableColumnFieldsWithAccount[merchantNoTableColumnFieldsWithAccountIndex]] = '--';
                            }
                            for(var merchantAccountIndex in merchantAccounts){
                                var merchantAccount = merchantAccounts[merchantAccountIndex];
                                platformMerchantRow['account'+merchantAccount.type] = merchantAccount.totalAsset;
                                needUpdateData['account'+merchantAccount.type] = merchantAccount.totalAsset;
                            }

                            $('#dg').datagrid('updateRow',{
                                index: platformMerchantRowIndex,
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
			    url: '${pageContext.request.contextPath}/erp/merchantNo/findAllMerchantNo?type=3',
			    onClickCell:onClickCell,
			    onLoadSuccess:merchantNoDataLoadSuccess
			    ">
			    <thead>
				    <tr>
				    	<th data-options="field:'id',width:50,hidden:true">主键ID</th>
				    	<th data-options="field:'merchantNo',width:50">商户号</th>
				    	<th data-options="field:'merchantNoName',width:80">商户号名称</th>
					    <th data-options="field:'status',width:50,formatter:function(value,row){
					        if(row.status=='1') {
					        	return '已启用';
					        } else {
					        	return '未启用';
					        }
						}">状态</th>
                        <th data-options="field:'account116',width:50,formatter:function(value,row){
					        if(row.account116==undefined || row.account116=='') {
					        	return '加载中..';
					        } else {
					        	return row.account116;
					        }
						}">平台预付款户</th>
                        <th data-options="field:'account117',width:50,formatter:function(value,row){
					        if(row.account117==undefined || row.account117=='') {
					        	return '加载中..';
					        } else {
					        	return row.account117;
					        }
						}">平台对用户服务费应收</th>
                        <th data-options="field:'account118',width:50,formatter:function(value,row){
					        if(row.account118==undefined || row.account118=='') {
					        	return '加载中..';
					        } else {
					        	return row.account118;
					        }
						}">平台对用户服务费实收</th>
                        <th data-options="field:'account119',width:50,formatter:function(value,row){
					        if(row.account119==undefined || row.account119=='') {
					        	return '加载中..';
					        } else {
					        	return row.account119;
					        }
						}">平台对商家服务费应收</th>
                        <th data-options="field:'account120',width:50,formatter:function(value,row){
					        if(row.account120==undefined || row.account120=='') {
					        	return '加载中..';
					        } else {
					        	return row.account120;
					        }
						}">平台对商家服务费实收</th>
                        <th data-options="field:'account121',width:50,formatter:function(value,row){
					        if(row.account121==undefined || row.account121=='') {
					        	return '加载中..';
					        } else {
					        	return row.account121;
					        }
						}">平台预付款应收</th>
                        <th data-options="field:'account122',width:50,formatter:function(value,row){
					        if(row.account122==undefined || row.account122=='') {
					        	return '加载中..';
					        } else {
					        	return row.account122;
					        }
						}">平台预付款实收</th>
                        <th data-options="field:'account123',width:50,formatter:function(value,row){
					        if(row.account123==undefined || row.account123=='') {
					        	return '加载中..';
					        } else {
					        	return row.account123;
					        }
						}">平台预付款应付</th>
                        <th data-options="field:'account124',width:50,formatter:function(value,row){
					        if(row.account124==undefined || row.account124=='') {
					        	return '加载中..';
					        } else {
					        	return row.account124;
					        }
						}">平台预付款应付</th>
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
								        if(row.type=='116') {
								        	return '平台预付款户';
								        } else if(row.type=='117') {
								        	return '平台对用户服务费应收';
								        } else if(row.type=='118') {
								        	return '平台对用户服务费实收';
								        } else if(row.type=='119') {
								        	return '平台对商家服务费应收';
								        } else if(row.type=='120') {
								        	return '平台对商家服务费实收';
								        } else if(row.type=='121') {
								        	return '平台预付款应收';
								        } else if(row.type=='122') {
								        	return '平台预付款实收';
								        } else if(row.type=='123') {
								        	return '平台预付款应付';
								        } else if(row.type=='124') {
								        	return '平台预付款实付';
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
