var getCityUrl = "getProvince.do";
var getBankUrl = "getBank.do";

// 省与市的联调
$(document).ready(
		function() {
			// 初始化省的列表数据信息
			$.ajax({
				type : "POST",
				url : getCityUrl,
				data : {
					parentId : 0
				},
				dataType : "json",
				cache : false,
				success : function(json) {
					//json =  $.parseJSON(json);
					var proviceSelected = document.getElementById("provice");
					var citySelected = document.getElementById("city");
					var bankSelected = document.getElementById("bankName");
					// 清空市的数据
					citySelected.options.length = 0;
					citySelected.add(new Option("请选择", ""));
					// 清空bank的数据
					bankSelected.options.length = 0;
					bankSelected.add(new Option("请选择", ""));

					proviceSelected.options.length = 0;
					proviceSelected.add(new Option("请选择", ""));

					// 增加数据
					$.each(json, function(i, item) {
						proviceSelected.add(new Option(item.name, item.id));
						$("#provice option[value='" + item.id + "']").attr("code", item.provinceCode);
					});
				},
				error : function() {
					alert('查询省市数据AJAX请求异常,请联系系统管理人员或重新登录！');
				}
			});

			// 为省增加事件
			$('#provice').change(
					function() {
						var citySelected = document.getElementById("city");
						var bankSelected = document.getElementById("bankName");
						var parentId = $(this).children('option:selected').val();
						// alert(parentId);
						if (parentId == "") {
							// 清空市的数据
							citySelected.options.length = 0;
							citySelected.add(new Option("请选择", ""));
							// 清空bank的数据
							bankSelected.options.length = 0;
							bankSelected.add(new Option("请选择", ""));
							return;
						}
						// 通过parentId来城市数据
						$.ajax({
							type : "POST",
							url : getCityUrl,
							data : {
								parentId : parentId
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
									citySelected.add(new Option(item.name,
											item.cityCode));
								});
							},
							error : function() {
								alert('查询省市数据AJAX请求异常,请联系系统管理人员或重新登录！');
							}
						});
					})

			$('#city').change(
					function() {
						var jdCityCode = $(this).children('option:selected')
								.val();
						var bankSelected = document.getElementById("bankName");
						var ownerBankId = $("#owerBank").val();
						var brachName = $("#brachName").val();
						// alert(jdCityCode);
						if (jdCityCode == "") {
							// 清空bank的数据
							bankSelected.options.length = 0;
							bankSelected.add(new Option("请选择", ""));
							return;
						}
						// 通过parentId来城市数据
						$.ajax({
							type : "POST",
							url : getBankUrl,
							data : {
								jdCityCode : jdCityCode,
								ownerBankId : ownerBankId,
								brachName:brachName
							},
							dataType : "json",
							cache : false,
							success : function(json) {
								// 清空市的数据
								bankSelected.options.length = 0;
								bankSelected.add(new Option("请选择", ""));
								// 增加数据
								$.each(json, function(i, item) {
									bankSelected.add(new Option(item.bankName,
											item.bankNumber));
									$(
											"#bankName option[value='"
													+ item.bankNumber + "']")
											.attr("code", item.bankCode);
								});
							},
							error : function() {
								alert('查询省市数据AJAX请求异常,请联系系统管理人员或重新登录！');
							}
						});
					})

			// 银行列表信息
			$('#owerBank').change(
					function() {
						var jdCityCode = $("#city").val();
						var bankSelected = document.getElementById("bankName");
						var ownerBankId = $("#owerBank").val();
						var brachName = $("#brachName").val();
						// alert(ownerBankId);
						// alert(jdCityCode);
						if (jdCityCode == "") {
							// 清空bank的数据
							bankSelected.options.length = 0;
							bankSelected.add(new Option("请选择", ""));
							return;
						}
						// 通过parentId来城市数据
						$.ajax({
							type : "POST",
							url : getBankUrl,
							data : {
								jdCityCode : jdCityCode,
								ownerBankId : ownerBankId,
								brachName:brachName
							},
							dataType : "json",
							cache : false,
							success : function(json) {
								// 清空市的数据
								bankSelected.options.length = 0;
								bankSelected.add(new Option("请选择", ""));
								// 增加数据
								$.each(json, function(i, item) {
									bankSelected.add(new Option(item.bankName,
											item.bankNumber));
									$(
											"#bankName option[value='"
													+ item.bankNumber + "']")
											.attr("code", item.bankCode);
								});
							},
							error : function() {
								alert('查询银行数据AJAX请求异常,请联系系统管理人员或重新登录！');
							}
						});
					})

			// 支行名称失去焦点
			$('#brachName').blur(
					function() {
						var brachName = $(this).val();
						brachName = $.trim(brachName);

						var jdCityCode = $("#city").val();
						var bankSelected = document.getElementById("bankName");
						var ownerBankId = $("#owerBank").val();
						// alert(jdCityCode);
						if (jdCityCode == "" || jdCityCode == undefined) {
							bootbox.alert("请选择省市数据，进行查询");
							// 清空bank的数据
							bankSelected.options.length = 0;
							bankSelected.add(new Option("请选择", ""));
							return;
						}
						// 通过parentId来城市数据
						$.ajax({
							type : "POST",
							url : getBankUrl,
							data : {
								jdCityCode : jdCityCode,
								ownerBankId : ownerBankId,
								brachName : brachName
							},
							dataType : "json",
							cache : false,
							success : function(json) {
								// 清空市的数据
								bankSelected.options.length = 0;
								bankSelected.add(new Option("请选择", ""));
								// 增加数据
								$.each(json, function(i, item) {
									bankSelected.add(new Option(item.bankName,
											item.bankNumber));
									$(
											"#bankName option[value='"
													+ item.bankNumber + "']")
											.attr("code", item.bankCode);
								});
							},
							error : function() {
								alert('查询省市数据AJAX请求异常,请联系系统管理人员或重新登录！');
							}
						});

					});
		})
