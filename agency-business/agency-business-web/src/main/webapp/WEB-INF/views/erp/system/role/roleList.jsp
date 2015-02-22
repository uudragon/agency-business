<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<html> 

	<head>
		<meta http-equiv="Expires" content="0">   
		<meta http-equiv="Cache-Control" content="no-cache">   
		<meta http-equiv="Pragma" content="no-cache">  
		<title>系统角色维护</title>
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
	        var roleId;
	        
	        //查询角色信息
	        function searchRole() {
	        	$('#dg').datagrid('load',{
					roleName: $("#roleNameSearch").val(),
					isEnable: $("#isEnableSearch").combobox('getValue'),
				});
	        }
	        
	        //重置查询条件
	        function resetQueryCondition() {
				$("#roleNameSearch").val('');
				$("#isEnableSearch").combobox('clear');
	        }
	        
	        //新增角色信息页面初始化
	        function add() {
	        	//页面表单元素初始化值
	        	$("#roleName").val('');
	        	$("#roleType").combobox('clear');
	        	$("#isEnable").val('');
	        	
				//设置对话框标题	        	
	            $("#dlg").dialog("open").dialog('setTitle', '新增角色信息');
	            url = "${pageContext.request.contextPath}/erp/role/addRole";
	        }
	        
	        //修改角色信息页面初始化
	        function edit() {
	            var row = $("#dg").datagrid("getSelected");
	            
	            if (row) {
	            	//设置对话框标题
	        		$("#dlg").dialog("open").dialog('setTitle', '修改角色信息');
	        	
	            	//加载要修改的记录，用于初始化页面表单元素
                    $("#fm").form("load", "${pageContext.request.contextPath}/erp/role/editRoleForm/" + row.id);
                    
                    url = "${pageContext.request.contextPath}/erp/role/editRole";
	            } else {
	            	$.messager.show({
	                    title: '提示',
	                    msg: "请选择一条记录！"
	                });
	            }
	        }
	        
			//删除角色信息
	        function del() {
	            var row = $('#dg').datagrid('getSelected');
	            if (row) {
                    $.messager.confirm('删除角色','确认删除吗?', function (r) {
                        if (r) {
                            $.post('${pageContext.request.contextPath}/erp/role/delRole', { id: row.id }, function (data) {
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
	        
	        //角色授权页面
	        function grantForm() {
	            var row = $("#dg").datagrid("getSelected");
	            
	            if (row) {
	            	roleId = row.id;
					
					$('#tt').tree({
						url: '${pageContext.request.contextPath}/erp/role/grantList/' + roleId
					});
	            	
	            	//设置对话框标题
	        		$("#dlg_grant").dialog("open").dialog('setTitle', '授权');
	            } else {
	            	$.messager.show({
	                    title: '提示',
	                    msg: "请选择一条记录！"
	                });
	            }
	        }
	        
	        //授权
	        function grant() {
	        	//获取选中的节点
	            var nodes = $('#tt').tree('getChecked');
	            
	            if(nodes.length != 0) {
	            	//遍历选中的节点，拼接其中的节点标识id
		            var ids = '';
		            for(var i=0; i<nodes.length; i++){
		                if (ids != '') ids = ids + ',';
		                ids = ids + nodes[i].id;
		            }
		            
		            $.post('${pageContext.request.contextPath}/erp/role/grant', {permissionIds:ids, roleId:roleId}, function (data) {
	                    if (data.result == "success") {
	                        $.messager.alert("提示信息", "授权成功");
	                        //关闭授权对话框
		        			$("#dlg_grant").dialog("close");   
	                    } else {
	                        $.messager.alert("提示信息", "授权失败");
	                    }
	                }, 'json');
	            } else {
	            	$.messager.show({ 
	                    title: '提示',
	                    msg: "你还没有选择任何权限信息！"
	                });
	            }
	        }
	        
	        //新增/修改角色信息
	        function save() {
	        	 $("#fm").form("submit", {
	                 url: url,
	                 onsubmit: function () {
	                     return $(this).form("validate");
	                 },
	                 success: function (data) {
	                	 var result = jQuery.parseJSON(data);
	                	 
	                     if (result.result == "success") {
	                         $.messager.alert("提示信息", "操作成功");
	                         
	                         //关闭添加角色对话框，同事刷新角色列表
	                         $("#dlg").dialog("close");
	                         $("#dg").datagrid("load");
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
						<td style="white-space: nowrap;">角色名称</td>
						<td><input id="roleNameSearch" name="roleNameSearch"  /></td>
						<td style="white-space: nowrap;">启用状态</td>
						<td>
							<input id="isEnableSearch" name="isEnable" class="easyui-combobox" data-options="
								valueField: 'label',
								textField: 'value',
								editable:false,
								data: [{
									label: '',
									value: '全部'
								},{
									label: '1',
									value: '启用'
								},{
									label: '2',
									value: '禁用'
								}]"/>
						</td>
						<td>
							<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search',plain:false" onclick="searchRole()"><span style="white-space: nowrap;">查询</span></a>
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
			    <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-remove',plain:true" onclick="del()">删除</a>
			    <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-tip',plain:true" onclick="grantForm()">授权</a>
		    </div>
		    
		    <!-- 角色信息表 -->
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
			    url: '${pageContext.request.contextPath}/erp/role/findRoleList',
			    onClickCell:onClickCell
			    ">
			    <thead>
				    <tr>
				    	<th data-options="field:'id',width:100,hidden:true">主键ID</th>
				    	<th data-options="field:'roleName',width:100">角色名称</th>
				    	<th data-options="field:'roleType',width:70,formatter:function(value,row){
					        if(row.roleType=='1') {
					        	return '运营人员';
					        } else if(row.roleType=='2'){
					        	return '商家';
					        } else if(row.roleType=='3'){
					        	return '出资方';
					        }
						}">角色分类</th>
					    <th data-options="field:'isEnable',width:70,formatter:function(value,row){
					        if(row.isEnable=='1') {
					        	return '启用';
					        } else {
					        	return '禁用';
					        }
						}">启用状态</th>
					    <th data-options="field:'createTime',width:200">创建时间</th>
					    <th data-options="field:'updateTime',width:200">更新时间</th>
				    </tr>
			    </thead>
		    </table>
			
			<!-- 角色信息增加/修改 -->
			<div id="dlg" class="easyui-dialog" style="width: 450px; height: 300px; padding: 10px 20px;" closed="true" buttons="#dlg-buttons">
		        <form id="fm" method="post">
			       <div class="fitem">
			           <label>角色名称</label>
			           <input id="roleName" name="roleName" class="easyui-validatebox" required="true" />
			       </div>
			       
			       <div class="fitem">
			           <label>角色分类</label>
			           <input id="roleType" name="roleType" class="easyui-combobox" required="true" data-options="
								valueField: 'label',
								textField: 'value',
								editable:false,
								data: [{
									label: '1',
									value: '运营人员'
								},{
									label: '2',
									value: '商家'
								},{
									label: '3',
									value: '出资方'
								}]"/>
			       </div>
			       
			       <div class="fitem">
			           <label>启用状态</label>
			           <input id="isEnable" name="isEnable" class="easyui-combobox" required="true" data-options="
						valueField: 'label',
						textField: 'value',
						editable:false,
						data: [{
							label: '1',
							value: '启用'
						},{
							label: '2',
							value: '禁用'
						}]" />
			       </div>
			       
			       <input type="hidden" name="id" id="id"/>
		       </form>
		   </div> 
		
			<div id="dlg-buttons">
		        <a href="javascript:void(0)" class="easyui-linkbutton" onclick="save()" iconcls="icon-save">保存</a>
		        <a href="javascript:void(0)" class="easyui-linkbutton" onclick="javascript:$('#dlg').dialog('close')" iconcls="icon-cancel">取消</a>
		    </div>
		    
		    <!-- 授权 -->
			<div id="dlg_grant" class="easyui-dialog" style="width: 450px; height: 300px; padding: 10px 20px;" closed="true" buttons="#dlg-buttons">
			      <ul id="tt" class="easyui-tree" data-options="animate:true,checkbox:true"></ul>
		    </div> 
		
			<div id="dlg-buttons">
		        <a href="javascript:void(0)" class="easyui-linkbutton" onclick="grant()" iconcls="icon-save">授权</a>
		        <a href="javascript:void(0)" class="easyui-linkbutton" onclick="javascript:$('#dlg_grant').dialog('close')" iconcls="icon-cancel">取消</a>
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
