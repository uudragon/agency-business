<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<html> 

	<head>
		<meta http-equiv="Expires" content="0">   
		<meta http-equiv="Cache-Control" content="no-cache">   
		<meta http-equiv="Pragma" content="no-cache">  
		<title>出资方贷款单查询</title>
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
	        
	        //收单号
	        var orderId = ${orderId};
	        //贷款单号
	        var loanId = ${loanId};
	        
	        <%-- 
	        //查询出资方贷款单信息
	        function searchLoan() {
	        	$('#dg').datagrid('load',{
					loanId: $("#loanIdSearch").val(),
	        		productName: $("#productNameSearch").val(),
	        		investmentCode: $("#merchantCodeSearch").combobox('getValue'),

					status: $("#statusSearch").combobox('getValue')
				});
	        }
	        
	        //重置查询条件
	        function resetQueryCondition() {
	        	$("#loanIdSearch").val('');
	        	$("#productNameSearch").val('');
	        	$("#merchantCodeSearch").combobox('clear');

				$("#statusSearch").combobox('clear');
	        }
	        --%>
	        
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
	        
	        //锁定数据行（用于导出excel）
	        function lock(){
	        	var row = $("#dg").datagrid("getChecked");
	            
	            if ((row != undefined ) && (row != '') && (row != null)) {
					
					//拼接选择的贷款单的主键id(用于数据库的In查询)
					var ids = "";
					for(var index = 0; index < row.length; index++) {
						
						if(index != (row.length - 1)) {
							ids = ids + row[index].id + ","
						} else {
							ids = ids + row[index].id;
						}
					}
					
		 			$.ajax({
		                    url: '${pageContext.request.contextPath}/erp/loan/lock',
		                    data: {"ids" : ids},
		                    type: 'post',
		                    success: function(result) {
		                    	result = jQuery.parseJSON(result);
		                        if (result && (result.code == 'success')) {
		                        	$.messager.alert("提示信息", "锁定成功");
		                        	$('#dg').datagrid("reload");
		                        } else {
		                            $.messager.alert('提示信息', result.msg, 'error');
		                        }
		                    }
		            });
	            } else {
	            	$.messager.show({
	                    title: '提示',
	                    msg: "请选择要导出的数据！"
	                });
	            }
			}
	        
	        //导出excel
	        function exportExcel(){
	        	var row = $("#dg").datagrid("getChecked");
	            
	            if ((row != undefined ) && (row != '') && (row != null)) {
	            	var status = $("#statusSearch").combobox('getValue');
					var productName = $("#productNameSearch").val();
					var investmentName = $("#investmentNameSearch").val();
					var loanId = $("#loanIdSearch").val();
					
					//获取datagrid当前页号和每页显示的行数
					var grid = $('#dg');
					var options = grid.datagrid('getPager').data("pagination").options;
					var page = options.pageNumber;
					var rows = options.pageSize;
					
					//拼接选择的贷款单的主键id(用于数据库的In查询)
					var ids = "";
					for(var index = 0; index < row.length; index++) {
						
						if(index != (row.length - 1)) {
							ids = ids + row[index].id + ","
						} else {
							ids = ids + row[index].id;
						}
					}
					
		 			$.ajax({
		                    url: '${pageContext.request.contextPath}/erp/loan/exportExcel',
		                    data: {"ids" : ids},
		                    type: 'post',
		                    success: function(result) {
		                    	result = jQuery.parseJSON(result);
		                    	
		                        if (result && (result.code == 'success')) {
		                        	//$.messager.alert("提示信息", "导出成功");
		                            window.location.href="${pageContext.request.contextPath}/erp/loan/downCsv?filePath=" + result.msg;
		                        } else {
		                            $.messager.alert('提示信息', result.msg, 'error');
		                        }
		                    }
		            });
	            } else {
	            	$.messager.show({
	                    title: '提示',
	                    msg: "请选择要导出的数据！"
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
	        
	        //分期单详情
	        function planDetailHandler() {
	        	var row = $('#dg_plan').datagrid('getSelected');
	            if (row) {
                    //ajax获取分期单详情，并将获得的信息加载到propertygrid组件中
		           $.ajax({ 
         				  type: "post", 
                          url: '${pageContext.request.contextPath}/erp/plan/findDeailInvestmentPlan/' + row.id, 
                          dataType: "json", 
                          success: function (data) {
                            var rows = data.rows;
                            
                            //对话框居中
			        		$("#dlg_plan").panel("move",{top:$(document).scrollTop() + ($(window).height()-250) * 0.2}); 
			        		//设置对话框标题
			        		$("#dlg_plan").dialog("open").dialog('setTitle', '分期单详情');
			        		
                            $('#detail_plan').propertygrid({
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
							    
							$('#detail_plan').propertygrid('loadData', rows);
                   		}
                  	});
	
	            } else {
	            	$.messager.show({   // show error message  
	                    title: '提示',
	                    msg: "请选择一条记录！"
	                });
	            }
	        }

            //还款记录详情
            function operationRecordListHandler() {
                var row = $('#dg_plan').datagrid('getSelected');
                if (row) {
                    //ajax获取分期单详情，并将获得的信息加载到propertygrid组件中
                    $.ajax({
                        type: "post",
                        url: '${pageContext.request.contextPath}/erp/operationRecord/findAllPayInfoByPlanNo?planNo=' + row.planNo,
                        dataType: "json",
                        success: function (data) {
                            var operationRecordRows = data.rows;
                            var operationRecordShowRow0 ={
                                id: '0',
                                optDesc: '初始化金额',
                                baseAmount: '+ '+row.amount,
                                planFee: '+ '+(row.planFee+row.payedPlanFee+row.sterilisedPlanFee),
                                overAmount: 0,
                                desc:'',
                                createTime:row.createTime
                            };
                            var operationRecordShowRows = [];
                            if(operationRecordRows!=null && operationRecordRows.length>0){
                                for(var operationRecordRowsIndex in operationRecordRows){
                                    var targetTempoperationRecordRow = operationRecordRows[operationRecordRowsIndex];
                                    var targetTempoperationRecordShowRow={
                                        id: targetTempoperationRecordRow.id,
                                        optDesc: '',
                                        baseAmount: '  0',
                                        planFee: '  0',
                                        overAmount: '  0',
                                        createTime:targetTempoperationRecordRow.createTime
                                    };
                                    if(targetTempoperationRecordRow.bizType == 'over'){
                                        //当前 over类型只是逾期增加
                                        targetTempoperationRecordShowRow.optDesc='逾期资金增加';
                                        targetTempoperationRecordShowRow.overAmount ='+ '+ targetTempoperationRecordRow.modAmount;
                                    }
                                    if(targetTempoperationRecordRow.bizType == 'pay'){
                                        targetTempoperationRecordShowRow.optDesc='用户还款';
                                        if(targetTempoperationRecordRow.moneyType == 'payAmount'){
                                            targetTempoperationRecordShowRow.baseAmount ='- '+ targetTempoperationRecordRow.modAmount;
                                        }
                                        if(targetTempoperationRecordRow.moneyType == 'planFee'){
                                            targetTempoperationRecordShowRow.planFee ='- '+ targetTempoperationRecordRow.modAmount;
                                        }
                                        if(targetTempoperationRecordRow.moneyType == 'overPayAmount'){
                                            targetTempoperationRecordShowRow.overAmount ='- '+ targetTempoperationRecordRow.modAmount;
                                        }
                                    }
                                    if(targetTempoperationRecordRow.bizType == 'refund'){
                                        targetTempoperationRecordShowRow.optDesc='核销资金';
                                        if(targetTempoperationRecordRow.moneyType == 'sterilisedAlreadyPayAmount'){
                                            targetTempoperationRecordShowRow.baseAmount ='- '+ targetTempoperationRecordRow.modAmount;
                                        }
                                        if(targetTempoperationRecordRow.moneyType == 'sterilisedPlanFee'){
                                            targetTempoperationRecordShowRow.planFee ='- '+ targetTempoperationRecordRow.modAmount;
                                        }
                                        if(targetTempoperationRecordRow.moneyType == 'sterilisedOverAmount'){
                                            targetTempoperationRecordShowRow.overAmount ='- '+ targetTempoperationRecordRow.modAmount;
                                        }
                                    }
                                    operationRecordShowRows.push(targetTempoperationRecordShowRow);
                                }
                            }

                            //加载数据
                            $('#dlg_operationRecord_list').datagrid({
                                width: 570,
                                height: 400,
                                showGroup: false,
                                showHeader:true,
                                scrollbarSize: 0,
                                columns:[[
                                    {field:'id',title:'编号',width:50},
                                    {field:'optDesc',title:'操作',width:100},
                                    {field:'baseAmount',title:'本金',width:70},
                                    {field:'planFee',title:'手续费',width:70},
                                    {field:'overAmount',title:'逾期',width:70},
                                    {field:'desc',title:'描述',width:100},
                                    {field:'createTime',title:'时间',width:100}
                                ]]
                            });
                            $('#dlg_operationRecord_list').datagrid('loadData', operationRecordShowRows);
                            $('#dlg_operationRecord_list').datagrid('insertRow',{
                                index: 0,	// index start with 0
                                row: operationRecordShowRow0
                            });
                            //显示对话框
                            $('#dlg_operationRecord').dialog({
                                title: '资金变动详情',
                                width: 590,
                                height: 440,
                                closed: true,
                                modal: true
                            });
                            $('#dlg_operationRecord').dialog("open");

                        }
                    });

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
			<%-- 
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

						<td style="white-space: nowrap;">状态</td>
						<td>
							<input id="statusSearch" name="status" class="easyui-combobox" data-options="
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
						<td>
							<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search',plain:false" onclick="searchLoan()"><span style="white-space: nowrap;">查询</span></a>
						</td>
						<td>
							<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-undo',plain:false" onclick="resetQueryCondition()"><span style="white-space: nowrap;">重置</span></a>
						</td>
					</tr>
				</table>
			</div>
			--%>
		</div>
		  
		<div data-options="region:'center',border:false">
		    
		    <div class="easyui-layout" data-options="fit:true,border:false">
		    	<div data-options="region:'north',border:false" style="height:100%;">
		    		<div id="tb">
				        <%--<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-tip" plain="true" onclick="detailHandler()">贷款单详情</a>--%>
				        <%--
				        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-back',plain:true" onclick="plan()">分期单</a>
				        
				        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cut" plain="true" onclick="lock()">锁定</a>
				        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-sum" plain="true" onclick="exportExcel()">导出csv</a>
				         --%>
				  	</div>
				    
				    <!-- 出资方贷款单信息表 -->
				    <table id="dg"  class="easyui-datagrid datagrid-body" title="" 
					    data-options="
					    iconCls: 'icon-edit',
					  <%--  fit: false,--%>
					    pageNumber:1,
					    pageSize:15,
					    pageList: [15,30,50],
					    pagination:false,
					    idField: 'id',
		        		striped: true,
		        		showFooter: true,
					    toolbar: '#tb',
					    fitColumns:true,
					    url: '${pageContext.request.contextPath}/erp/loan/findAllInvestmentLoan?orderId=' + orderId,
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
							    <th data-options="field:'overAmount',width:70">逾期总金额</th>
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
		    	
		    	<div data-options="region:'center',border:false">
		    		<div id="tb_plan">
				        <%--<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-tip" plain="true" onclick="planDetailHandler()">分期单详情</a>--%>
                        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-tip" plain="true" onclick="operationRecordListHandler()">资金变动详情</a>
				   </div>
				    
				    <!-- 出资方分期单信息表 -->
				    <table id="dg_plan" class="easyui-datagrid" title=""
					    data-options="
					    iconCls: 'icon-edit',
					    pageNumber:1,
					    pageSize:15,
					    pageList: [15,30,50],
					    pagination:false,
					    showFooter: true,
					    toolbar: '#tb_plan',
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
						    	<th data-options="field:'amount',width:50">贷款总金额</th>
                                <th data-options="field:'allPlanFeeShow',width:50,formatter:function(value,row){
							        return row.planFee+row.payedPlanFee+row.sterilisedPlanFee
								}">手续费总金额</th>
                                <th data-options="field:'allOverAmountShow',width:50,formatter:function(value,row){
							        return row.overAmount+row.overPayAmount+row.sterilisedOverAmount
								}">逾期总金额</th>
							    <th data-options="field:'curPlanNum',width:50">期数</th>
							    <th data-options="field:'shouldPayAmount',width:50">待还本金</th>
                                <th data-options="field:'planFee',width:50">待还手续费</th>
							    <th data-options="field:'overAmount',width:70">待还逾期</th>
							    <th data-options="field:'limitPayDate',width:100">最后还款日</th>
							    <th data-options="field:'finishPayDate',width:100">还款完成时间</th>
						    </tr>
					    </thead>
				    </table>
				    
				    <!-- 出资方分期单详情 -->
					<div id="dlg_plan" class="easyui-dialog" style="width: 520px; height: auto;" closed="true" buttons="#dlg-buttons">
						 <table id="detail_plan"></table>
				   </div>
                    <!-- 还款记录单详情 -->
                    <div id="dlg_operationRecord">
                        <table id="dlg_operationRecord_list"></table>
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
