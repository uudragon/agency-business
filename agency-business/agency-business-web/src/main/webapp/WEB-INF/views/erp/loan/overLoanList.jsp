<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<html> 

	<head>
		<meta http-equiv="Expires" content="0">   
		<meta http-equiv="Cache-Control" content="no-cache">   
		<meta http-equiv="Pragma" content="no-cache">  
		<title>逾期的贷款单</title>
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
	        
	        //查询出资方贷款单信息
	        function searchLoan() {
	        	$('#dg').datagrid('load',{
					loanId: $("#loanIdSearch").val(),
	        		productName: $("#productNameSearch").val(),
	        		investmentCode: $("#merchantCodeSearch").combobox('getValue')
				});
	        }
	        
	        //重置查询条件
	        function resetQueryCondition() {
	        	$("#loanIdSearch").val('');
	        	$("#productNameSearch").val('');
	        	$("#merchantCodeSearch").combobox('clear');
	        }
	        
	        //贷款单详情
	        function detailHandler() {
	            var row = $('#dg').datagrid('getSelected');
	            
	            if (row) {
					   //ajax获取贷款单详情，并将获得的信息加载到propertygrid组件中
			           $.ajax({ 
           					type: "post", 
                            url: '${pageContext.request.contextPath}/erp/loan/findDeailInvestmentLoan/' + row.id, 
                            dataType: "json", 
                            success: function (data) {
	                            var rows = data.rows;
	                            
	                            //对话框居中
				        		$("#dlg").panel("move",{top:$(document).scrollTop() + ($(window).height()-250) * 0.2}); 
				        		//设置对话框标题
				        		$("#dlg").dialog("open").dialog('setTitle', '贷款单详情');
				        		
	                            $('#detail').propertygrid({
								        //width: 500,
								        height: 400,
								        showGroup: false,
										showHeader:false,
								        scrollbarSize: 0,
								        columns: [[
								                { field: 'name', title: 'Name', width: 100, resizable: true },
								                { field: 'value', title: 'Value', width: 100, resizable: false }
								        ]]
								    });
								    
								$('#detail').propertygrid('loadData', rows);
			    				
				        		
	                    	}
	                  	});
                    
	            } else {
	            	$.messager.show({
	                    title: '提示',
	                    msg: "请选择一条记录！"
	                });
	            }
	        }

			//分期单查询
	        function plan() {
	        	var row = $("#dg").datagrid("getSelected");
	            
	            if (row) {
			        var href = '${pageContext.request.contextPath}/erp/plan/list?loanId=' + row.loanId;
			        addSubTab("贷款单号" + row.loanId + "的分期单列表", href);
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

						<td style="white-space: nowrap;">贷款单号</td>
						<td><input id="loanIdSearch" name="loanIdSearch"  /></td>
						
						<td style="white-space: nowrap;">出资方:</td>
						<td>
							<input id="merchantCodeSearch" name="merchantCodeSearch" class="easyui-combobox" 
	   							data-options="
	   								width: 90,
	   								valueField:'merchantCode',
	   								textField:'merchantName',
	   								editable:false,
	   								url:'${pageContext.request.contextPath}/erp/investment/findAllMerchantToSelect'
	   							"/>
						</td>
						<td style="white-space: nowrap;">商品名称</td>
						<td><input id="productNameSearch" name="productNameSearch"  /></td>
						<td>
							<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search',plain:false" onclick="searchLoan()"><span style="white-space: nowrap;">查询</span></a>
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
		       <%-- <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-tip" plain="true" onclick="detailHandler()">贷款单详情</a>  --%>
		        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-back',plain:true" onclick="plan()">分期单</a>
		  	</div>
		    
		    <!-- 出资方贷款单信息表 -->
		    <table id="dg" fit="true" class="easyui-datagrid datagrid-body" title="" 
			    data-options="
			    iconCls: 'icon-edit',
			  <%--  fit: false,--%>
			    pageNumber:1,
			    pageSize:15,
			    pageList: [15,30,50],
			    pagination:true,
			    idField: 'id',
        		striped: true,
        		showFooter: true,
			    toolbar: '#tb',
			    fitColumns:true,
			    url: '${pageContext.request.contextPath}/erp/loan/findAllInvestmentLoan?overFlag=1',
			    onClickCell:onClickCell
			    ">
			    <thead>
				    <tr>
				    	<th data-options="field:'id',hidden:true"></th>
				    	<th data-options="field:'loanId',width:100">贷款单号</th>
				    	<th data-options="field:'orderId',width:100">收单号</th>
					    <th data-options="field:'loanType',width:70">贷款类型</th>
					    <th data-options="field:'plan',width:70">分期数</th>
					    <th data-options="field:'amount',width:70">贷款金额</th>
					    <th data-options="field:'investmentName',width:100">出资方名称</th>
					    <th data-options="field:'merchantName',width:100">商家名称</th>
					    <th data-options="field:'productName',width:100">商品名称</th>
					    <th data-options="field:'payAmount',width:70">已还款金额</th>
					    <th data-options="field:'refundAmount',width:70">退款总金额</th>
					    <th data-options="field:'status',width:70,formatter:function(value,row){
					        if(row.status=='2') {
					        	return '申请贷款审核中';
					        } else if(row.status=='3') {
					        	return '申请贷款审核完成';
					        } else if(row.status=='4') {
					        	return '还款完毕';
					        } else if(row.status=='5') {
					        	return '结算完毕';
					        }
						}">贷款状态</th>
				    </tr>
			    </thead>
		    </table>

		    <!-- 出资方贷款单详情 -->
			<div id="dlg" class="easyui-dialog" style="width:500px;"  closed="true" buttons="#dlg-buttons">
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
