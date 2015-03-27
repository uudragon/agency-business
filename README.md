#####目录
- [建立保存代理商接口](#11-url)

#####1.建立保存代理商接口
接收客服系统渠道商经理建立代理商账户，包括代理商登陆账户，默认的登陆密码
######1.1 url
	method: POST
	
	/agencybusiness/saveChannelAgency
	注意：结尾的’/’不能省略
######1.2 header
	Content_Type:application/json;charset=utf-8
	Accept:application/json
######1.3 请求参数
名称|类型|是否必填|说明
---|---|---|---
channelloginId|String|Y|渠道经理登陆id
channelLoginName|String|Y|渠道经理姓名
agencyloginId|String|Y|代理商登陆id(手机号)
agencyPassword|String|Y|代理商登陆密码
agencyAreaNo|String|N|代理区域编号
province|String|Y|代理商代理省
city|String|Y|代理商代理市
district|String|Y|代理商区
address|String|N|详细地址
agencyName|String|Y|代理商姓名
agencyPhone|String|Y|代理商电话
contactsigntime|String|N|签约时间
contactendime|String|N|签约终止时间
contacttype|String|Y|合同类型(1:独家代理商,2:普通代理商)
taskstandards|String|N|完成任务量
agencyfees|String|Y|缴纳代理费


样例报文：

	{'orders_no':'001010101',
	'order_type':0,
	'customer_name':'yonghu1',
	'customer_addr':'北京市天安门',
	'customer_tel':'18600000000',
	'has_invoice':0,
	'amount':10.00,
	'payment':2,
	'creator':'admin',
	'updater':'admin'
	'details':[
		{
			'code':'101010',
			'name':'首期1',
			'qty':10,
			'amount':1.00
		}
	]}

######1.4 响应报文
成功响应：

	HTTP_STATUS_CODE:200

响应报文说明：
无

异常响应：

	a．	HTTP_STATUS_CODE:400 Bad request；
	b．	HTTP_STATUS_CODE:500 Server Error

异常报文：

名称 | 类型 | 说明
------------ | ------------- | ------------
error| String  | 错误信息

样例报文：

	{'error':'Orders saved error.'}
	
----
