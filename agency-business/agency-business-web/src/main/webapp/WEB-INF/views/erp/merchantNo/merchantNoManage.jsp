<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<html> 
	<head>
		<meta http-equiv="Expires" content="0">   
		<meta http-equiv="Cache-Control" content="no-cache">   
		<meta http-equiv="Pragma" content="no-cache">  
		<title>商家商户号管理</title>
		<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/themes/default/easyui.css">
		<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/themes/icon.css">
		<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/query.css">
		<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.8.0.min.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.easyui.min.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/js/easyui-lang-zh_CN.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/js/json.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/js/cferp.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/js/easyui-validatebox-extend.js"></script>
		
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
					merchantNo: $("#merchantNoSearch").val(),
					merchantId: $("#merchantIdSearch").combobox('getValue')
				});
	        }
	        
	        //重置查询条件
	        function resetQueryCondition() {
	        	$("#merchantNoSearch").val('');
				$("#merchantIdSearch").combobox('clear');
	        }
	        
	        //新增商户号信息页面初始化
	        function add() {
	        	//页面表单元素初始化值
	        	$("#merchantNo").val('');
	        	$("#merchantNoName").val('');
	        	$("#merchantId").combobox('clear');
	        	$("#investmentNoId").combobox('clear');
	        	$("#platformNoId").combobox('clear');
	        	$("#installmentFeeBearerConfig").combobox('clear');
	        	$("#serviceRate").val('');
	        	$("#serviceRateForPlat").val('');
	        	$("#serviceForRateInvestment").val('');
	        	$("#hesitationDay").val('');
	        	$("#secretKey").val('');
	        	$("#status").combobox('clear');
	        	
	        	//重新加载下拉框的值
	        	$("#merchantId").combobox('reload');
	        	$("#investmentNoId").combobox('reload');
	        	$("#platformNoId").combobox('reload');
				
				//设置对话框标题	        	
	            $("#dlg").dialog("open").dialog('setTitle', '新增商户号');
	            url = "${pageContext.request.contextPath}/erp/merchantNo/addMerchantNo";
	        }
	        
	        //修改商户号信息页面初始化
	        function edit() {
	            var row = $("#dg").datagrid("getSelected");
	            
	            if (row) {
	            	//设置对话框标题
	        		$("#dlg").dialog("open").dialog('setTitle', '修改商户号');
	        		
	        		//重新加载下拉框的值
		        	$("#merchantId").combobox('reload');
		        	$("#investmentNoId").combobox('reload');
		        	$("#platformNoId").combobox('reload');
	        		
	            	//加载要修改的记录，用于初始化页面表单元素
                    $("#fm").form("load", "${pageContext.request.contextPath}/erp/merchantNo/editMerchantNoForm/" + row.id);
                    
                    url = "${pageContext.request.contextPath}/erp/merchantNo/editMerchantNo";
	            } else {
	            	$.messager.show({
	                    title: '提示',
	                    msg: "请选择一条记录！"
	                });
	            }
	        }
	        
			//删除商户号信息
	        function del() {
	            var row = $('#dg').datagrid('getSelected');
	            if (row) {
                    $.messager.confirm('删除商户号','确认删除吗?', function (r) {
                        if (r) {
                            $.post('${pageContext.request.contextPath}/erp/merchantNo/delMerchantNo', { id: row.id }, function (data) {
                                if (data.result == "success") {
                                    $('#dg').datagrid("reload");   
                                } else {
                                    $.messager.show({   // show error message  
                                        title: '错误',
                                        msg: result.text
                                    });
                                }
                            }, 'json');
                        }
                    });
	
	            } else {
	            	$.messager.show({   // show error message  
	                    title: '提示',
	                    msg: "请选择一条记录！"
	                });
	            }
	        }  
	        
	        //新增/修改商家信息
	        function save() {
	        	 $("#fm").form("submit", {
	                 url: url,
	                 onsubmit: function () {
	                     return $(this).form("validate");
	                 },
	                 success: function (data) {
                         var baseResVo = jQuery.parseJSON(data);
	                     if (baseResVo.success != undefined && baseResVo.success) {
	                         $.messager.alert("提示信息", "操作成功");
	                         
	                         //关闭添加商家对话框，同事刷新商家列表
	                         $("#dlg").dialog("close");
	                         $("#dg").datagrid("load");
	                     }
	                     else {
	                         $.messager.alert("提示", "操作失败<br/>&nbsp;&nbsp;错误码:"+baseResVo.code+"<br/>&nbsp;&nbsp;错误描述:"+baseResVo.info);
	                     }
	                 }
	             });
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
			        $("#merchantNo_rate").val(row.merchantNo);
                    
                    //设置对话框标题
	        		$("#ratedlg").dialog("open").dialog('setTitle', '分期费率和预付款比例');
	            } else {
	            	$.messager.show({
	                    title: '提示',
	                    msg: "请选择一条记录！"
	                });
	            }
	        }
	        
	        //新增商户号费率配置信息页面初始化
	        function addRate() {
	        	//页面表单元素初始化值
	        	$("#installment").val('');
	        	$("#rateConfig").val('');
	        	$("#rateForInvestmentConfig").val('');
	        	$("#rateForPlatConfig").val('');
	        	$("#rateForMerchantConfig").val('');
	        	$("#prepayRateConfig").val('');
	        	$("#prepayOpenConfig").combobox('clear');
	        	$("#fineRate").val('');
	        	
	        	$('#prepayRateDIV').css('display','none');
				
				//设置对话框标题	        	
	            $("#dlgRateChange").dialog("open").dialog('setTitle', '新增分期费率和预付款比例');
	            url = "${pageContext.request.contextPath}/erp/merchantRate/addMerchantRate";
	        }
	        
	        //修改商户号费率配置信息页面初始化
	        function editRate() {
	            var row = $("#dgRate").datagrid("getSelected");
	            
	            if (row) {
	            	//设置对话框标题
	        		$("#dlgRateChange").dialog("open").dialog('setTitle', '修改分期费率和预付款比例');
	        		
	            	//加载要修改的记录，用于初始化页面表单元素
                    $("#fmRate").form("load", "${pageContext.request.contextPath}/erp/merchantRate/editMerchantRateForm/" + row.id);
                    
                    //ajax获取
		           	$.ajax({ 
          				   type: "get", 
                           url: '${pageContext.request.contextPath}/erp/merchantRate/editMerchantRateForm/' + row.id, 
                           dataType: "json", 
                           success: function (data) {
	                            //基于是否需要预付款，进行"预付款比例"输入项的展示和隐藏
				        		var initSelectValue = data.prepayOpen;
							
								if('1' == initSelectValue) {
									$('#prepayRateDIV').css('display','block');
								} else {
									$('#prepayRateDIV').css('display','none');
								}
		                   }
                  	});
                    
                    
                    //更新费率的url
                    url = "${pageContext.request.contextPath}/erp/merchantRate/editMerchantRate";
	            } else {
	            	$.messager.show({
	                    title: '提示',
	                    msg: "请选择一条记录！"
	                });
	            }
	        }
	        
			//删除商户号费率配置信息
	        function delRate() {
	            var row = $('#dgRate').datagrid('getSelected');
	            if (row) {
                    $.messager.confirm('删除该分期费率和预付款比例','确认删除吗?', function (r) {
                        if (r) {
                            $.post('${pageContext.request.contextPath}/erp/merchantRate/delMerchantRate', { id: row.id }, function (data) {
                                if (data.result == "success") {
                                    $('#dgRate').datagrid("reload");   
                                } else {
                                    $.messager.show({   // show error message  
                                        title: '错误',
                                        msg: result.text
                                    });
                                }
                            }, 'json');
                        }
                    });
	
	            } else {
	            	$.messager.show({   // show error message  
	                    title: '提示',
	                    msg: "请选择一条记录！"
	                });
	            }
	        }  
	        
	        //新增/修改商户号费率配置信息
	        function saveRate() {
	        	 $("#fmRate").form("submit", {
	                 url: url,
	                 onsubmit: function () {
	                     return $(this).form("validate");
	                 },
	                 success: function (data) {
	                	 var result = jQuery.parseJSON(data);
	                	 
	                     if (result.result == "success") {
	                         $.messager.alert("提示信息", "操作成功");
	                         
	                         //关闭添加费率配置对话框，同事刷新费率配置列表
	                         $("#dlgRateChange").dialog("close");
	                         $("#dgRate").datagrid("load");
	                     }
	                     else {
	                         $.messager.alert("提示信息", result.text);
	                     }
	                 }
	             });
	        }
	        
	        //账户
	        function account() {
	        	
	        	var row = $("#dg").datagrid("getSelected");
	            
	            if (row) {
	        		
	            	//加载要修改的记录，用于初始化页面表单元素
                    $("#dgAccount").datagrid({
			        	url: '${pageContext.request.contextPath}/erp/merchantAccount/findAllMerchantAccount?merchantNoId=' + row.id + '&merchantNo=' + row.merchantNo
			        });
			        
			        //设置hidden
			        $("#merchantNoId_account").val(row.id);
                    
                    //设置对话框标题
	        		$("#accountdlg").dialog("open").dialog('setTitle', '账户配置');
	            } else {
	            	$.messager.show({
	                    title: '提示',
	                    msg: "请选择一条记录！"
	                });
	            }
	        }
	        
	        //新增商户号账户配置信息页面初始化
	        function addAccount() {
	        	//页面表单元素初始化值
	        	$("#account").val('');
	        	$("#accountName").val('');
	        	$("#ower").val('');
	        	$("#accountTypeConfig").combobox('clear');
				
				//设置对话框标题	        	
	            $("#dlgAccountChange").dialog("open").dialog('setTitle', '新增账户配置');
	            url = "${pageContext.request.contextPath}/erp/merchantAccount/addMerchantAccount";
	        }
	        
	        //修改商户号账户配置信息页面初始化
	        function editAccount() {
	            var row = $("#dgAccount").datagrid("getSelected");
	            
	            if (row) {
	            	//设置对话框标题
	        		$("#dlgAccountChange").dialog("open").dialog('setTitle', '修改账户配置');
	        		
	            	//加载要修改的记录，用于初始化页面表单元素
                    $("#fmAccount").form("load", "${pageContext.request.contextPath}/erp/merchantAccount/editMerchantAccountForm/" + row.id);
                    
                    url = "${pageContext.request.contextPath}/erp/merchantAccount/editMerchantAccount";
	            } else {
	            	$.messager.show({
	                    title: '提示',
	                    msg: "请选择一条记录！"
	                });
	            }
	        }
	        
	        //新增/修改商户号账户配置信息
	        function saveAccount() {
	        	 $("#fmAccount").form("submit", {
	                 url: url,
	                 onsubmit: function () {
	                     return $(this).form("validate");
	                 },
	                 success: function (data) {
	                	 var result = jQuery.parseJSON(data);

	                     if (result.result == "success") {
	                         $.messager.alert("提示信息", "操作成功");
	                         
	                         //关闭添加账户配置对话框，同事刷新账户配置列表
	                         $("#dlgAccountChange").dialog("close");
	                         $("#dgAccount").datagrid("load");
	                     }
	                     else {
	                         $.messager.alert("提示信息", result.text);
	                     }
	                 }
	             });
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
						<td style="white-space: nowrap;">所属商家</td>
						<td>
							<input id="merchantIdSearch" name="merchantIdSearch" class="easyui-combobox" 
	   							data-options="valueField:'id',textField:'merchantName',editable:false,url:'${pageContext.request.contextPath}/erp/merchant/findAllMerchantToSelect'"/>
						</td>
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
			    <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true" onclick="add()">增加</a>
			    <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-edit',plain:true" onclick="edit()">修改</a>
			    <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-tip',plain:true" onclick="rate()">费率</a>
			    <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-sum',plain:true" onclick="account()">账户</a>
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
			    onClickCell:onClickCell
			    ">
			    <thead>
				    <tr>
				    	<th data-options="field:'id',width:100,hidden:true">主键ID</th>
				    	<th data-options="field:'merchantNo',width:100">商户号</th>
				    	<th data-options="field:'merchantNoName',width:100">商户号名称</th>
				    	<th data-options="field:'merchantName',width:200">所属商家</th>
					    <th data-options="field:'serviceRate',width:100">服务费费率</th>
					    <th data-options="field:'serviceRateForPlat',width:100">平台服务费分成比例</th>
					    <th data-options="field:'serviceForRateInvestment',width:100">出资方服务费分成比例</th>
					    <th data-options="field:'hesitationDay',width:100">犹豫期(天)</th>
					    <th data-options="field:'investmentNo',width:200">关联出资方商户号</th>
					    <th data-options="field:'platformNo',width:200">管理平台商户号</th>
					    <th data-options="field:'status',width:100,formatter:function(value,row){
					        if(row.status=='1') {
					        	return '已启用';
					        } else {
					        	return '未启用';
					        }
						}">状态</th>
				    </tr>
			    </thead>
		    </table>
			
			<!-- 商户号信息增加/修改 -->
			<div id="dlg" class="easyui-dialog" style="width: 450px; height: 500px; padding: 10px 20px;" closed="true" buttons="#dlg-buttons">
		        <form id="fm" method="post">
			        <div class="fitem">
			           <label>商户号：</label>
					   <input id="merchantNo" name="merchantNo" class="easyui-validatebox" required="true" />
					</div>
					
					<div class="fitem">
			           <label>商户号名称：</label>
					   <input id="merchantNoName" name="merchantNoName" class="easyui-validatebox" required="true" />
					</div>
			
			       <div class="fitem">
			           <label>所属商家：</label>
					   <input id="merchantId" name="merchantId" class="easyui-combobox" 
					   		data-options="valueField:'id',textField:'merchantName',editable:false,url:'${pageContext.request.contextPath}/erp/merchant/findAllMerchantToSelect'" required="true"/>
			       </div>
			       
			       <div class="fitem">
			           <label>关联出资方商户号：</label>
					   <input id="investmentNoId" name="investmentNoId" class="easyui-combobox" 
					   		data-options="valueField:'id',textField:'merchantNo',editable:false,url:'${pageContext.request.contextPath}/erp/merchantNo/findMerchantNoToSelect/2'" required="true"/>
			       </div>
			       
			       <div class="fitem">
			           <label>关联平台商户号：</label>
					   <input id="platformNoId" name="platformNoId" class="easyui-combobox" 
					   		data-options="valueField:'id',textField:'merchantNo',editable:false,url:'${pageContext.request.contextPath}/erp/merchantNo/findMerchantNoToSelect/3'" required="true"/>
			       </div>
			       
			       <%-- 
			       <div class="fitem">
			           <label>分期费用承担对象：</label>
			           <input id="installmentFeeBearerConfig" name="installmentFeeBearer" class="easyui-combobox" required="true" data-options="
							valueField: 'value',
							textField: 'label',
							editable:false,
							data: [{
								label: '商家',
								value: 'M'
							},{
								label: '消费者',
								value: 'C'
							}],
							onSelect: function(record){
								if('C' == record.value) {
									$('#serviceRateDIV').css('display','none');
								} else {
									$('#serviceRateDIV').css('display','block');
								}
							}" />
			       </div>
			       --%>
						       
			       <div id="serviceRateDIV" class="fitem">
			           <label>服务费费率：</label>
			           <input id="serviceRate" name="serviceRate" class="easyui-validatebox" validType="rate"/>
			       </div>
			       
			       <div class="fitem">
			           <label>平台服务费分成比例：</label>
			           <input id="serviceRateForPlat" name="serviceRateForPlat" class="easyui-validatebox" validType="rate"/>
			       </div>
			       
			       <div id="serviceRateDIV" class="fitem">
			           <label>出资方服务费分成比例：</label>
			           <input id="serviceForRateInvestment" name="serviceForRateInvestment" class="easyui-validatebox" validType="rate"/>
			       </div>
			       
			       <div class="fitem">
			           <label>犹豫期：</label>
			           <input id="hesitationDay" name="hesitationDay" class="easyui-validatebox" required="true" validType="integer"/>
			           <label>天</label>
			       </div>
			       
			       <div class="fitem">
			           <label>密钥：</label>
			           <input id="secretKey" name="secretKey" class="easyui-validatebox" required="true" />
			       </div>
			       
			       <div class="fitem">
			           <label>状态：</label>
					   <input id="status" name="status" class="easyui-combobox" required="true" data-options="
						valueField: 'label',
						textField: 'value',
						editable:false,
						data: [{
							label: '1',
							value: '启用'
						},{
							label: '2',
							value: '未启用'
						}]" />

					   
			       </div>
			       
			       <input type="hidden" name="id" id="id"/>
			       <input type="hidden" name="pin" id="pin" value="test"/>
			       <input type="hidden" name="type" id="type" value="1"/>
			       <input type="hidden" name="ratio" id="ratio" value="0"/>
		       </form>
		   </div> 
		
			<div id="dlg-buttons">
		        <a href="javascript:void(0)" class="easyui-linkbutton" onclick="save()" iconcls="icon-save">保存</a>
		        <a href="javascript:void(0)" class="easyui-linkbutton" onclick="javascript:$('#dlg').dialog('close')" iconcls="icon-cancel">取消</a>
		    </div>
		    
		    <!-- 费率配置 -->
		    <div id="ratedlg" class="easyui-dialog" style="width: 600px; height: 400px; padding: 0;" closed="true">
			 	<div class="easyui-layout" fit="true">
				    <div data-options="region:'center', border:false">
				    	<!-- 费率表格操作工具栏 -->
					    <div id="tbRate" style="height:auto">
						    <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true" onclick="addRate()">增加</a>
						    <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-edit',plain:true" onclick="editRate()">修改</a>
						    <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-remove',plain:true" onclick="delRate()">删除</a>
					    </div>
				    
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
							    	<th data-options="field:'fineRate',width:100">罚金费率</th>
							    </tr>
				    		</thead>
				    	</table>
				    	
				    	<!-- 商户号费率配置信息增加/修改 -->
						<div id="dlgRateChange" class="easyui-dialog" style="width: 460px; height: 300px; padding: 10px 20px;" closed="true" buttons="#dlgRate-buttons">
					        <form id="fmRate" method="post">
						        <div class="fitem">
						           <label>分期期数：</label>
								   <input id="installment" name="installment" class="easyui-validatebox" required="true" validType="integer"/>
								</div>
						
						       <div class="fitem">
						           <label>分期费率：</label>
						           <input id="rateConfig" name="rate" class="easyui-validatebox" required="true" validType="rate"/>
						       </div>
						       
						       <div class="fitem">
						           <label>分期费率出资方分成比例：</label>
						           <input id="rateForInvestmentConfig" name="rateForInvestment" class="easyui-validatebox" required="true" validType="rate"/>
						       </div>
						       
						       <div class="fitem">
						           <label>分期费率平台分成比例：</label>
						           <input id="rateForPlatConfig" name="rateForPlat" class="easyui-validatebox" required="true" validType="rate"/>
						       </div>
						       
						       <div class="fitem">
						           <label>分期费率商家分成比例：</label>
						           <input id="rateForMerchantConfig" name="rateForMerchant" class="easyui-validatebox" required="true" validType="rate"/>
						       </div>
						       
						       <div class="fitem">
						           <label>是否需要预付款：</label>
						           <input id="prepayOpenConfig" name="prepayOpen" class="easyui-combobox" required="true" data-options="
										valueField: 'value',
										textField: 'label',
										editable:false,
										data: [{
											label: '不需要',
											value: '0'
										},{
											label: '需要',
											value: '1'
										}],
										onSelect: function(record){
											if('0' == record.value) {
												$('#prepayRateDIV').css('display','none');
											} else {
												$('#prepayRateDIV').css('display','block');
											}
										}" />
						       </div>
						       
						       <div id="prepayRateDIV" class="fitem" style="display:none;">
						           <label>预付款比例：</label>
						           <input id="prepayRateConfig" name="prepayRate" class="easyui-validatebox"  validType="rate"/>
						       </div>
						       
						       <div class="fitem">
						           <label>罚金费率</label>
						           <input id="fineRate" name="fineRate" class="easyui-validatebox" required="true" validType="rate"/>
						       </div>
						       
						       <input type="hidden" name="id" id="id"/>
						       <input type="hidden" name="merchantNoId" id="merchantNoId_rate"/>
						       <input type="hidden" name="merchantNo" id="merchantNo_rate"/>
						       
					       </form>
					   </div> 
					
						<div id="dlgRate-buttons">
					        <a href="javascript:void(0)" class="easyui-linkbutton" onclick="saveRate()" iconcls="icon-save">保存</a>
					        <a href="javascript:void(0)" class="easyui-linkbutton" onclick="javascript:$('#dlgRateChange').dialog('close')" iconcls="icon-cancel">取消</a>
					    </div>
				    </div>
			 	</div>
			 </div>
	    	
	    	<!-- 账户配置 -->
		    <div id="accountdlg" class="easyui-dialog" style="width: 600px; height: 400px; padding: 0;" closed="true">
			 	<div class="easyui-layout" fit="true">
				    <div data-options="region:'center', border:false">
				    	<!-- 账户表格操作工具栏 -->
					    <div id="tbAccount" style="height:auto">
						    <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true" onclick="addAccount()">增加</a>
						    <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-edit',plain:true" onclick="editAccount()">修改</a>
						    <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-remove',plain:true" onclick="delAccount()">删除</a>
					    </div>
				    
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
				    	
				    	<!-- 商户号账户配置信息增加/修改 -->
						<div id="dlgAccountChange" class="easyui-dialog" style="width: 450px; height: 300px; padding: 10px 20px;" closed="true" buttons="#dlgAccount-buttons">
					        <form id="fmAccount" method="post">
						        <div class="fitem">
						           <label>账户：</label>
								   <input id="account" name="account" class="easyui-validatebox" required="true" />
								</div>
						
						       <div class="fitem">
						           <label>账户名称：</label>
						           <input id="accountName" name="accountName" class="easyui-validatebox" required="true" />
						       </div>
						       
						       <div class="fitem">
						           <label>账户所有者</label>
						           <input id="ower" name="ower" class="easyui-validatebox" required="true" />
						       </div>
						       
						       <div class="fitem">
						           <label>账户类型：</label>
						           <input id="accountTypeConfig" name="type" class="easyui-combobox" data-options="
										valueField: 'label',
										textField: 'value',
										editable:false,
										data: [{
											label: '110',
											value: '商家本金应收'
										},{
											label: '111',
											value: '商家本金实收'
										},{
											label: '112',
											value: '商家对用户服务费应收'
										},{
											label: '113',
											value: '商家对用户服务费实收'
										},{
											label: '114',
											value: '商家服务费应付'
										},{
											label: '115',
											value: '商家服务费实付'
										}]" />
						       </div>
						       
						       <input type="hidden" name="id" id="id"/>
						       <input type="hidden" name="merchantNoId" id="merchantNoId_account"/>
						       
					       </form>
					   </div> 
					
						<div id="dlgAccount-buttons">
					        <a href="javascript:void(0)" class="easyui-linkbutton" onclick="saveAccount()" iconcls="icon-save">保存</a>
					        <a href="javascript:void(0)" class="easyui-linkbutton" onclick="javascript:$('#dlgAccountChange').dialog('close')" iconcls="icon-cancel">取消</a>
					    </div>
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
