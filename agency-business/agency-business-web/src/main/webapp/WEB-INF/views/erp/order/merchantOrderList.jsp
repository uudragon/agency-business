<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<html> 

	<head>
		<meta http-equiv="Expires" content="0">   
		<meta http-equiv="Cache-Control" content="no-cache">   
		<meta http-equiv="Pragma" content="no-cache">  
		<title>商家订单查询</title>
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
			$(function(){
				$('#p').panel('close');
			});
		</script>
		
		<!-- 页面操作脚本 -->    
		<script type="text/javascript">

	        var url;
	        //商户号
	        var merchantNoId = ${merchantNoId};
            //商户号
            var merchantCode = ${merchantCode};

				
	        //查询商家订单信息
	        function searchOrder() {
	        	$('#dg').datagrid('load',{
					<%-- merchantCode: $("#merchantCodeSearch").combobox('getValue'),--%>
					status: $("#statusSearch").combobox('getValue'),
					merchantOrderDateStart: $("#merchantOrderDateStart").datetimebox('getValue'),
					merchantOrderDateEnd: $("#merchantOrderDateEnd").datetimebox('getValue')
				});
	        }
	        
	        //重置查询条件
	        function resetQueryCondition() {
				<%-- $("#merchantCodeSearch").combobox('clear'); --%>
				$("#statusSearch").combobox('clear');
				$("#merchantOrderDateStart").datetimebox('setValue', '');
				$("#merchantOrderDateEnd").datetimebox('setValue', '');
	        }
	        
	        //订单详情
	        function detailHandler() {
	            var row = $("#dg").datagrid("getSelected");
	            
	            if (row) {
					   //ajax获取订单详情，并将获得的信息加载到propertygrid组件中
			           $.ajax({ 
           					type: "post", 
                            url: '${pageContext.request.contextPath}/erp/order/findDeailMerchantOrder/' + row.id, 
                            dataType: "json", 
                            success: function (data) {
	                            var rows = data.rows;
	                            
	                            $('#detail').propertygrid({
								        width: 500,
								        height: 'auto',
								        showGroup: false,
										showHeader:false,
								        scrollbarSize: 0,
								        columns: [[
								                { field: 'name', title: 'Name', width: 100, resizable: true },
								                { field: 'value', title: 'Value', width: 100, resizable: false }
								        ]]
								    });
								    
								$('#detail').propertygrid('loadData', rows);
			    				
				        		//对话框居中
				        		$("#dlg").panel("move",{top:$(document).scrollTop() + ($(window).height()-250) * 0.2}); 
				        		//设置对话框标题
				        		$("#dlg").dialog("open").dialog('setTitle', '订单详情');
	                    	}
	                  	});
                    
	            } else {
	            	$.messager.show({
	                    title: '提示',
	                    msg: "请选择一条记录！"
	                });
	            }
	        }
	        
	        //订单查询
	        function loan() {
	        	var row = $("#dg").datagrid("getSelected");
	            
	            if (row) {
			        var href = '${pageContext.request.contextPath}/erp/loan/list?orderId=' + row.orderId;
			        addSubTab("收单号" + row.orderId + "的贷款单列表", href);
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
						<%--
						<td style="white-space: nowrap;">商家：</td>
						<td>
							<input id="merchantCodeSearch" name="merchantCodeSearch" class="easyui-combobox" 
	   							data-options="valueField:'merchantCode',textField:'merchantName',editable:false,url:'${pageContext.request.contextPath}/erp/merchant/findAllMerchantToSelect'"/>
						</td>
						 --%>
						<td style="white-space: nowrap;">订单状态:</td>
						<td>
							<input id="statusSearch" name="status" class="easyui-combobox" data-options="
								valueField: 'label',
								textField: 'value',
								editable:false,
								data: [{
									label: '1',
									value: '收单完成'
								},{
									label: '2',
									value: '申请贷款审核中'
								},{
									label: '3',
									value: '申请贷款审核完成'
								},{
									label: '4',
									value: '还款完毕'
								},{
									label: '5',
									value: '结算完毕'
								}]"/>
						</td>
						<td style="white-space: nowrap;">订单时间:</td>
						<td>
							<input type="text" editable="false" name="merchantOrderDateStart"  id="merchantOrderDateStart" class="easyui-datetimebox txt"/>
								至
							<input type="text" name="merchantOrderDateEnd" editable="false" id="merchantOrderDateEnd" class="easyui-datetimebox txt"/>
						</td>
						<td>
							<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search',plain:false" onclick="searchOrder()"><span style="white-space: nowrap;">查询</span></a>
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
		        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-tip" plain="true" onclick="detailHandler()">订单详情</a>
		        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-back',plain:true" onclick="loan()">贷款单</a>
		  	</div>
	  
		    <!-- 商家订单信息表 -->
		    <table id="dg" fit="true" class="easyui-datagrid" title="" style="width:'1024px';height:auto" 
			    data-options="
			    iconCls: 'icon-edit',
			    fit:true,
			    pageNumber:1,
			    pageSize:15,
			    pageList: [15,30,50],
			    pagination:true,
			    singleSelect: true,
			    showFooter: true,
        		striped: true,
			    toolbar: '#tb',
			    fitColumns:true,
			    url: '${pageContext.request.contextPath}/erp/order/findAllMerchantOrder?merchantCode='+merchantCode,
			    onClickCell:onClickCell
			    ">
			    <thead>
				    <tr>
				    	<th data-options="field:'id',hidden:true""></th>
				    	<th data-options="field:'merchantCode',width:70">商家商户号</th>
				    	<th data-options="field:'merchantName',width:70">商家名称</th>
				    	<th data-options="field:'merchantOrderId',width:100">商户订单号</th>
				    	<th data-options="field:'productName',width:100">商品名称</th>
				    	<th data-options="field:'orderId',width:200">收单号</th>
					    <th data-options="field:'orderType',width:70">订单类型</th>
					    <th data-options="field:'amount',width:70">订单金额</th>
					    <th data-options="field:'merchantOrderDate',width:100">订单时间</th>
					    <th data-options="field:'status',width:100,formatter:function(value,row){
					        if(row.status=='1') {
					        	return '收单完成';
					        } else if(row.status=='2') {
					        	return '申请贷款审核中';
					        } else if(row.status=='3') {
					        	return '申请贷款审核完成';
					        } else if(row.status=='5') {
					        	return '结算完毕';
					        }
						}">订单状态</th>
				    </tr>
			    </thead>
		    </table>
		    
		    <!-- 商家订单详情 -->
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
