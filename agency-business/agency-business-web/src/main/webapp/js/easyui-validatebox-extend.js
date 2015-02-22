$.extend($.fn.validatebox.defaults.rules, {
	mobile : { //验证手机号码
		validator : function(value) {
			return /^(13|15|18)\d{9}$/i.test(value);
		},
		message : '手机号码格式不正确'
	},
	rate : { //费率
		validator : function(value) {
			if(parseFloat(value) > 1) {
				return false;
			}
			
			if(parseFloat(value) == 1) {
				return true;
			}
			
			return /^0\.\d+$/i.test(value);
		},
		message : '输入值必须在0至1之间'
	},
	integer : {// 验证整数          
		validator : function(value) {              
			return /^[+]?[1-9]+\d*$/i.test(value);         
		},          
		message : '请输入正整数'     
	}
});