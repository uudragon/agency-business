<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<html> 

	<head>
		<meta http-equiv="Expires" content="0">   
		<meta http-equiv="Cache-Control" content="no-cache">   
		<meta http-equiv="Pragma" content="no-cache">  
		<title>商家结算单查询</title>
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
	        
	        //查询商家结算单信息
	        function searchClearing() {
	        	$('#dg').datagrid('load',{
	        		createDateStart: $("#createDateStart").datetimebox('getValue'),
					createDateEnd: $("#createDateEnd").datetimebox('getValue'),
					merchantCode: $("#merchantCodeSearch").combobox('getValue'),
					clearingNo: $("#clearingNoSearch").val()
				});
	        }
	        
	        //重置查询条件
	        function resetQueryCondition() {
	        	$("#createDateStart").datetimebox('setValue', '');
	        	$("#createDateEnd").datetimebox('setValue', '');
	        	$("#merchantCodeSearch").combobox('clear');
	        	$("#clearingNoSearch").val('');
	        }
	        
	        //结算单详情
	        function detailHandler() {
	            var row = $('#dg').datagrid('getSelected');
	            if (row) {
	            	//所算结算单的结算单号
                    var clearingNo = row.clearingNo;
                    
                    $("#dg1").datagrid({
			        	url: '${pageContext.request.contextPath}/erp/merchantClearing/findChildByParentClearingNo?clearingNo=' + clearingNo
			        });
			        
			        $("#dlg").dialog("open").dialog('setTitle', '结算单明细');
	
	            } else {
	            	$.messager.show({   // show error message  
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
						<td style="white-space: nowrap;">创建时间：</td>
						<td>
							<input type="text" name="createDateStart" editable="false" id="createDateStart" class="easyui-datetimebox txt" data-options="width:140"/>
								~
							<input type="text" name="createDateEnd" editable="false" id="createDateEnd" class="easyui-datetimebox txt" data-options="width:140"/>
						</td>
						<td style="white-space: nowrap;">商家:</td>
						<td>
							<input id="merchantCodeSearch" name="merchantCodeSearch" class="easyui-combobox" 
	   							data-options="
	   								width: 90,
	   								valueField:'merchantCode',
	   								textField:'merchantName',
	   								editable:false,
	   								url:'${pageContext.request.contextPath}/erp/merchant/findAllMerchantToSelect'
	   							"/>
						</td>
						<td style="white-space: nowrap;">结算单号：</td>
						<td><input id="clearingNoSearch" name="clearingNoSearch"  /></td>
						<td>
							<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search',plain:false" onclick="searchClearing()"><span style="white-space: nowrap;">查询</span></a>
						</td>
						<td>
							<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-undo',plain:false" onclick="resetQueryCondition()"><span style="white-space: nowrap;">重置</span></a>
						</td>
					</tr>
				</table>
			</div>
		</div>
		  
		<div data-options="region:'center',border:false">
		    
		    <div id="tb">
		        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-tip" plain="true" onclick="detailHandler()">结算单详情</a>
		  	</div>
		    
		    <!-- 商家结算单单信息表 -->
		    <table id="dg" fit="true" class="easyui-datagrid datagrid-body" title="" 
			    data-options="
			    iconCls: 'icon-edit',
        		striped: true,
			    toolbar: '#tb',
			    fitColumns:true,
			    url: '${pageContext.request.contextPath}/erp/merchantClearing/findMerchantClearing',
			    onClickCell:onClickCell
			    ">
			    <thead>
				    <tr>
				    	<th data-options="field:'clearingNo',width:100">结算单号</th>
				    	<th data-options="field:'startEndTime',width:200">起止时间</th>
					    <th data-options="field:'merchantName',width:100">商家</th>
					    <th data-options="field:'shouldPay',width:70">本期应付</th>
					    <th data-options="field:'shouldRecive',width:70">本期应收</th>
					    <th data-options="field:'shouldClear',width:70">应结金额</th>
					    <th data-options="field:'realClear',width:70">实结金额</th>
					    <th data-options="field:'payStatus',width:70,formatter:function(value,row){
					        if(row.payStatus=='30') {
					        	return '已结算';
					        } else {
					        	return '待结算';
					        }
						}">结算状态</th>
						<th data-options="field:'payDate',width:100">付款日期</th>
				    </tr>
			    </thead>
		    </table>
		    
		    <!-- 商家结算单详情 -->
		   	<div id="dlg" class="easyui-dialog" style="width: 600px; height: 400px; padding: 0;" closed="true">
			 	<div class="easyui-layout" fit="true">
				    <div data-options="region:'center', border:false">
				        <table id="dg1" fit="true" class="easyui-datagrid" title="" 
						    data-options="
						    iconCls: 'icon-edit',
						    pageNumber:1,
						    pageSize:15,
						    pageList: [15,30,50],
						    url: '',
						    method: 'post',
						    onClickCell:onClickCell,
						    fitColumns:true,
						    pagination:true
				    	">
				    		<thead>
							    <tr>
							    	<th data-options="field:'f1',width:100">支付单号</th>
							    	<th data-options="field:'f2',width:100">贷款单号</th>
								    <th data-options="field:'f3',width:150">下单时间</th>
								    <th data-options="field:'f4',width:150">计费时间</th>
								    <th data-options="field:'f5',width:70">贷款</th>
								    <th data-options="field:'f6',width:70">佣金</th>
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
