/**
 * Created with IntelliJ IDEA. User: lubing1 Date: 14-3-20 Time: 下午7:37 To
 * change this template use File | Settings | File Templates.
 */
var updateAuditStatus = "updateAuditStatus.json";
var queryRefundAudit = "queryRefundAudit.do";
var batchUpdateAuditStatus = "batchUpdateAuditStatus.json";
var exportCvs = "exportExcel.do";
var exportManCvs = "exportArtificialExcel.do";
var artificalRefundUpdate = "updateArtificalRefund.do";
var updateRefundStatusForRefundfaildUrl = "updateRefundStatusForRefundfaild.do";

//代付数据信息补全
var infoCompleteUpdate = "orderCancel.do";
var subscribeDetail = "detail.do";


//paydetail中的ext1
var cardId = null;

function selectSelection(val) {
	$("#refundStatus").val(val);
}

// 退款--填写人工退款处理信息
function updateArtificalRefund() {
	var currentPage = $("#currentPage").attr("value");
	var patrnStr = /^([0-9]|_)+$/;
	var payType = $("#payType").val();
	var shouZhi = $("#shouZhi").val();
	var currency = $("#currency").val();

	// alert(payType+"=="+shouZhi+"--"+currency);
	var bankAccount = $("#bankAccount").val();
	var amount = $("#amount").val();
	var bankBusinessNo = $("#bankBusinessNo").val();
	var type = $("#type").val();
	var remark = $("#remark").val();

	var businessNo = $("#businessNoTd").html();
	var payId = $("#payIdTd").html();
	var auditor = $("#auditorTd").html();
	// alert(bankAccount
	// +"--"+amount+"--"+bankBusinessNo+"--"+bankAccount+"--"+type+"--"+remark+"--"+businessNo+"--"+payId+"--"+auditor);

	if (bankAccount.length < 0 || !patrnStr.test(bankAccount)) {
		bootbox.alert("您输入的银行账号不正确，请重新输入");
		$("#bankAccount").val("");
		return;
	}

	if (amount.length < 0
			|| (!(/^-?[0-9]+(.[0-9]{1,3})?$/.test(amount) || /^-?[0-9]*$/
					.test(amount)))) {
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
			currency : currency,
			bankAccount : bankAccount,
			amount : amount,
			bankBusinessNo : bankBusinessNo,
			type : type,
			remark : remark,
			businessNo : businessNo,
			payId : payId,
			auditor : auditor
		},
		dataType : "json",
		cache : false,
		success : function(json) {
			if (json.result) {
				// alert(json+"true");
				bootbox.alert("确认退款操作成功");
				location.href = queryRefundAudit + "?currentPage="
						+ currentPage;
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

// 退款--填写人工退款处理信息
function clearModalData() {
	$("#bankAccount").val("");
	$("#amount").val("");
	$("#bankBusinessNo").val("");
	$("#bankAccount").val("");
	$("#type").val("");
	$("#remark").val("");

}

// 退款--填写人工退款处理信息
function showModal(businessNo, payId, auditor) {
	// alert(businessNo+"--"+payId+"--"+auditor);
	var businessNoTd = $("#businessNoTd").html(businessNo);
	var payIdTd = $("#payIdTd").html(payId);
	var auditorTd = $("#auditorTd").html(auditor);
}

// 代付--清空信息补全显示页面
function clearModalInfoCompleteData() {
	$("#cardId").val("");
	$("#cardName").val("");
}

// viewCardInfo
function viewCardInfo(businessNo, phone, refundRule) {
	// 先清空之前的数据信息
	$("#viewBusinessNo").val("");
	$("#viewCity").val("");
	$("#viewPhone").val("");
	$("#viewCardNo").val("");
	$("#viewName").val("");
	$("#viewHolderId").val("");
	$("#viewBrachBankName").val("");

	$("#viewPhone").html(phone);
	$("#viewBusinessNo").html(businessNo);

	if (refundRule != "") {
		var cardNameValue = refundRule.cardName;
		var provinceValue = refundRule.provice;
		var provinceNameValue = refundRule.proviceName;
		var cityValue = refundRule.city;
		var cityNameValue = refundRule.cityName;

		var bankNoValue = refundRule.bankNo;
		var bankNameValue = refundRule.bankName;
		var cardNum = refundRule.cardNum;
		var holderId = refundRule.holderId;

		if (provinceNameValue != "" && provinceNameValue != undefined) {
			$("#viewProvince").html(
					provinceNameValue + "(" + provinceValue + ")");
		}
		if (cityNameValue != "" && cityNameValue != undefined) {
			$("#viewCity").html(cityNameValue + "(" + cityValue + ")");
		}
		// 银行卡号
		$("#viewCardNo").html(cardNum);
		// 姓名
		$("#viewName").html(cardNameValue);
		// 身份证
		$("#viewHolderId").html(holderId);
		// 支行名称
		if (bankNameValue != "" && bankNameValue != undefined) {
			$("#viewBrachBankName").html(bankNameValue + "(" + bankNoValue + ")");
		}
	}
}

//查询卡信息
function getCardInfo(pin,cardId){
	 jQuery.ajax(
		     {
		         type:"POST",  
		         url:"getCardInfo.do",  
		         dataType:"json",
		         cache : false,
		         data:{"pin":pin,"cardId":cardId},//要发送的数据  
		         success:function(jsonresult){
		                      var objects = jsonresult ;
		                       if(objects == null){
		                    	   return false;
		                       }
		                       //alert(objects.cardNo);
		                       //退款申请单号
		                       $("#cardNum").val(objects.cardNo); 
		                   	  $("#userName").val(objects.holderName);
		                   	  $("#phone").val(objects.phone);
		         },//end success 
		    error:function(jsonresult){
		    	  //alert("查询卡信息失败！");
		        }    
		    });//end ajaxpost  
}


//订单取消
//203-银行理财网银快捷 232-银行理财连连代扣  
function orderCancel(status){
	if("0" == status || "1" == status || "2" == status || "20" == status || "93" == status){
		var payEnum =  $("#payEnumHidden").val();
		//alert(payEnum);
		if("" == payEnum || null == payEnum){
			alert("无法取得支付信息，请稍后重试！");
			return;
		}else if("203" == payEnum){
			 if (confirm("确定取消订单？")) {
				 orderCancelForShortCut();
	       }else{
	      	 return false;
	       }
		}else if("232" == payEnum ){
			$("#showLianLianModel").click();
		}
	}else{
		alert("当前订单状态不能进行取消操作！");
		return false;
	}
}

// 代付--信息补全显示页面
function showModalInfoComplete(pin, userName, phone, cardId) {
	//alert(cardId);
	$("#cardNum").val("");
	//取卡信息
	getCardInfo(pin,cardId);
	// 先清空之前的数据信息
	 $("#pin").val(pin);
	
	$("#provice option[value='']").attr("selected", "selected");
	$("#city option[value='']").attr("selected", "selected");
	$("#bankName option[value='']").attr("selected", "selected");

	// 如果refundRule有数据信息,默认把省,市,银行自动选中.
	// alert(refundRule);
	// alert(refundRule.cardId+"--"+refundRule.cardName);
	/*
	if (refundRule != "") {
		var cardIdValue = refundRule.cardId;
		var cardNameValue = refundRule.cardName;
		var provinceValue = refundRule.provice;
		var cityValue = refundRule.city;
		var bankValue = refundRule.bankNo;
		var cardNum = refundRule.cardNum;
		var holderId = refundRule.holderId;
		// alert(bankValue+"--"+cityValue+"--"+provinceValue);
		// 设置省份选中
		$("#provice option[code='" + provinceValue + "']").attr("selected",
				"selected");
		// 设置市选中--通过省id信息加载city数据
		loadCity();
		$("#city option[value='" + cityValue + "']").attr("selected",
				"selected");
		// 设置银行选中
		loadBank();
		$("#bankName option[value='" + bankValue + "']").attr("selected",
				"selected");

		$("#cardName").val(cardNameValue);
		$("#cardId").val(cardIdValue);
		$("#cardNum").val(cardNum);
		$("#holderId").val(holderId);
	}
	*/
}


// 加载city数据
function loadCity() {
	var proviceId = $("#provice").val();
	// 通过parentId来城市数据
	var citySelected = document.getElementById("city");
	var bankSelected = document.getElementById("bankName");

	$.ajax({
		type : "POST",
		url : getCityUrl,
		async : false,
		data : {
			parentId : proviceId
		},
		dataType : "json",
		cache : false,
		success : function(json) {
			// 清空市的数据
			citySelected.options.length = 0;
			citySelected.add(new Option("请选择", ""));
			// 清空bank的数据
			bankSelected.options.length = 0;
			bankSelected.add(new Option("请选择", ""));
			// 增加数据
			$.each(json, function(i, item) {
				citySelected.add(new Option(item.name, item.cityCode));
			});
		},
		error : function() {
			alert('查询省市数据AJAX请求异常,请联系系统管理人员或重新登录！');
		}
	});
}
// 加载银行数据信息
function loadBank() {
	var jdCityCode = $("#city").val();
	var bankSelected = document.getElementById("bankName");
	var ownerBankId = $("#owerBank").val();

	if (jdCityCode != "") {
		$.ajax({
			type : "POST",
			url : getBankUrl,
			async : false,
			data : {
				jdCityCode : jdCityCode,
				ownerBankId : ownerBankId
			},
			dataType : "json",
			cache : false,
			success : function(json) {
				// 清空市的数据
				bankSelected.options.length = 0;
				bankSelected.add(new Option("请选择", ""));
				// 增加数据
				$.each(json, function(i, item) {
					bankSelected
							.add(new Option(item.bankName, item.bankNumber));
					$("#bankName option[value='" + item.bankNumber + "']")
							.attr("code", item.bankCode);
				});
			},
			error : function() {
				alert('查询银行数据AJAX请求异常,请联系系统管理人员或重新登录！');
			}
		});
	}

}


//快捷支付取消
function orderCancelForShortCut(){
	var subscribeId = $("#subscribeId").val();
	var orderId = $("#orderId").val();
	var merchantOrderNo = $("#merchantOrderNo").val();
	$.ajax({
		type : "POST",
		url : infoCompleteUpdate,
		data : {
			merchantOrderNo:merchantOrderNo
//			proviceId : codeProvice,
//			cityId : city,
//			bankName : bankName,
//			cardName : cardName,
//			bankCode : bankCode,
//			bankNo : bankNo,
		},
		dataType : "json",
		cache : false,
		success : function(json) {
			if (json =="true" || json == true) {
				// alert(json+"true");
				alert("订单取消操作成功");
				location.href = subscribeDetail + "?orderId="+ orderId;
			} else {
				// alert(json+"false");
				bootbox.alert("订单取消操作失败");
			}
			console.debug(json);
		},
		error : function() {
			alert('订单取消AJAX请求异常,请联系系统管理人员或重新登录！');
		}
	});
	
}

// 退款--信息补全显示页面-确认  并取消订单和退款
function updateInfoCompleteData() {
	var subscribeId = $("#subscribeId").val();
	var orderId = $("#orderId").val();
	var merchantOrderNo = $("#merchantOrderNo").val();
	var currentPage = $("#currentPage").attr("value");
	var patrnStr = /^([0-9]|_)+$/;

	var businessNo = $("#infoBusinessNoTd").html();
	var payId = $("#infoPayIdTd").html();
	//var orderId = $("#infoOrderIdTd").html();

	var bankNo = $("#bankName").val();
	var bankName = $("#bankName").find("option:selected").text();
	var userName = $("#userName").val();
	var provice = $("#provice").val();
	var proviceName = $("#provice").find("option:selected").text();
	var city = $("#city").val();
	var cityName = $("#city").find("option:selected").text();

	 
	// 取<option code="111"> 自定义属性的值
	var objProvice = document.getElementById("provice");
	var indexProvice = objProvice.selectedIndex;
	var codeProvice = objProvice.options[indexProvice].getAttribute("code");
	// alert(codeProvice);
	//alert("provice="+provice+" codeProvice="+codeProvice+" city="+city);return false;
	var bank = document.getElementById("bankName");
	var indexBank = bank.selectedIndex;
	var bankCode = bank.options[indexBank].getAttribute("code");
	var holderId = $("#holderId").val();
	var cardNum = $("#cardNum").val();

	// alert(provice + "--" + city + "--" + bankName);
	
	if (merchantOrderNo == ""||merchantOrderNo == null) {
		bootbox.alert("认购信息为空！");
		return;
	}

	if (provice == "") {
		bootbox.alert("请选择所在地区");
		return;
	}

	if (city == "") {
		bootbox.alert("请选择所在地区");
		return;
	}

	if (bankName == "" || bankName == "请选择") {
		bootbox.alert("请选择支行名称");
		return;
	}

	if (bankNo == "") {
		bootbox.alert("请选择支行名称");
		return;
	}

	if (userName.length < 0) {
		bootbox.alert("您输入的姓名不正确，请重新输入");
		$("#userName").val("");
		return;
	}

	if (cardNum.length < 0 ) {
		bootbox.alert("您输入的银行账号不能为空，请重新输入");
		$("#cardNum").val("");
		return;
	}

	$("#myModalInfoComplete").modal("hide");
	$.ajax({
		type : "POST",
		url : infoCompleteUpdate,
		data : {
			//provinceId
			//cityId
			//bankName
			//cardName
			//bankCode
			//bankNo 
			merchantOrderNo:merchantOrderNo,
			provinceId : codeProvice,
			cityId : city,
			bankName : bankName,
			cardName : userName,
			bankCode : bankCode,
			bankNo : bankNo
			
		},
		dataType : "json",
		cache : false,
		success : function(json) {
			if (json =="true" || json == true) {
				// alert(json+"true");
				alert("订单取消操作成功");
				location.href = subscribeDetail + "?orderId="+ orderId;
			} else {
				// alert(json+"false");
				bootbox.alert("订单取消操作失败");
			}
			console.debug(json);
		},
		error : function() {
			alert('信息补全AJAX请求异常,请联系系统管理人员或重新登录！');
		}
	});
}

// 处理人工处理退款导出
function exportManData() {
	var queryFrom = document.getElementById("searchForm");
	queryFrom.action = "/" + exportManCvs;
	queryFrom.submit();
}

// 处理导出
function exportData() {
	var queryFrom = document.getElementById("searchForm");
	queryFrom.action = "/" + exportCvs;
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
	var merchantOrderNo = $("#merchantOrderNo").val();
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
					// bootbox.alert("审核操作成功");
					location.href = queryRefundAudit + "?currentPage="
							+ currentPage + "&startTime=" + startTime
							+ "&endTime=" + endTime + "&orderId=" + orderId
							+ "&payId=" + payId + "&businessNo=" + businessNo
							+ "&auditStatus=" + auditStatus + "&refStatus="
							+ refundStatus + "&merchantOrderNo="
							+ merchantOrderNo + "&nocache=" + Math.random();
				} else {
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

// 退款失败后，财务线下已退款后，更新退款为退款成功
function updateRefundStatusForRefundfaild(businessNo, status) {

	var currentPage = $("#currentPage").attr("value");
	var startTime = $("#startTime").val().trim();
	var endTime = $("#endTime").val().trim();
	var orderId = $("#orderId").val().trim();
	var payId = $("#payId").val().trim();
	var auditStatus = $("#auditStatus").val();
	var refundStatus = $("#refStatus").val();
	var merchantOrderNo = $("#merchantOrderNo").val();

	if (confirm("确认已线下退款成功！")) {
		$.ajax({
			type : "POST",
			url : updateRefundStatusForRefundfaildUrl,
			data : {
				businessNo : businessNo,
				refStatus : status
			},
			dataType : "json",
			cache : false,
			success : function(json) {
				if (json.result) {
					// alert(json+"true");
					// bootbox.alert("审核操作成功");
					location.href = queryRefundAudit + "?currentPage="
							+ currentPage + "&startTime=" + startTime
							+ "&endTime=" + endTime + "&orderId=" + orderId
							+ "&payId=" + payId + "&businessNo=" + businessNo
							+ "&auditStatus=" + auditStatus + "&refStatus="
							+ refundStatus + "&merchantOrderNo="
							+ merchantOrderNo + "&nocache=" + Math.random();
				} else {
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
function auditRefund(id, auditStatusSuccess, payEnum) {
	var currentPage = $("#currentPage").attr("value");
	var startTime = $("#startTime").val().trim();
	var endTime = $("#endTime").val().trim();
	var orderId = $("#orderId").val().trim();
	var payId = $("#payId").val().trim();
	var businessNo = $("#businessNo").val().trim();
	var auditStatus = $("#auditStatus").val();
	var refundStatus = $("#refStatus").val();
	var merchantOrderNo = $("#merchantOrderNo").val();
	var tipText = "确定要审核吗?";
	if (auditStatusSuccess == 3) {
		tipText = "确定驳回吗?";
	}
	if (confirm(tipText)) {
		$.ajax({
			type : "POST",
			url : updateAuditStatus,
			data : {
				id : id,
				auditStatus : auditStatusSuccess,
				payEnum : payEnum
			},
			dataType : "json",
			cache : false,
			success : function(json) {
				if (json.result) {
					// alert(json+"true");
					// bootbox.alert("审核操作成功");
					location.href = queryRefundAudit + "?currentPage="
							+ currentPage + "&startTime=" + startTime
							+ "&endTime=" + endTime + "&orderId=" + orderId
							+ "&payId=" + payId + "&businessNo=" + businessNo
							+ "&auditStatus=" + auditStatus + "&refStatus="
							+ refundStatus + "&merchantOrderNo="
							+ merchantOrderNo + "&nocache=" + Math.random();
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
	queryFrom.action = "/" + queryRefundAudit;
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

// 查询所有数据
function searchShowInfo() {
	var patrnStr = /^([0-9]|_)+$/;
	var merchantOrderNo = $("#merchantOrderNo").val().trim();
	// alert("search"+merchantOrderNo);
	if (merchantOrderNo.length > 0 && !patrnStr.test(merchantOrderNo)) {
		bootbox.alert("您输入的理财订单号不正确，请重新输入");
		$("#merchantOrderNo").val("");
		return;
	}
	$("#searchForm").submit();
}
