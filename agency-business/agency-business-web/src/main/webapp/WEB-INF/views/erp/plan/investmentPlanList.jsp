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
	        
	        //贷款单号
	        var loanId = ${loanId};
	        
	        //查询出资方分期单信息
	        function searchPlan() {
	        	$('#dg').datagrid('load',{
	        		finishPayDateStart: $("#finishPayDateStart").datetimebox('getValue'),
					finishPayDateEnd: $("#finishPayDateEnd").datetimebox('getValue'),
				<%--	investmentCode: $("#merchantCodeSearch").combobox('getValue'), --%>
					status: $("#statusSearch").combobox('getValue'),
					<%-- loanNo: $("#loanNoSearch").val(), --%>
					planNo: $("#planNoSearch").val()
				});
	        }
	        
	        //重置查询条件
	        function resetQueryCondition() {
	        	$("#finishPayDateStart").datetimebox('setValue', '');
				$("#finishPayDateEnd").datetimebox('setValue', '');
			//	$("#merchantCodeSearch").combobox('clear');
				$("#statusSearch").combobox('clear');
			//	$("#loanNoSearch").val('');
				$("#planNoSearch").val('');
	        }
	        
	        //分期单详情
	        function detailHandler() {
	        	var row = $('#dg').datagrid('getSelected');
	            if (row) {
                    //ajax获取贷款单详情，并将获得的信息加载到propertygrid组件中
		           $.ajax({ 
         				  type: "post", 
                          url: '${pageContext.request.contextPath}/erp/plan/findDeailInvestmentPlan/' + row.id, 
                          dataType: "json", 
                          success: function (data) {
                            var rows = data.rows;
                            
                            //对话框居中
			        		$("#dlg").panel("move",{top:$(document).scrollTop() + ($(window).height()-250) * 0.2}); 
			        		//设置对话框标题
			        		$("#dlg").dialog("open").dialog('setTitle', '分期单详情');
			        		
                            $('#detail').propertygrid({
							        width: 500,
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
	            	$.messager.show({   // show error message  
	                    title: '提示',
	                    msg: "请选择一条记录！"
	                });
	            }
	        }
	        
	        //分期单资金流水明细
	        function moneyDetail() {
	        	var row = $("#dg").datagrid("getSelected");
	            
	            if (row) {
			        var href = '${pageContext.request.contextPath}/erp/planMoneyDetail/list?planNo=' + row.planNo;
			        addSubTab("分期单号" + row.planNo + "的资金流水", href);
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
						<td >还款时间:</td>
						<td>
							<input type="text" editable="false" name="finishPayDateStart"  id="finishPayDateStart" class="easyui-datetimebox txt" data-options="width:140"/>
								~
							<input type="text" name="finishPayDateEnd" editable="false" id="finishPayDateEnd" class="easyui-datetimebox txt" data-options="width:140"/>
						</td>
						<%--
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
						 --%>
						<td style="white-space: nowrap;">还款状态:</td>
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
						<%-- 
						<td style="white-space: nowrap;">贷款单号:</td>
						<td><input id="loanNoSearch" name="loanNoSearch" style="width:90px;"/></td>
						--%>
						<td style="white-space: nowrap;">分期单号:</td>
						<td><input id="planNoSearch" name="planNoSearch"  style="width:190px;"/></td>
						<td>
							<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search',plain:false" onclick="searchPlan()"><span style="white-space: nowrap;">查询</span></a>
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
		        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-tip" plain="true" onclick="moneyDetail()">资金流水明细</a>
		  	</div>
		    
		    <!-- 出资方分期单信息表 -->
		    <table id="dg" fit="true" class="easyui-datagrid" title="" style="width:'1024px';height:auto" 
			    data-options="
			    iconCls: 'icon-edit',
			    pageNumber:1,
			    pageSize:15,
			    pageList: [15,30,50],
			    pagination:true,
			    showFooter: true,
			    toolbar: '#tb',
			    singleSelect: true,
			    fitColumns:true,
			    url: '${pageContext.request.contextPath}/erp/plan/findAllInvestmentPlan?loanId=' + loanId,
			    onClickCell:onClickCell
			    ">
			    <thead>
				    <tr>
				    	<th data-options="field:'id',hidden:true"></th>
				    	<th data-options="field:'loanNo',width:150">贷款单号</th>
				    	<th data-options="field:'planNo',width:150">分期单号</th>
				    	<th data-options="field:'investmentName',width:100">出资方名称</th>
				    	<th data-options="field:'merchantName',width:100">商家名称</th>
				    	<th data-options="field:'loanAmount',width:70">贷款总金额</th>
					    <th data-options="field:'curPlanNum',width:70">期数</th>
					    <th data-options="field:'amount',width:70">应还本金</th>
					    <th data-options="field:'overAmount',width:70">应还逾期</th>
					    <th data-options="field:'payAmount',width:70">已还本金</th>
					    <th data-options="field:'overPayAmount',width:70">已还逾期</th>
					    <th data-options="field:'limitPayDate',width:150">最后还款日</th>
					    <th data-options="field:'finishPayDate',width:150">还款完成时间</th>
					    <th data-options="field:'status',width:70,formatter:function(value,row){
					        if(row.status=='2') {
					        	return '申请贷款审核中';
					        } else if(row.status=='3'){
					        	return '申请贷款审核完成';
					        } else if(row.status=='4'){
					        	return '还款完毕';
					        } else if(row.status=='5'){
					        	return '结算完毕';
					        }
						}">还款状态</th>
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
