<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<html>
  <head>
    <base href="${pageContext.request.contextPath}/">
    
    <title>My JSP 'error.jsp' starting page</title>
    
	<!-- Bootstrap Core CSS -->
    <link href="${request.contextPath}/startbootstrap/css/bootstrap.min.css" rel="stylesheet">
    <!-- MetisMenu CSS -->
    <link href="${request.contextPath}/startbootstrap/css/plugins/metisMenu/metisMenu.min.css" rel="stylesheet">
    <!-- Custom CSS -->
    <link href="${request.contextPath}/startbootstrap/css/sb-admin-2.css" rel="stylesheet">
    <!-- Custom Fonts -->
    <link href="${request.contextPath}/startbootstrap/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">
	<script type="text/javascript">
		$(function() {
			//若jQuery('#reqSource', window.parent.document)存在,则认为是该页面内容已iframe的方式嵌套在主页面index.vm中；
			//否则，认为是单独访问该页面
			//alert(jQuery('#reqSource', window.parent.document).val());
			if(jQuery('#reqSource', window.parent.document).val() == 'erpIndex'){
				//左侧导航处于"打开"状态
				if(jQuery('#leftNavOpened', window.parent.document).val() == 'yes') {
					jQuery("#page-wrapper").css('margin-left','250px');
				//左侧导航处于"关闭"状态
				}else{
					jQuery("#page-wrapper").css('margin-left','0px');
				}
			} else {
				jQuery("#page-wrapper").css('margin-left','0px');
			}
    	});
    </script>

  </head>
  
  <body>
  	<div id="wrapper" style="clear:both;">

        <div id="page-wrapper">
     		错误码:${exception.code}
	       <br/>
	       错误信息:${exception.info}
     	</div>
     </div>
  </body>
</html>
