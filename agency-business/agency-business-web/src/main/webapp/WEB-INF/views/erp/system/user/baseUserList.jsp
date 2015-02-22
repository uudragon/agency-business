<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<html> 

	<head>
		<meta http-equiv="Expires" content="0">   
		<meta http-equiv="Cache-Control" content="no-cache">   
		<meta http-equiv="Pragma" content="no-cache">  
		<title>平台用户</title>
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
	        
	        //查询平台用户信息
	        function searchBaseUser() {
	        	$('#dg').datagrid('load',{
					idNo: $("#idNoSearch").val(),
					mobile: $("#mobileSearch").val(),
					platPin: $("#platPinSearch").val()
				});
	        }
	        
	        //重置查询条件
	        function resetQueryCondition() {
				$("#idNoSearch").val('');
				$("#mobileSearch").val('');
				$("#platPinSearch").val('');
	        }
	        
			//与平台用户相关联的归属商家用户基本信息列表
	        function creditUserList() {
	            var row = $("#dg").datagrid("getSelected");
	            
	            if (row) {
			        var href = '${pageContext.request.contextPath}/erp/user/creditUserList?platPin=' + row.platPin;
			        addSubTab("平台pin为" + row.platPin +"商家用户列表", href);
	            } else {
	            	$.messager.show({
	                    title: '提示',
	                    msg: "请选择一条记录！"
	                });
	            }
	        }  
	        
	        //与平台用户相关联的授信额度信息
	        function userBalance() {
	            var row = $("#dg").datagrid("getSelected");
	            
	            if (row) {
			        var href = '${pageContext.request.contextPath}/erp/user/userBalanceList?platPin=' + row.platPin;
			        addSubTab("平台pin为" + row.platPin +"授信列表", href);
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
						<td style="white-space: nowrap;">身份证号</td>
						<td><input id="idNoSearch" name="idNoSearch"  /></td>
						<td style="white-space: nowrap;">手机号</td>
						<td><input id="mobileSearch" name="mobileSearch"  /></td>
						<td style="white-space: nowrap;">平台pin</td>
						<td><input id="platPinSearch" name="platPinSearch"  /></td>
						<td>
							<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search',plain:false" onclick="searchBaseUser()"><span style="white-space: nowrap;">查询</span></a>
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
			    <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-tip',plain:true" onclick="creditUserList()">商家用户</a>
			    <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-tip',plain:true" onclick="userBalance()">授信额度</a>
		    </div>
		    
		    <!-- 平台用户基础信息表 -->
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
			    url: '${pageContext.request.contextPath}/erp/user/queryBaseUser',
			    onClickCell:onClickCell
			    ">
			    <thead>
				    <tr>
				    	<th data-options="field:'platPin',width:100">平台用户Pin</th>
					    <th data-options="field:'jdPin',width:100">京东用户Pin</th>
					    <th data-options="field:'status',width:70,formatter:function(value,row){
					        if(row.status=='0') {
					        	return '止付';
					        } else if(row.status=='1'){
					        	return '正常';
					        } else if(row.status=='2'){
					        	return '失效';
					        }
						}">信用状态</th>
						<th data-options="field:'realName',width:70">姓名</th>
						<th data-options="field:'nickName',width:70">别名</th>
						<th data-options="field:'idType',width:70,formatter:function(value,row){
					        if(row.idType=='1') {
					        	return '身份证';
					        } else {
					        	return '其它';
					        }
						}">证件类型</th>
						<th data-options="field:'idNo',width:100">证件号码</th>
						<th data-options="field:'mobile',width:100">手机号</th>
						<th data-options="field:'email',width:150">邮箱</th>
						<th data-options="field:'remark',width:70">备注</th>
				    </tr>
			    </thead>
		    </table>
			
	    </div>
    
		<script type="text/javascript">
		    var editIndex = null;
			function onClickCell(index, field) {
				editIndex = index;
			}
		</script>
    </body>
    </html>
