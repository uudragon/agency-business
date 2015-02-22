
var ajaxResetDuizhang = "/settle/resetDuizhang.do?callback=?";



function resetDuizhang(){
    var orderId = document.getElementById('orderId').value;
    if(confirm("confirm reset?")){
        $.ajax( {
                type : "GET",
                url : ajaxResetDuizhang,
                data : {
                    orderId:orderId
                },
                dataType : "jsonp",
                cache : false,
                success : function(json) {
                    if(json.result.isSuccess==true)
                        alert("reset ok!");
                    else
                        alert("reset faild!");
                }
            });
    }
}
