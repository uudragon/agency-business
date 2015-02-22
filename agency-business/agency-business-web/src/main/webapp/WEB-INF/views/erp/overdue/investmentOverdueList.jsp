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

	        var url;
	        
	        //查询出资方逾期单信息
	        function searchOverdue() {
	        	$('#dg').datagrid('load',{
					status: $("#statusSearch").combobox('getValue'),
					loanNo: $("#loanNoSearch").val(),
					planNo: $("#planNoSearch").val()
				});
	        }
	        
	        //重置查询条件
	        function resetQueryCondition() {
				$("#statusSearch").combobox('clear');
				$("#loanNoSearch").val('');
				$("#planNoSearch").val('');
	        }
	        
	    </script>
	</head>
	
    <body class="easyui-layout" data-options="fit:true,border:false">
		<div data-options="region:'north',border:false">
			<!-- 查询 -->
			<div id="toolbar">
				<table class="query">
					<tr>
						<td style="white-space: nowrap;">逾期状态:</td>
						<td>
							<input id="statusSearch" name="status" class="easyui-combobox" data-options="
								width: 90,
								valueField: 'label',
								textField: 'value',
								editable:false,
								data: [{
									label: '',
									value: '全部'
								},{
									label: '1',
									value: '1'
								},{
									label: '2',
									value: '2'
								},{
									label: '3',
									value: '3'
								}]"/>
						</td>
						<td style="white-space: nowrap;">贷款单号:</td>
						<td><input id="loanNoSearch" name="loanNoSearch" style="width:190px;"/></td>
						<td style="white-space: nowrap;">分期单号:</td>
						<td><input id="planNoSearch" name="planNoSearch"  style="width:190px;"/></td>
						<td>
							<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search',plain:false" onclick="searchOverdue()"><span style="white-space: nowrap;">查询</span></a>
						</td>
						<td>
							<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-undo',plain:false" onclick="resetQueryCondition()"><span style="white-space: nowrap;">重置</span></a>
						</td>
					</tr>
				</table>
			</div>
		</div>
		  
		<div data-options="region:'center',border:false">
		    
		    <!-- 出资方逾期单信息表 -->
		    <table id="dg" fit="true" class="easyui-datagrid" title="" style="width:'1024px';height:auto" 
			    data-options="
			    iconCls: 'icon-edit',
			    pageNumber:1,
			    pageSize:15,
			    pageList: [15,30,50],
			    pagination:true,
			    singleSelect: true,
			    showFooter: true,
			    fitColumns:true,
			    url: '${pageContext.request.contextPath}/erp/overdue/findAllInvestmentOverdue',
			    onClickCell:onClickCell
			    ">
			    <thead>
				    <tr>
				    	<th data-options="field:'loanNo',width:150">贷款单号</th>
				    	<th data-options="field:'planNo',width:150">分期单号</th>
					    <th data-options="field:'orderId',width:150">收单号</th>
					    <th data-options="field:'overdueNo',width:150">逾期单号</th>
					    <th data-options="field:'amount',width:70">逾期金额</th>
					    <th data-options="field:'rate',width:70">逾期费率</th>
					    <th data-options="field:'status',width:70,formatter:function(value,row){
					        if(row.status=='1') {
					        	return '1';
					        } else if(row.status=='2'){
					        	return '2';
					        } else if(row.status=='3'){
					        	return '3';
					        }
						}">逾期状态</th>
					    <th data-options="field:'createDate',width:150">创建时间</th>
					    <th data-options="field:'updateDate',width:150">更新时间</th>
				    </tr>
			    </thead>
		    </table>
	    </div>
    
		<script type="text/javascript">
		    var editIndex = null;
			function onClickCell(index, field) {
				editIndex = index;
			}
		</script>
    </body>
    </html>
