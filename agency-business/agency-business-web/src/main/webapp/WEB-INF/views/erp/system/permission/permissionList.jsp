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
	        var dlgMode;//用于选择上级权限对话框，标示触发弹出该选择框的功能：1--查询、2--修改
	        
	        //查询权限信息
	        function searchPermission() {
	        	$('#dg').datagrid('load',{
					permissionName: $("#permissionNameSearch").val(),
					isEnable: $("#isEnableSearch").combobox('getValue'),
					parentPermissionId: $("#parentPermissionId_query").val()
				});
	        }
	        
	        //重置查询条件
	        function resetQueryCondition() {
				$("#permissionNameSearch").val('');
				$("#isEnableSearch").combobox('clear');
				$("#parentPermissionName_query").val('');
				$("#parentPermissionId_query").val('');
	        }
	        
	        //新增权限信息页面初始化
	        function add() {
	        	//页面表单元素初始化值
	        	$("#permissionName").val('');
	        	$("#parentPermissionId").combobox('clear');
	        	$("#url").val('');
	        	$("#orderNo").val('');
	        	$("#isEnable").val('');
	        	
	        	$("#parentPermissionId").combobox('reload','${pageContext.request.contextPath}/erp/permission/findAllPermission');
				
				//设置对话框标题	        	
	            $("#dlg").dialog("open").dialog('setTitle', '新增权限信息');
	            url = "${pageContext.request.contextPath}/erp/permission/addPermission";
	        }
	        
	        //修改权限信息页面初始化
	        function edit() {
	            var row = $("#dg").datagrid("getSelected");
	            var id = row.parentPermissionId;
	            //若row代表一级权限，则row.parentPermissionId不存在，初始化id为-1
	            if(!id) {
	            	id = -1;
	            }
	            
	            if (row) {
	            	//设置对话框标题
	        		$("#dlg").dialog("open").dialog('setTitle', '修改权限信息');
	        		$("#parentPermissionId").combobox('clear');
	        		
	        		$("#parentPermissionId").combobox('reload','${pageContext.request.contextPath}/erp/permission/findAllPermission?id=' + row.id);
	        	
	            	//加载要修改的记录，用于初始化页面表单元素
                    $("#fm").form("load", "${pageContext.request.contextPath}/erp/permission/editPermissionForm/" + row.id);
                    
                    url = "${pageContext.request.contextPath}/erp/permission/editPermission";
	            } else {
	            	$.messager.show({
	                    title: '提示',
	                    msg: "请选择一条记录！"
	                });
	            }
	        }
	        
			//删除权限信息
	        function del() {
	            var row = $('#dg').datagrid('getSelected');
	            if (row) {
                    $.messager.confirm('删除权限','确认删除吗?', function (r) {
                        if (r) {
                            $.post('${pageContext.request.contextPath}/erp/permission/delPermission', { id: row.id }, function (data) {
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
	        
	        //新增/修改权限信息
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
	                         
	                         //关闭添加权限对话框，同事刷新权限列表
	                         $("#dlg").dialog("close");
	                         //$("#dg").datagrid("load");
	                         $("#dg").datagrid("reload");
	                     }
	                     else {
	                         $.messager.alert("提示信息", result.text);
	                     }
	                 }
	             });
	        }
	        
	        //选择上级权限
	        function selectParentPermissionForm(mode){
	        	dlgMode = mode;
	        	
	        	$('#tt').tree({
						url: '${pageContext.request.contextPath}/erp/permission/initPermissionTree'
					});
	            	
            	//设置对话框标题
        		$("#dlg_selectParentPermission").dialog("open").dialog('setTitle', '选择权限');
	        }
	        function selectParentPermission() {
	        	//获取选中的节点
	            var node = $('#tt').tree('getSelected');
	            
	            if(node != null) {
	            	
		            var parentPermissionId = node.id;
		            var parentPermissionName = node.text;
		            
		            if(dlgMode == '1') {
		            	$("#parentPermissionId_query").val(parentPermissionId);
		            	$("#parentPermissionName_query").val(parentPermissionName);
		            } else if(dlgMode == '2') {
		            	$("#parentPermissionId_edit").val(parentPermissionId);
		            	$("#parentPermissionName_edit").val(parentPermissionName);
		            }
		            
		            
		            //关闭对话框
		            $('#dlg_selectParentPermission').dialog('close');
		           
	            } else {
	            	$.messager.show({ 
	                    title: '提示',
	                    msg: "你还没有选择任何权限信息！"
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
						<td style="white-space: nowrap;">权限名称：</td>
						<td><input id="permissionNameSearch" name="permissionNameSearch"  /></td>
						<td style="white-space: nowrap;">启用状态：</td>
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
						<td>直接上级权限：</td>
						<td>
							<input id="parentPermissionName_query" name="parentPermissionName" onclick="selectParentPermissionForm('1')" readonly="readonly"/>
							<input id="parentPermissionId_query" name="parentPermissionId" type="hidden"/>
						</td>
						<td>
							<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search',plain:false" onclick="searchPermission()"><span style="white-space: nowrap;">查询</span></a>
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
		    </div>
		    
		    <!-- 权限信息表 -->
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
			    url: '${pageContext.request.contextPath}/erp/permission/findPermissionList',
			    onClickCell:onClickCell
			    ">
			    <thead>
				    <tr>
				    	<th data-options="field:'id',width:100,hidden:true">主键ID</th>
				    	<th data-options="field:'permissionName',width:100">权限名称</th>
				    	<th data-options="field:'parentPermissionId',width:100,hidden:true">上级权限ID</th>
				    	<th data-options="field:'parentName',width:100,formatter:function(value,row){
					        if(row.parentName=='0') {
					        	return '';
					        } else {
					        	return row.parentName;
					        }
						}">上级权限</th>
					    <th data-options="field:'url',width:200">访问地址</th>
					    <th data-options="field:'orderNo',width:200">排序号</th>
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
			
			<!-- 权限信息增加/修改 -->
			<div id="dlg" class="easyui-dialog" style="width: 450px; height: 500px; padding: 10px 20px;" closed="true" buttons="#dlg-buttons">
		        <form id="fm" method="post">
			       <div class="fitem">
			           <label>权限名称</label>
			           <input id="permissionName" name="permissionName" class="easyui-validatebox" required="true" />
			       </div>
				   
				   <div class="fitem">
			           <label>上级权限</label>
					   <input id="parentPermissionName_edit" name="parentPermissionName" onclick="selectParentPermissionForm('2')" readonly="readonly"/>
					   <input id="parentPermissionId_edit" name="parentPermissionId" type="hidden"/>
			       </div>
			       
			       <div class="fitem">
			           <label>访问地址</label>
			           <input id="url" name="url"/>
			       </div>
			       
			       <div class="fitem">
			           <label>排序号</label>
			           <input id="orderNo" name="orderNo" class="easyui-validatebox" required="true" validType="integer" />
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
	    
	    </div>
	    
	    <!-- 选择上级权限 -->
		<div id="dlg_selectParentPermission" class="easyui-dialog" style="width: 450px; height: 300px; padding: 10px 20px;" closed="true" buttons="#dlg-buttons">
		      <ul id="tt" class="easyui-tree" data-options="animate:true"></ul>
	    </div> 
		<div id="dlg-buttons">
	        <a href="javascript:void(0)" class="easyui-linkbutton" onclick="selectParentPermission()" iconcls="icon-save">确定</a>
	        <a href="javascript:void(0)" class="easyui-linkbutton" onclick="javascript:$('#dlg_selectParentPermission').dialog('close')" iconcls="icon-cancel">取消</a>
	    </div>
    
		<script type="text/javascript">
		    var editIndex = null;
			function onClickCell(index, field) {
				editIndex = index;
			}
		</script>
    </body>
    </html>
