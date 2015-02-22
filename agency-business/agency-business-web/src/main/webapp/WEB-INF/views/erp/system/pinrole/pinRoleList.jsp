<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<html> 

	<head>
		<meta http-equiv="Expires" content="0">   
		<meta http-equiv="Cache-Control" content="no-cache">   
		<meta http-equiv="Pragma" content="no-cache">  
		<title>用户角色维护</title>
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
	        
	        //查询用户pin信息
	        function searchPinRole() {
	        	$('#dg').datagrid('load',{
					pin: $("#pinSearch").val()
				});
	        }
	        
	        //重置查询条件
	        function resetQueryCondition() {
				$("#pinSearch").val('');
	        }
	        
	        //新增pin和角色关系信息页面初始化
	        function add() {
	        	//页面表单元素初始化值
	        	$("#pin").val('');
	        	$("#roleId").combobox('clear');
	        	
	        	//加载角色下拉列表
	        	$("#roleId").combobox({'url':'${pageContext.request.contextPath}/erp/role/findAllRoleToSelect'});
	        	
				//设置对话框标题	        	
	            $("#dlg").dialog("open").dialog('setTitle', '新增pin和角色关系');
	            url = "${pageContext.request.contextPath}/erp/pinRole/addPinRole";
	        }
	        
	        //修改pin和角色关系页面初始化
	        function edit() {
	            var row = $("#dg").datagrid("getSelected");
	            
	            if (row) {
	            	//设置对话框标题
	        		$("#dlg").dialog("open").dialog('setTitle', '修改pin和角色关系');
	        		
	        		//加载角色下拉列表
	        		$("#roleId").combobox({'url':'${pageContext.request.contextPath}/erp/role/findAllRoleToSelect'});
	        	
	            	//加载要修改的记录，用于初始化页面表单元素
                    $("#fm").form("load", "${pageContext.request.contextPath}/erp/pinRole/editPinRoleForm/" + row.id);
                    
                    url = "${pageContext.request.contextPath}/erp/pinRole/editPinRole";
	            } else {
	            	$.messager.show({
	                    title: '提示',
	                    msg: "请选择一条记录！"
	                });
	            }
	        }
	        
			//删除pin和角色关系
	        function del() {
	            var row = $('#dg').datagrid('getSelected');
	            if (row) {
                    $.messager.confirm('删除pin和角色关系','确认删除吗?', function (r) {
                        if (r) {
                            $.post('${pageContext.request.contextPath}/erp/pinRole/delPinRole', { id: row.id }, function (data) {
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
	        
	        //新增/修改pin和角色关系
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
						<td style="white-space: nowrap;">用户pin:</td>
						<td><input id="pinSearch" name="pinSearch"  /></td>
						<td>
							<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search',plain:false" onclick="searchPinRole()"><span style="white-space: nowrap;">查询</span></a>
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
		    
		    <!-- 用户和角色关系信息表 -->
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
			    url: '${pageContext.request.contextPath}/erp/pinRole/findPinRoleList',
			    onClickCell:onClickCell
			    ">
			    <thead>
				    <tr>
				    	<th data-options="field:'id',width:100,hidden:true">主键ID</th>
				    	<th data-options="field:'pin',width:100">用户pin</th>
				    	<th data-options="field:'roleName',width:100">角色名称</th>
					    <th data-options="field:'createTime',width:200">创建时间</th>
					    <th data-options="field:'updateTime',width:200">更新时间</th>
				    </tr>
			    </thead>
		    </table>
			
			<!-- 角色信息增加/修改 -->
			<div id="dlg" class="easyui-dialog" style="width: 450px; height: 300px; padding: 10px 20px;" closed="true" buttons="#dlg-buttons">
		        <form id="fm" method="post">
			       <div class="fitem">
			           <label>用户pin</label>
			           <input id="pin" name="pin" class="easyui-validatebox" required="true" />
			       </div>
			       
			       <div class="fitem">
			           <label>所属角色</label>
					   <input id="roleId" name="roleId" class="easyui-combobox" required="true"
	   							data-options="valueField:'id',textField:'roleName',editable:false,url:'${pageContext.request.contextPath}/erp/role/findAllRoleToSelect'"/>
			       </div>
			       
			       <input type="hidden" name="id" id="id"/>
		       </form>
		   </div> 
		
			<div id="dlg-buttons">
		        <a href="javascript:void(0)" class="easyui-linkbutton" onclick="save()" iconcls="icon-save">保存</a>
		        <a href="javascript:void(0)" class="easyui-linkbutton" onclick="javascript:$('#dlg').dialog('close')" iconcls="icon-cancel">取消</a>
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
