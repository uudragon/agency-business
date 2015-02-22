<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="java.util.*" %>
<%@ page import="com.jd.jr.cf.erp.domain.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta charset="UTF-8">
		<meta http-equiv="Expires" content="0">   
		<meta http-equiv="Cache-Control" content="no-cache">   
		<meta http-equiv="Pragma" content="no-cache">
		<title>京东旅游消费金融后台管理</title>
		<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/themes/default/easyui.css">
		<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/themes/icon.css">
		
		<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.8.0.min.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.easyui.min.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/js/easyui-lang-zh_CN.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/js/json.js"></script>
		
		<style type="text/css">
			   body {
					font: 12px/20px "微软雅黑", "宋体", Arial, sans-serif, Verdana, Tahoma;
					padding: 0;
					margin: 0;
				}
				
				a:link {
					text-decoration: none;
				}
				
				a:visited {
					text-decoration: none;
				}
				
				a:hover {
					text-decoration: underline;
				}
				
				a:active {
					text-decoration: none;
				}
				
				.cs-home-remark {
					padding: 10px;
				}
				
				.cs-navi-tab {
					padding: 0 0 0 10px;
					mergin:0;
					background: #ffffff;
					width:100%;
					height:30px;
					background-image:url(${pageContext.request.contextPath}/images/manage_head_bg.png);
					border:#cccccc 1px solid; 
					line-height:30px;
				}
				
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
		
		<script> 
			function addTab(title, href,icon){  
				var tt = $('#tabs');  
				title = "&nbsp;" + title + "&nbsp;";
				if (tt.tabs('exists', title)){//如果tab已经存在,则选中并刷新该tab          
					tt.tabs('select', title);  
					refreshTab({tabTitle:title,url:href});  
				} else {  
					if (href){  
						var content = '<iframe scrolling="yes" frameborder="0" src="'+href+'" style="width:100%;height:100%;"></iframe>';  
					} else {  
						var content = '未实现';  
					}  
					tt.tabs('add',{  
						title:title,  
						closable:true,  
						content:content
					});  
				}
			}
			
			//一键生效功能（点击该按钮，使得运营人员配置的数据被应用到业务系统中）
			function makeDataValid() {
				$.post('${pageContext.request.contextPath}/erp/sys/makeDataValid', function (result) {
                    if (result.success == true) {
                        $.messager.alert("提示信息", "数据生效成功");
                    } else {
                        $.messager.alert("提示信息", "数据生效失败");
                    }
                 });
			}
		</script>
	</head>
	<body>
		<div style="margin: 0"></div>
		<div class="easyui-layout" fit="true">
			<div data-options="region:'north'" style="height: 69px;background-image:url(${pageContext.request.contextPath}/images/manage_head_bg.png);">
				<img style="margin-left: 5px;height:100%" src="${pageContext.request.contextPath}/images/jd.jpg" align=left border=0 alt="后台管理系统" />
				
				<%
					Role role = (Role)request.getAttribute("role");
					if("1".equals(role.getRoleType())) {
				%>
					<div style="float:right; margin-top: 36px;margin-right: 10px;color: #CCC;">
						<a href="#" onclick="makeDataValid()" class="easyui-linkbutton" data-options="iconCls:'icon-tip',plain:true">数据生效</a>
					</div>
				<%
					}
				%>
			</div>
		
			<div data-options="region:'west',split:true" title="功能列表"
				style="width: 180px;align:'center';">
				
				<div class="easyui-accordion" style="width:100%;height:100%" fit="true">
				
					<%
					List<Permission> permissionList = (List<Permission>)request.getAttribute("permissionList");
					Map<String,List<Permission>> childPermissionMap = (Map<String,List<Permission>>)request.getAttribute("childPermissionMap");
					
					if((permissionList != null) && (permissionList.size() != 0)) {
						for(int i = 0; i < permissionList.size(); i++){
							Permission permission = permissionList.get(i);
					%>
					<div title="<%=permission.getPermissionName() %>">
					<%
						//获取直接下级权限
						List<Permission> childPermissionList = childPermissionMap.get(permission.getId().toString());
						if((childPermissionList != null) && (childPermissionList.size() != 0)) {
							for(int k =0; k < childPermissionList.size(); k++) {
								Permission childPermission = childPermissionList.get(k);
					%>
								<div class="cs-navi-tab">
									<a href="#" onclick="addTab('<%=childPermission.getPermissionName() %>','${pageContext.request.contextPath}/erp<%=childPermission.getUrl() %>','')"><span
										style="font-size: 14px"><%=childPermission.getPermissionName() %></span></a>
							     </div>
					<%
							}
						}
					%>
					</div>	
					<%
						}
					}
					%>
					
					<%-- 
					<div title="商家管理">
						<div class="cs-navi-tab">
						<a href="#" onclick="addTab('商家信息维护','${pageContext.request.contextPath}/merchant/list','')"><span
								style="font-size: 14px">商家信息维护</span></a>
					     </div>
					     <div class="cs-navi-tab">
						<a href="#" onclick="addTab('商家商户号配置','${pageContext.request.contextPath}/merchantNo/list/1/manage','')"><span
								style="font-size: 14px">商家商户号配置</span></a>
					     </div>
	
					     <div class="cs-navi-tab">
							<a href="#" onclick="addTab('商家商户号查询','${pageContext.request.contextPath}/merchantNo/list/1/query','')"><span
								style="font-size: 14px">商家商户号查询</span></a>
					     </div>
					     
					     <div class="cs-navi-tab">
		                   <a href="#" onclick="addTab('订单查询','${pageContext.request.contextPath}/order/list','')"><span
								style="font-size: 14px">订单查询</span></a>
					     </div>
					     <div class="cs-navi-tab">
		                   <a href="#" onclick="addTab('商家结算单查询','${pageContext.request.contextPath}/merchantClearing/list','')"><span
								style="font-size: 14px">商家结算单查询</span></a>
					     </div>
	
					</div>
					
	                <div title="出资方管理">
	                	<div class="cs-navi-tab">
						<a href="#" onclick="addTab('出资方信息维护','${pageContext.request.contextPath}/investment/list','')"><span
								style="font-size: 14px">出资方信息维护</span></a>
					     </div>
	                	<div class="cs-navi-tab">
						<a href="#" onclick="addTab('出资方商户号配置','${pageContext.request.contextPath}/merchantNo/list/2/manage','')"><span
								style="font-size: 14px">出资方商户号配置</span></a>
					     </div>
	
					     <div class="cs-navi-tab">
							<a href="#" onclick="addTab('出资方商户号查询','${pageContext.request.contextPath}/merchantNo/list/2/query','')"><span
								style="font-size: 14px">出资方商户号查询</span></a>
					     </div>
						
						<div class="cs-navi-tab">
		                   <a href="#" onclick="addTab('贷款单查询','${pageContext.request.contextPath}/loan/list','')"><span
								style="font-size: 14px">贷款单查询</span></a>
					     </div>
		
					    <div class="cs-navi-tab">
						 <a href="#" onclick="addTab('分期单查询','${pageContext.request.contextPath}/plan/list','')"><span
								style="font-size: 14px">分期单查询</span></a>
					     </div>
				     
					     <div class="cs-navi-tab">
						 <a href="#" onclick="addTab('逾期查询','${pageContext.request.contextPath}/overdue/list','')"><span
								style="font-size: 14px">逾期查询</span></a>
					     </div>
					     
					     <div class="cs-navi-tab">
						 <a href="#" onclick="addTab('退款查询','${pageContext.request.contextPath}/refund/list','')"><span
								style="font-size: 14px">退款查询</span></a>
					     </div>
					     <div class="cs-navi-tab">
		                   <a href="#" onclick="addTab('出资方结算单查询','${pageContext.request.contextPath}/investmentClearing/list','')"><span
								style="font-size: 14px">出资方结算单查询</span></a>
					     </div>
	                </div>
	                
	                <div title="平台管理">
					     <div class="cs-navi-tab">
							<a href="#" onclick="addTab('平台商户号配置','${pageContext.request.contextPath}/merchantNo/list/3/manage','')"><span
								style="font-size: 14px">平台商户号配置</span></a>
					     </div>
	
					     <div class="cs-navi-tab">
							<a href="#" onclick="addTab('平台商户号查询','${pageContext.request.contextPath}/merchantNo/list/3/query','')"><span
								style="font-size: 14px">平台商户号查询</span></a>
					     </div>
					</div>
	                
	                <div title="审核管理">
	                	<div class="cs-navi-tab">
						<a href="#" onclick="addTab('贷款申请审核','${pageContext.request.contextPath}/version','')"><span
								style="font-size: 14px">贷款申请审核</span></a>
					     </div>
	                </div>
	                
	                <div title="系统管理管理">
	                	<div class="cs-navi-tab">
	                		<a href="#" onclick="addTab('用户管理','${pageContext.request.contextPath}/pinRole/list','')"><span
								style="font-size: 14px">用户管理</span></a>
					     </div>
					     
					     <div class="cs-navi-tab">
						     <a href="#" onclick="addTab('角色管理','${pageContext.request.contextPath}/role/list','')"><span
									style="font-size: 14px">角色管理</span></a>
					     </div>
					     
					     <div class="cs-navi-tab">
							<a href="#" onclick="addTab('权限管理','${pageContext.request.contextPath}/permission/list','')"><span
									style="font-size: 14px">权限管理</span></a>
					     </div>
	                </div>
	                --%>
	                
	            </div>
	            
				
			</div>
	
			<div data-options="region:'center',title:''">
				<div class="easyui-tabs" fit="true" id="tabs">
					<div class="cs-home-remark" title="欢迎页">
					<p></p>
					<p></p>
					<p></p>
					   
					</div>
				</div>
			</div>
			
			
		
			
			
		<script type="text/javascript">
	        function inputSignFile(){
	        	$("#dlg1").dialog("open").dialog('setTitle', '系统激活');
	        }
	        
	        function saveSignFile() {
		       	 $("#fm1").form("submit", {
		             url: "./register/inputSignFile",
		             onsubmit: function () {
		                 return $(this).form("validate");
		             },
		             success: function (data) {
		            	 var result = jQuery.parseJSON(data);  
		                 if (result.data.result == "success") {
		                     $.messager.alert("提示信息", "激活成功");
		                     $("#dlg1").dialog("close");
		                     $("#activateTip").html("&nbsp;&nbsp;系统状态：&nbsp;&nbsp;已激活");
		                 }
		                 else {
		                     $.messager.alert("提示信息", result.data.text);
		                 }
		             }
		         });
	       }
	        
	        
	        function editPassword() {
	            $("#dlg").dialog("open").dialog('setTitle', '修改密码');
	        }
	        
	        
	        function savePassword() {
		       	 $("#fm").form("submit", {
		             url: "./admin/editPassword",
		             onsubmit: function () {
		                 return $(this).form("validate");
		             },
		             success: function (data) {
		            	 var result = jQuery.parseJSON(data);  
		                 if (result.data.result == "success") {
		                     $.messager.alert("提示信息", "密码修改操作成功");
		                     $("#dlg").dialog("close");
		                 }
		                 else {
		                     $.messager.alert("提示信息", result.data.text);
		                 }
		             }
		         });
	        }
	        
	   </script>
	</body>
</html>