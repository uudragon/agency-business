//系统ajax错误初始化
jQuery.ajaxSetup({
    cache:false,
    error:ajaxErrorCommmonProcess
});

$.fn.datagrid.defaults.onLoadError=ajaxErrorCommmonProcess;

function ajaxErrorCommmonProcess(targetXMLHttpRequest, targetTextStatus, targetErrorThrown){
    if(targetXMLHttpRequest.status == 404){
        $.messager.alert("提示", "请求地址不存在");
    } else {
        var errorInfo = JSON.parse(targetXMLHttpRequest.responseText);
        if(errorInfo != undefined && errorInfo != null && errorInfo.code != undefined && errorInfo.code != null){
            $.messager.alert("提示", "操作失败-"+targetXMLHttpRequest.status+"<br/>&nbsp;&nbsp;错误码:"+errorInfo.code+"<br/>&nbsp;&nbsp;错误描述:"+errorInfo.info);
        } else {
            $.messager.alert("提示", "操作失败-"+targetXMLHttpRequest.status+"<br/>&nbsp;&nbsp;错误信息:"+targetXMLHttpRequest.responseText);
        }
    }
}


//添加tab标签
function addSubTab(title, href){  
	var jq = top.jQuery;  
      
    //如果知道title的面板存在，则选中它，去更新这个面板的内容
    if (jq("#tabs").tabs('exists', title)){  
        jq("#tabs").tabs('select', title);  

        var tab = jq('#tabs').tabs('getSelect');  // get selected panel
		jq("#tabs").tabs('update', {
			tab: tab,
			options: {
				title: title,
				href: href
			}
		});
    } else {
        var content = '<iframe scrolling="auto" frameborder="0"  src="'+href+'" style="width:100%;height:100%;"></iframe>';   
        jq("#tabs").tabs('add',{  
                            title:title,  
                            content:content,  
                            closable:true  
                          });  
     }  
}
