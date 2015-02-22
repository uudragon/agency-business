/**
 * Created with IntelliJ IDEA. User: lubing1 Date: 14-3-20 Time: 下午7:37 To
 * change this template use File | Settings | File Templates.
 */
var updateAuditStatus = "updateAuditStatus.json";
var queryRefundAudit = "queryRefundAudit.do";
var batchUpdateAuditStatus = "batchUpdateAuditStatus.json";
var exportCvs = "exportExcel.do";
var exportManCvs = "exportArtificialExcel.do";
var artificalRefundUpdate="updateArtificalRefund.do";



function selectSelection(val) {
	$("#refundStatus").val(val);
}


//退款--填写人工退款处理信息
function updateArtificalRefund()
{
	var currentPage = $("#currentPage").attr("value");
	var patrnStr = /^([0-9]|_)+$/;
	var payType = $("#payType").val();
	var shouZhi = $("#shouZhi").val();
	var currency = $("#currency").val();
	
	//alert(payType+"=="+shouZhi+"--"+currency);
	var bankAccount = $("#bankAccount").val();
	var amount = $("#amount").val();
	var bankBusinessNo= $("#bankBusinessNo").val();
	var type = $("#type").val();
	var remark = $("#remark").val();
	
	var businessNo= $("#businessNoTd").html();
	var payId = $("#payIdTd").html();
	var auditor = $("#auditorTd").html();
	//alert(bankAccount +"--"+amount+"--"+bankBusinessNo+"--"+bankAccount+"--"+type+"--"+remark+"--"+businessNo+"--"+payId+"--"+auditor);
	
	if (bankAccount.length < 0 || !patrnStr.test(bankAccount)) {
		bootbox.alert("您输入的银行账号不正确，请重新输入");
		$("#bankAccount").val("");
		return;
	}

	if (amount.length < 0 || (!(/^-?[0-9]+(.[0-9]{1,3})?$/.test(amount) || /^-?[0-9]*$/.test(amount)))) {
		bootbox.alert("您输入的金额不正确，请重新输入");
		$("#amount").val("");
		return;
	}
	if (bankBusinessNo.length < 0 || !patrnStr.test(bankBusinessNo)) {
		bootbox.alert("您输入的银行流水号不正确，请重新输入");
		$("#bankBusinessNo").val("");
		return;
	}
	
	$("#myModal").modal("hide");
	$.ajax({
		type : "POST",
		url : artificalRefundUpdate,
		data : {
			payType : payType,
			shouZhi : shouZhi,
			currency:currency,
			bankAccount:bankAccount,
			amount:amount,
			bankBusinessNo:bankBusinessNo,
			type:type,
			remark:remark,
			businessNo:businessNo,
			payId:payId,
			auditor:auditor
		},
		dataType : "json",
		cache : false,
		success : function(json) {
			if (json.result) {
				// alert(json+"true");
				bootbox.alert("确认退款操作成功");
				location.href = queryRefundAudit + "?currentPage="+ currentPage;
			} else {
				// alert(json+"false");
				bootbox.alert("确认退款操作失败");
			}
			console.debug(json);
		},
		error : function() {
			alert('AJAX请求异常');
		}
	});	
}

//退款--填写人工退款处理信息
function clearModalData()
{
	$("#bankAccount").val("");
	$("#amount").val("");
	$("#bankBusinessNo").val("");
	$("#bankAccount").val("");
	$("#type").val("");
	$("#remark").val("");
	
}

//退款--填写人工退款处理信息
function showModal(businessNo,payId,auditor){
	//alert(businessNo+"--"+payId+"--"+auditor);
	var businessNoTd= $("#businessNoTd").html(businessNo);
	var payIdTd = $("#payIdTd").html(payId);
	var auditorTd = $("#auditorTd").html(auditor);
}

//处理人工处理退款导出
function exportManData()
{
	var queryFrom = document.getElementById("searchForm");
	queryFrom.action = "/"+exportManCvs;
	queryFrom.submit();
}

// 处理导出
function exportData() {
	var queryFrom = document.getElementById("searchForm");
	queryFrom.action = "/"+exportCvs;
	queryFrom.submit();
};


// 批量审核
function batchAuditRefund() {
	// 全选
	var startTime = $("#startTime").val().trim();
	var endTime = $("#endTime").val().trim();
	var orderId = $("#orderId").val().trim();
	var payId = $("#payId").val().trim();
	var businessNo = $("#businessNo").val().trim();
	var auditStatus = $("#auditStatus").val();
	var refundStatus = $("#refStatus").val();
	
	if (confirm("确定要批量审核吗?")) {
		var ids = "";
		var orderIds = "";
		var currentPage = $("#currentPage").attr("value");
		$("[name='checkbox']:checked").each(function() {
			ids += $(this).val() + ",";
			orderIds += $(this).attr("id") + ",";
		})
		ids = ids.substring(0, ids.length - 1);
		orderIds = orderIds.substring(0, orderIds.length - 1);
		if (ids == "") {
			alert("请选择需要要批量审核的记录!");
			return false;
		}

		$.ajax({
			type : "POST",
			url : batchUpdateAuditStatus,
			data : {
				ids : ids,
				orderIds : orderIds
			},
			dataType : "json",
			cache : false,
			success : function(json) {
				if (json.result) {
					// alert(json+"true");
					// bootbox.alert("审核操作成功");
					location.href = queryRefundAudit + "?currentPage="+ currentPage+"&startTime="+startTime+"&endTime="+endTime+"&orderId="+orderId+"&payId="+payId+"&businessNo="+businessNo+"&auditStatus="+auditStatus+"&refStatus="+refundStatus;
				} else {
					// alert(json+"false");
					bootbox.alert("审核操作失败");
				}
				console.debug(json);
			},
			error : function() {
				alert('AJAX请求异常');
			}
		});
	}
}

// 审核数据
function auditRefund(id, auditStatusSuccess,payEnum) {
	var currentPage = $("#currentPage").attr("value");
	var startTime = $("#startTime").val().trim();
	var endTime = $("#endTime").val().trim();
	var orderId = $("#orderId").val().trim();
	var payId = $("#payId").val().trim();
	var businessNo = $("#businessNo").val().trim();
	var auditStatus = $("#auditStatus").val();
	var refundStatus = $("#refStatus").val();
	
	$.ajax({
		type : "POST",
		url : updateAuditStatus,
		data : {
			id : id,
			auditStatus : auditStatusSuccess,
			payEnum:payEnum
		},
		dataType : "json",
		cache : false,
		success : function(json) {
			if (json.result) {
				// alert(json+"true");
				// bootbox.alert("审核操作成功");
				location.href = queryRefundAudit + "?currentPage="+ currentPage+"&startTime="+startTime+"&endTime="+endTime+"&orderId="+orderId+"&payId="+payId+"&businessNo="+businessNo+"&auditStatus="+auditStatus+"&refStatus="+refundStatus;
			} else {
				// alert(json+"false");
				bootbox.alert("审核操作失败");
			}
			console.debug(json);
		},
		error : function() {
			alert('AJAX请求异常');
		}
	});
}
// 查询分页
function getPageData(page, type) {
	if (type == 1) {
		page--;
	} else if (type == 2) {
		page++;
	}
	var pageCount = $("#showPageCount").attr("value");
	var currentPage = $("#currentPage").attr("value");
	if (page > pageCount)
		page = pageCount;
	if (page < 1)
		page = 1;
	$("#currentPage").val(page);
	$("#searchForm").submit();
}

function insertPage() {
	var showPageNum = 9;
	var pageCount = $("#showPageCount").attr("value");
	var currentPage = $("#currentPage").attr("value");
	if (pageCount == null || pageCount == "" || pageCount == "0") {
		$("#pageCountDiv").hide();
	}
	var pageCount = parseInt($("#showPageCount").attr("value"));
	var currentPage = parseInt($("#currentPage").attr("value"));

	var beginNum = (currentPage - (showPageNum - 1) / 2) < 1 ? 1
			: (currentPage - (showPageNum - 1) / 2);
	var endNum = (currentPage + (showPageNum - 1) / 2) > pageCount ? pageCount
			: (currentPage + (showPageNum - 1) / 2);
	for ( var i = beginNum; i <= endNum; i++) {
		var li = $('<li id="' + ("page-" + i)
				+ '"><a href="#"  onclick="getPageData(' + i + ',0)">' + i
				+ '</a></li>');
		li.insertBefore($("#nextPage"));
	}
	$("#page-" + currentPage).addClass("active");
	if (pageCount == currentPage) {
		$("#nextPage").addClass("disabled");
	}
	if (1 == currentPage) {
		$("#prePage").addClass("disabled");
	}

}
$(document).ready(function() {
	insertPage();
});
// 查询
function search() {
	var patrnStr = /^([0-9]|_)+$/;
	var startTime = $("#startTime").val().trim();
	var endTime = $("#endTime").val().trim();

	var orderId = $("#orderId").val().trim();
	var payId = $("#payId").val().trim();
	var businessNo = $("#businessNo").val().trim();
	if (orderId.length > 0 && !patrnStr.test(orderId)) {
		bootbox.alert("您输入的订单号不正确，请重新输入");
		$("#orderId").val("");
		return;
	}
	if (payId.length > 0 && !patrnStr.test(payId)) {
		bootbox.alert("您输入的支付单号不正确，请重新输入");
		$("#payId").val("");
		return;
	}
	if (businessNo.length > 0 && !patrnStr.test(businessNo)) {
		bootbox.alert("您输入的退款申请单号不正确，请重新输入");
		$("#businessNo").val("");
		return;
	}

	$("#currentPage").val(1);
	var queryFrom = document.getElementById("searchForm");
	queryFrom.action = "/"+queryRefundAudit;
	$("#searchForm").submit();
}

// 全选择功能
function check() {
	var checkbox = document.getElementById("checkAll");
	if (checkbox.checked == true) {
		checkAll();
	} else {
		uncheckAll();
	}
}
// 全选数据
function checkAll() {
	var code_Values = document.getElementsByName("checkbox");
	for (i = 0; i < code_Values.length; i++) {
		if (code_Values[i].type == "checkbox") {
			code_Values[i].checked = true;
		}
	}
}
// 取消全选数据
function uncheckAll() {
	var code_Values = document.getElementsByName("checkbox");
	for (i = 0; i < code_Values.length; i++) {
		if (code_Values[i].type == "checkbox") {
			code_Values[i].checked = false;
		}
	}
}
