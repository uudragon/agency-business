<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<html> 

	<head>
		<meta http-equiv="Expires" content="0">   
		<meta http-equiv="Cache-Control" content="no-cache">   
		<meta http-equiv="Pragma" content="no-cache">  
		<title></title>
		<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/themes/default/easyui.css">
		<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/themes/icon.css">
		<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/query.css">
		<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.8.0.min.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.easyui.min.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/js/easyui-lang-zh_CN.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/js/json.js"></script>
		
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
	        //分期单号
	        var planNo = ${planNo};
	        
	        //查询分期单资金流水信息
	        function searchPlanMoneyDetail() {
	        	$('#dg').datagrid('load',{
					type: $("#typeSearch").combobox('getValue'),
					moneyType: $("#moneyTypeSearch").combobox('getValue')
				});
	        }
	        
	        //重置查询条件
	        function resetQueryCondition() {
	        	$("#typeSearch").combobox('clear');
				$("#moneyTypeSearch").combobox('clear');
	        }
	    </script>
	</head>
	
    <body class="easyui-layout" data-options="fit:true,border:false">
		<div data-options="region:'north',border:false">
			<!-- 查询 -->
			<div id="toolbar">
				<table class="query">
					<tr>
						<td style="white-space: nowrap;">业务类型:</td>
						<td>
							<input id="typeSearch" name="type" class="easyui-combobox" data-options="
								width: 90,
								valueField: 'label',
								textField: 'value',
								editable:false,
								data: [{
									label: '',
									value: '全部'
								},{
									label: '1',
									value: '还款'
								},{
									label: '2',
									value: '退款'
								}]"/>
						</td>
						<td style="white-space: nowrap;">资金类型:</td>
						<td>
							<input id="moneyTypeSearch" name="moneyType" class="easyui-combobox" data-options="
								width: 90,
								valueField: 'label',
								textField: 'value',
								editable:false,
								data: [{
									label: '',
									value: '全部'
								},{
									label: '1',
									value: '还本金'
								},{
									label: '2',
									value: '还逾期'
								},{
									label: '3',
									value: '退逾期'
								},{
									label: '4',
									value: '退本金'
								}]"/>
						</td>
						<td>
							<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search',plain:false" onclick="searchPlanMoneyDetail()"><span style="white-space: nowrap;">查询</span></a>
						</td>
						<td>
							<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-undo',plain:false" onclick="resetQueryCondition()"><span style="white-space: nowrap;">重置</span></a>
						</td>
					</tr>
				</table>
			</div>
		</div>
		  
		<div data-options="region:'center',border:false">
		    
		    <!-- 出资方分期单信息表 -->
		    <table id="dg" fit="true" class="easyui-datagrid" title="" style="width:'1024px';height:auto" 
			    data-options="
			    iconCls: 'icon-edit',
			    pageNumber:1,
			    pageSize:15,
			    pageList: [15,30,50],
			    pagination:true,
			    showFooter: true,
			    singleSelect: true,
			    fitColumns:true,
			    url: '${pageContext.request.contextPath}/erp/planMoneyDetail/findAllPlanMoneyDetail?planNo=' + planNo,
			    onClickCell:onClickCell
			    ">
			    <thead>
				    <tr>
				    	<th data-options="field:'id',hidden:true"></th>
				    	<th data-options="field:'type',width:150,formatter:function(value,row){
					        if(row.type=='1') {
					        	return '还款';
					        } else if(row.type=='2'){
					        	return '退款';
					        }
						}">业务类型</th>
				    	<th data-options="field:'moneyType',width:150,formatter:function(value,row){
					        if(row.moneyType=='1') {
					        	return '还本金';
					        } else if(row.moneyType=='2'){
					        	return '还逾期';
					        } else if(row.moneyType=='3'){
					        	return '退逾期';
					        } else if(row.moneyType=='4'){
					        	return '退本金';
					        }
						}">资金类型</th>
				    	<th data-options="field:'businessNo',width:100">业务单号</th>
				    	<th data-options="field:'loanNo',width:100">贷款单号</th>
				    	<th data-options="field:'planNo',width:70">分期单号</th>
					    <th data-options="field:'beforAmount',width:70">变化前</th>
					    <th data-options="field:'modAmount',width:70">操作值</th>
					    <th data-options="field:'afterAmount',width:70">变化后</th>
					    <th data-options="field:'note',width:70">描述</th>
				    </tr>
			    </thead>
		    </table>
		    
		    <!-- 出资方分期单详情 -->
			<div id="dlg" class="easyui-dialog" style="width: 520px; height: auto;" closed="true" buttons="#dlg-buttons">
				 <table id="detail"></table>
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
