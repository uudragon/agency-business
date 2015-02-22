<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<html> 

	<head>
		<meta http-equiv="Expires" content="0">   
		<meta http-equiv="Cache-Control" content="no-cache">   
		<meta http-equiv="Pragma" content="no-cache">  
		<title>平台用户授信信息</title>
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
	        //平台用户pin
	        var platPin = ${platPin};
	    </script>
	</head>
	
    <body class="easyui-layout" data-options="fit:true,border:false">
		<div data-options="region:'north',border:false">
		</div>
		  
		<div data-options="region:'center',border:false">
		    
		    <div class="easyui-layout" data-options="fit:true,border:false">
		    	<div data-options="region:'north',border:false" style="height:100%;">
				    <!-- 授信额度信息表 -->
				    <table id="dg"  class="easyui-datagrid datagrid-body" title="" 
					    data-options="
					    iconCls: 'icon-edit',
					    pageNumber:1,
					    pageSize:15,
					    pageList: [15,30,50],
					    pagination:false,
					    idField: 'id',
		        		striped: true,
		        		showFooter: true,
					    fitColumns:true,
					    url: '${pageContext.request.contextPath}/erp/user/queryUserBalance?platPin=${platPin}',
					    onClickCell:onClickCell
					    ">
					    <thead>
						    <tr>
						    	<th data-options="field:'platPin',width:100">平台pin</th>
						    	<th data-options="field:'status',width:100,formatter:function(value,row){
							        if(row.creditType=='0') {
							        	return '不可用';
							        } else if (row.creditType=='1'){
							        	return '可用';
							        }
								}">信用状态</th>
							    <th data-options="field:'creditBalance',width:70">授信额度</th>
							    <th data-options="field:'limitBalance',width:70">剩余额度</th>
							    <th data-options="field:'creditType',width:70,formatter:function(value,row){
							        if(row.creditType=='1') {
							        	return '大额低频';
							        } else if (row.creditType=='2'){
							        	return '小额高频';
							        } else if (row.creditType=='3'){
							        	return '其它';
							        }
								}">授信类型</th>
							    <th data-options="field:'expiryDate',width:150">信用失效时间</th>
							    <th data-options="field:'currency',width:70">币种</th>
							    <th data-options="field:'creditTime',width:150">授信时间</th>
							    <th data-options="field:'remark',width:100">备注</th>
						    </tr>
					    </thead>
				    </table>
		    	</div>
		    	
		    	<div data-options="region:'center',border:false">
				    <!-- 授信额度变化明细信息表 -->
				    <table id="dg_plan" class="easyui-datagrid" title=""
					    data-options="
					    iconCls: 'icon-edit',
					    pageNumber:1,
					    pageSize:15,
					    pageList: [15,30,50],
					    pagination:true,
					    showFooter: true,
					    toolbar: '#tb_plan',
					    singleSelect: true,
					    fitColumns:true,
					    url: '${pageContext.request.contextPath}/erp/user/queryUserBalanceDetails?platPin=${platPin}',
					    onClickCell:onClickCell
					    ">
					    <thead>
						    <tr>
						    	<th data-options="field:'platPin',width:150">平台pin</th>
						    	<th data-options="field:'rfId',width:150">业务流水号</th>
						    	<th data-options="field:'rfType',width:100,formatter:function(value,row){
							        if(row.creditType=='loan') {
							        	return '贷款';
							        } else if (row.creditType=='refund'){
							        	return '退款';
							        } else if (row.creditType=='pay'){
							        	return '还款';
							        }
								}">业务类型</th>
						    	<th data-options="field:'amount',width:100">发生额</th>
						    	<th data-options="field:'limitBalance',width:70">变更之后的额度</th>
							    <th data-options="field:'creditDebitFlag',width:70,formatter:function(value,row){
							        if(row.creditDebitFlag=='1') {
							        	return '借';
							        } else if (row.creditDebitFlag=='2'){
							        	return '贷';
							        }
								}">借/贷</th>
							    <th data-options="field:'currency',width:70">币种</th>
							    <th data-options="field:'remark',width:70">备注</th>
						    </tr>
					    </thead>
				    </table>
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
