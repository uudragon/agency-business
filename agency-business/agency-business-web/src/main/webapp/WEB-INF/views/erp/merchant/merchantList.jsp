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
			$(function(){
				$('#p').panel('close');
			});
		</script>
		
		<!-- 页面操作脚本 -->    
		<script type="text/javascript">

	        var url;
	        
	        //查询商家信息
	        function searchMeachant() {
	        	$('#dg').datagrid('load',{
					merchantCode: $("#merchantCodeSearch").val(),
					merchantName: $("#merchantNameSearch").val(),
                    linkMan: $("#linkManSearch").val(),
                    phone: $("#phoneSearch").val(),
                    mail: $("#mailSearch").val(),
                    address: $("#addressSearch").val(),
                    pinLike: $("#pinLikeSearch").val(),
                    status: $("#statusSearch").combobox('getValue')
				});
	        }
	        
	        //查询商家信息
	        function resetQueryCondition() {
				$("#merchantCodeSearch").val('');
				$("#merchantNameSearch").val('');
                $("#linkManSearch").val('');
                $("#phoneSearch").val('');
                $("#mailSearch").val('');
                $("#addressSearch").val('');
                $("#pinLikeSearch").val('');
                $("#statusSearch").combobox('setValue','');
	        }
	        
	        //新增商家信息页面初始化
	        function add() {
	        	//页面表单元素初始化值
	        	$("#merchantCode").val('');
	        	$("#merchantName").val('');
	        	$("#linkMan").val('');
	        	$("#phone").val('');
	        	$("#mail").val('');
	        	$("#address").val('');
	        	$("#merchantType").val('1');
	        	$("#maxAmount").val('');
	        	$("#pin").val('');
				
				//设置对话框标题	        	
	            $("#dlg").dialog("open").dialog('setTitle', '新增商家信息');
	            url = "${pageContext.request.contextPath}/erp/merchant/addMerchant";
	        }
	        
	        //修改商家信息页面初始化
	        function edit() {
	            var row = $("#dg").datagrid("getSelected");
	            
	            if (row) {
	            	//设置对话框标题
	        		$("#dlg").dialog("open").dialog('setTitle', '修改商家信息');
	        	
	            	//加载要修改的记录，用于初始化页面表单元素
                    $("#fm").form("load", "${pageContext.request.contextPath}/erp/merchant/editMerchantForm/" + row.merchantCode);
                    
                    url = "${pageContext.request.contextPath}/erp/merchant/editMerchant";
	            } else {
	            	$.messager.show({
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
	    </script>
	</head>
	
    <body class="easyui-layout" data-options="fit:true,border:false">
		<div data-options="region:'north',border:false">
			<!-- 查询 -->
			<div id="toolbar">
				<table class="query">
					<tr>
						<td style="white-space: nowrap;">商家编码</td>
						<td><input id="merchantCodeSearch" name="merchantCodeSearch"  /></td>
						<td style="white-space: nowrap;">商家名称</td>
						<td><input id="merchantNameSearch" name="merchantNameSearch"  /></td>
                        <td style="white-space: nowrap;">联系人</td>
                        <td><input id="linkManSearch" name="linkManSearch"  /></td>
                        <td style="white-space: nowrap;">联系电话</td>
                        <td><input id="phoneSearch" name="phoneSearch"  /></td>
                        <td style="white-space: nowrap;">邮箱</td>
                        <td><input id="mailSearch" name="mailSearch"  /></td>
					</tr>
                    <tr>
                        <td style="white-space: nowrap;">地址</td>
                        <td><input id="addressSearch" name="addressSearch"  /></td>
                        <td style="white-space: nowrap;">pin</td>
                        <td><input id="pinLikeSearch" name="pinLikeSearch"  /></td>
                        <td style="white-space: nowrap;">状态</td>
                        <td>
                            <select id="statusSearch" class="easyui-combobox" name="statusSearch" style="width:100px;">
                                <option value="">请选择</option>
                                <option value="1">已启用</option>
                                <option value="2">未启用</option>
                            </select>
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
		    </div>
		    
		    <!-- 商家信息表 -->
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
			    url: '${pageContext.request.contextPath}/erp/merchant/findAllMerchant',
			    onClickCell:onClickCell
			    ">
			    <thead>
				    <tr>
				    	<th data-options="field:'merchantCode',width:100">商家编码</th>
				    	<th data-options="field:'merchantName',width:200">商家名称</th>
					    <th data-options="field:'linkMan',width:100">联系人</th>
					    <th data-options="field:'phone',width:200">联系电话</th>
					    <th data-options="field:'mail',width:200">邮箱</th>
					    <th data-options="field:'address',width:70">地址</th>
					    <th data-options="field:'pin',width:70">pin</th>
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
			
			<!-- 商家信息增加/修改 -->
			<div id="dlg" class="easyui-dialog" style="width: 450px; height: 300px; padding: 10px 20px;" closed="true" buttons="#dlg-buttons">
		        <form id="fm" method="post">
			        <div class="fitem">
			           <label>商家编码</label>
					   <input id="merchantCode" name="merchantCode" class="easyui-validatebox" required="true" />
					</div>
			
			       <div class="fitem">
			           <label>商家名称</label>
			           <input id="merchantName" name="merchantName" class="easyui-validatebox" required="true" />
			       </div>
				   
				   <div class="fitem">
			           <label>联系人</label>
			           <input id="linkMan" name="linkMan" class="easyui-validatebox" required="true" />
			       </div>
			       
			       <div class="fitem">
			           <label>联系电话</label>
			           <input id="phone" name="phone" class="easyui-numberbox" required="true" missingMessage="请输入数字"/>
			       </div>
			       
			       <div class="fitem">
			           <label>邮箱</label>
			           <input id="mail" name="mail" class="easyui-validatebox" required="true" validType="email"/>
			       </div>
			       
			       <div class="fitem">
			           <label>地址</label>
			           <input id="address" name="address" class="easyui-validatebox" required="true" />
			       </div>
			       <div class="fitem">
			           <label>用户pin</label>
			           <input id="pin" name="pin" class="easyui-validatebox" required="true" />
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
			       <input type="hidden" name="merchantType" id="merchantType" value="1"/>
			       
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
