#####目录
- [建立保存代理商接口](#11-url)
- [验证代理用户登录用户和密码](#21-url)
- [查询用户基本信息接口](#31-url)
- [保存渠道信息接口](#41-url)
- 
- 
#####1.建立保存代理商接口
接收客服系统渠道商经理建立代理商账户，包括代理商登陆账户，默认的登陆密码
######1.1 url
	method: POST
	http://agency.business.com/agencybusiness/saveChannelAgency
	
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
province|String|Y|省
city|String|Y|市
district|String|Y|区
address|String|N|详细地址
post|String|N|邮编
agencyName|String|Y|代理商姓名
agencyPhone|String|Y|代理商电话
contactsigntime|String|N|签约时间
contactendime|String|N|签约终止时间
contacttype|String|Y|合同类型(1:独家代理商,2:普通代理商)
taskstandards|String|N|完成任务量
agencyfees|String|Y|缴纳代理费


样例报文：

{
	"channelloginId":"admin",
	"channelLoginName":"姜作辉",
	"agencyloginId":"13693358014",
	"agencyPassword":"111111",
	"province":"山东省",
	"city":"济南",
	"district":"历城区",
	"address":"koerfkrf",
	"post":"100001",
	"agencyName":"代理商姓名",
	"agencyPhone":"13693358014",
	"taskstandards":"10000",
	"contactsigntime":"2015-03-16",
	"contactendime":"2016-03-16",
	"contacttype":"1",
	"agencyfees":"100.123",
	"taskstandards":"300"
}

######1.4 响应报文
成功响应：

	"isSuccess":true

响应报文说明：
无

异常响应：

	1．	"isSuccess":false

异常报文：

名称 | 类型 | 说明
------------ | ------------- | ------------
error| String  | 错误信息

样例报文：

	{"isSuccess":false,"returnCode":"建立保存代理商接口失败"}
	
----

#####2. 验证代理用户登录用户和密码
此接口用于验证用户登录代理商系统
######2.1 url
	method: POST
	http://agency.business.com/agencybusiness/checkLoginAgency
	
######2.2 header
	Content_Type:application/json;charset=utf-8
	Accept:application/json
######2.3 请求参数

名称|类型|是否必填|说明
---|---|---|---
agencyloginId|String|Y|代理商登陆id(手机号)
agencyPassword|String|Y|代理商登陆密码

样例报文：

{
	"agencyloginId":"13693358014",
	"agencyPassword":"111111"
}

######2.4 响应报文
成功响应：

	"isSuccess":true

响应报文说明：
无

异常响应：

	1．	"isSuccess":false

异常报文：

名称 | 类型 | 说明
------------ | ------------- | ------------
error| String  | 错误信息

样例报文：

	{"isSuccess":false,"returnCode":"用户不存在或者密码错误"}
	
----

#####3. 查询用户基本信息接口
此接口用于查询用户基本信息接口
######3.1 url
	method: POST
	http://agency.business.com/agencybusiness/checkLoginAgency
	
######3.2 header
	Content_Type:application/json;charset=utf-8
	Accept:application/json
######3.3 请求参数

名称|类型|是否必填|说明
---|---|---|---
agencyloginId|String|Y|代理商登陆id(手机号)

样例报文：

{
	"agencyloginId":"13693358014"
}

######3.4 响应报文
成功响应：

	"isSuccess":true

响应报文说明：
无

异常响应：

	1．	"isSuccess":false

异常报文：

名称 | 类型 | 说明
------------ | ------------- | ------------
error| String  | 错误信息

样例报文：

	{"isSuccess":false,"returnCode":"用户不存在或者密码错误"}
	
----

#####4. 保存渠道信息接口
此接口保存渠道信息接口
######4.1 url
	method: POST
	http://agency.business.com/agencybusiness/saveChannelInfo
	
######4.2 header
	Content_Type:application/json;charset=utf-8
	Accept:application/json
######4.3 请求参数

名称|类型|是否必填|说明
---|---|---|---
channelLoginId|String|Y|渠道商登陆id
channelNo|String|Y|渠道商编号
password|String|Y|渠道商登陆密码
channelName|String|N|渠道商姓名
channelPhone|String|N|渠道商手机
company|String|N|渠道商公司
operator|String|Y|操作者
样例报文：

{
{"channelLoginId":"jiang",
"channelNo":"123456",
"password":"111111",
"channelName":"姜作辉",
"channelPhone":"123123213",
"company":"京东",
"operator":"admin"
}
}

######4.4 响应报文
成功响应：

	"isSuccess":true

响应报文说明：
无

异常响应：

	1．	"isSuccess":false

异常报文：

名称 | 类型 | 说明
------------ | ------------- | ------------
error| String  | 错误信息

样例报文：

	{"isSuccess":false,"returnCode":"保存失败"}
	
----
