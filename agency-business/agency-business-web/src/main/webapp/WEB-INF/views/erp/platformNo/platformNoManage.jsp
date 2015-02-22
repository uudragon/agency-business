<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<html> 
	<head>
		<meta http-equiv="Expires" content="0">   
		<meta http-equiv="Cache-Control" content="no-cache">   
		<meta http-equiv="Pragma" content="no-cache">  
		<title>平台商户号管理</title>
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
					merchantNo: $("#merchantNoSearch").val()
				});
	        }
	        
	        //重置查询条件
	        function resetQueryCondition() {
	        	$("#merchantNoSearch").val('');
	        }
	        
	        //新增商户号信息页面初始化
	        function add() {
	        	//页面表单元素初始化值
	        	$("#merchantNo").val('');
	        	$("#merchantNoName").val('');
	        	$("#status").val('');
				
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

	        //新增/修改商户号信息
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
	                         
	                         //关闭添加商户号对话框，同事刷新商户号列表
	                         $("#dlg").dialog("close");
	                         $("#dg").datagrid("load");
	                     }
	                     else {
	                         $.messager.alert("提示", "操作失败<br/>&nbsp;&nbsp;错误码:"+baseResVo.code+"<br/>&nbsp;&nbsp;错误描述:"+baseResVo.info);
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
	        
			//删除商户号账户配置信息
	        function delAccount() {
	            var row = $('#dgAccount').datagrid('getSelected');
	            if (row) {
                    $.messager.confirm('删除账户配置','确认删除吗?', function (r) {
                        if (r) {
                            $.post('${pageContext.request.contextPath}/erp/merchantAccount/delMerchantAccount', { id: row.id }, function (data) {
                                if (data.result == "success") {
                                    $('#dgAccount').datagrid("reload");   
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
	        
	        //新增/修改商户号账户配置信息
	        function saveAccount() {
	        	 $("#fmAccount").form("submit", {
	                 url: url,
	                 onsubmit: function () {
	                     return $(this).form("validate");
	                 },
	                 success: function (data) {
                         var baseResVo = jQuery.parseJSON(data);

                         if (baseResVo.isSuccess != undefined && baseResVo.isSuccess) {
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
			    url: '${pageContext.request.contextPath}/erp/merchantNo/findAllMerchantNo?type=3',
			    onClickCell:onClickCell
			    ">
			    <thead>
				    <tr>
				    	<th data-options="field:'id',width:100,hidden:true">主键ID</th>
				    	<th data-options="field:'merchantNo',width:100">商户号</th>
				    	<th data-options="field:'merchantNoName',width:100">商户号名称</th>
					    <th data-options="field:'status',width:200,formatter:function(value,row){
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
			<div id="dlg" class="easyui-dialog" style="width: 450px; height: 300px; padding: 10px 20px;" closed="true" buttons="#dlg-buttons">
		        <form id="fm" method="post">
			        <div class="fitem">
			           <label>商户号</label>
					   <input id="merchantNo" name="merchantNo" class="easyui-validatebox" required="true" />
					</div>
					<div class="fitem">
			           <label>商户号名称</label>
					   <input id="merchantNoName" name="merchantNoName" class="easyui-validatebox" required="true" />
					</div>
			       <div class="fitem">
			           <label>状态</label>
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
			       <input type="hidden" name="type" id="type" value="3"/>
			       <input type="hidden" name="serviceRate" id="serviceRate" value="0"/>
			       <input type="hidden" name="hesitationDay" id="hesitationDay" value="0"/>
		       </form>
		   </div> 
		
			<div id="dlg-buttons">
		        <a href="javascript:void(0)" class="easyui-linkbutton" onclick="save()" iconcls="icon-save">保存</a>
		        <a href="javascript:void(0)" class="easyui-linkbutton" onclick="javascript:$('#dlg').dialog('close')" iconcls="icon-cancel">取消</a>
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
				    	
				    	<!-- 商户号账户配置信息增加/修改 -->
						<div id="dlgAccountChange" class="easyui-dialog" style="width: 450px; height: 300px; padding: 10px 20px;" closed="true" buttons="#dlgAccount-buttons">
					        <form id="fmAccount" method="post">
						        <div class="fitem">
						           <label>账户</label>
								   <input id="account" name="account" class="easyui-validatebox" required="true" />
								</div>
						
						       <div class="fitem">
						           <label>账户名称</label>
						           <input id="accountName" name="accountName" class="easyui-validatebox" required="true" />
						       </div>
						       
						       <div class="fitem">
						           <label>账户所有者</label>
						           <input id="ower" name="ower" class="easyui-validatebox" required="true" />
						       </div>
						       
						       <div class="fitem">
						           <label>账户类型</label>
						           <input id="accountTypeConfig" name="type" class="easyui-combobox" required="true" data-options="
										valueField: 'label',
										textField: 'value',
										editable:false,
										data: [{
											label: '116',
											value: '平台预付款户'
										},{
											label: '117',
											value: '平台对用户服务费应收'
										},{
											label: '118',
											value: '平台对用户服务费实收'
										},{
											label: '119',
											value: '平台对商家服务费应收'
										},{
											label: '120',
											value: '平台对商家服务费实收'
										},{
											label: '121',
											value: '平台预付款应收'
										},{
											label: '122',
											value: '平台预付款实收'
										},{
											label: '123',
											value: '平台预付款应付'
										},{
											label: '124',
											value: '平台预付款实付'
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
