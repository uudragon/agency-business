#####目录
- [建立保存代理商接口](#11-url)
- [验证代理用户登录用户和密码](#21-url)
- [查询用户基本信息接口](#31-url)
- [保存渠道信息接口](#41-url)
- [修改渠道信息接口](#51-url)
- [单个查询渠道信息接口](#61-url)
- [批量查询渠道信息接口](#71-url)
- [批量查询对应的代理区域](#81-url)
- [批量查询对应的合同和对应区域](#91-url)
- [增加合同主体包括代理区域](#101-url)
- [增加代理商信息](#111-url)
- [检查登陆用户和密码的一致性](#121-url)
- [单个查询代理商信息](#131-url)
- [修改密码接口](#141-url)

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

#####5. 修改渠道信息接口
此接口修改渠道信息接口
######5.1 url
	method: POST
	http://agency.business.com/agencybusiness/updateChannelInfo
	
######5.2 header
	Content_Type:application/json;charset=utf-8
	Accept:application/json
######5.3 请求参数

名称|类型|是否必填|说明
---|---|---|---
channelNo|String|Y|渠道商编号
channelLoginId|String|N|渠道商登陆id
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

######5.4 响应报文
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

#####6. 单个查询渠道信息接口
此接口保存渠道信息接口
######6.1 url
	method: POST
	http://agency.business.com/agencybusiness/queryChannelInfo
	
######6.2 header
	Content_Type:application/json;charset=utf-8
	Accept:application/json
######6.3 请求参数

名称|类型|是否必填|说明
---|---|---|---
channelNo|String|Y|渠道商编号
channelName|String|Y|渠道商姓名
样例报文：

{
{"channelNo":"123456",
"channelName":"姜作辉"
}
}

######6.4 响应报文
成功响应：
{"channelLoginId":"jiang","channelNo":"123456","channelName":"姜作辉","channelPhone":"123123213","company":"京东","isSuccess":true,"pageSize":0,"pageNo":0,"recordsCount":0,"pageNumber":0}

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

#####7. 批量查询渠道信息接口
此接口批量查询渠道信息接口
######7.1 url
	method: POST
	http://agency.business.com/agencybusiness/queryChannelInfoList
	
######7.2 header
	Content_Type:application/json;charset=utf-8
	Accept:application/json
######7.3 请求参数

名称|类型|是否必填|说明
---|---|---|---
channelNo|String|N|渠道商编号
channelName|String|N|渠道商姓名
样例报文：

{
{"channelNo":"123456",
"channelName":"姜作辉",
 "pageNo":1,
 "pageSize":1
}
}

######7.4 响应报文
成功响应：

{"records":[{"channelLoginId":"jiang","channelNo":"123456","password":"9cdegZgAfdg%3D","channelName":"姜作辉","channelPhone":"123123213","company":"京东","status":"1","startRow":0,"endRow":0}],"isSuccess":true,"pageSize":1,"pageNo":1,"recordsCount":1,"pageNumber":1}

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


#####8. 批量查询对应的代理区域接口
此接口批量查询对应的代理区域接口，查询省对应的市，市对应的区域等接口

######8.1 url
	method: POST
	http://agency.business.com/agencybusiness/queryAgencyAreaList
	
######8.2 header
	Content_Type:application/json;charset=utf-8
	Accept:application/json
######8.3 请求参数

名称|类型|是否必填|说明
---|---|---|---
agencyNo|String|N|代理商编号
agencyName|String|N|代理商编号
province|String|N|省
city|String|N|市
district|String|N|地区
pageNo|int|N|页数
pageSize|int|N|页大小
样例报文：


{"agencyNo":"123456",
"agencyName":"姜作辉",
"province":"山东",
"city":"济南",
"district":"历下区",
 "pageNo":1,
 "pageSize":1
}


######8.4 响应报文
成功响应：

{"records":[{"contractId":"6e80d83d-84b2-7847","agencyNo":"1491fa99-93d8-2520","agencyName":"你是谁d","agencyPhone":"13910121111","province":"山西","city":"长治","district":"城区"},{"contractId":"6e80d83d-84b2-7847","agencyNo":"1491fa99-93d8-2520","province":"山西","city":"长治","district":"城区"}],"isSuccess":false,"pageSize":0,"pageNo":0,"recordsCount":0,"pageNumber":0}

响应报文说明：
名称|类型|是否必填|说明
---|---|---|---
contractId|String|N|代理合同编号
agencyNo|String|N|代理商编号
agencyName|String|N|代理商姓名
agencyPhone|String|N|代理商电话
province|String|N|省
city|String|N|市
district|String|N|地区
pageNo|int|N|页数
pageSize|int|N|页大小

异常响应：

	1．	"isSuccess":false

异常报文：

名称 | 类型 | 说明
------------ | ------------- | ------------
error| String  | 错误信息

样例报文：

	{"isSuccess":false,"returnCode":"保存失败"}
	
----

#####9. 批量查询对应的合同和对应代理区域
此接口批量查询对应的合同和代理区域

######9.1 url
	method: POST
	http://agency.business.com/agencybusiness/queryAgencyContactList
	
######9.2 header
	Content_Type:application/json;charset=utf-8
	Accept:application/json
######9.3 请求参数

名称|类型|是否必填|说明
---|---|---|---
agencyNo|String|N|代理商编号
pageNo|int|N|页数
pageSize|int|N|页大小
样例报文：

{"agencyNo":"1491fa99-93d8-2520",
 "pageNo":1,
 "pageSize":10
}

######9.4 响应报文
成功响应：

{"records":[{"contractId":"6e80d83d-84b2-7847","agencyNo":"1491fa99-93d8-2520","agencyName":"你是谁d","agencyPhone":"13910121111","province":"山西","city":"长治","district":"城区"},{"contractId":"6e80d83d-84b2-7847","agencyNo":"1491fa99-93d8-2520","province":"山西","city":"长治","district":"城区"}],"isSuccess":false,"pageSize":0,"pageNo":0,"recordsCount":0,"pageNumber":0}

响应报文说明：
名称|类型|是否必填|说明
---|---|---|---
contactsigntime|String|N|签订时间
contactendime|String|N|结束时间
contacttype|String|N|合同类型(0:独家代理商、1：普通代理商）)
contactstarttime|String|N|开始时间
agencyfees|String|N|代理费
contractId|String|N|合同编号
pageNo|int|N|页数
pageSize|int|N|页大小

异常响应：

	1．	"isSuccess":false

异常报文：

名称 | 类型 | 说明
------------ | ------------- | ------------
error| String  | 错误信息

样例报文：

	{"isSuccess":false,"returnCode":"保存失败"}
	
----

#####10. 增加合同主体包括代理区域
此接口增加合同主体包括代理区域

######10.1 url
	method: POST
	http://agency.business.com/agencybusiness/saveAgencyContact
	
######10.2 header
	Content_Type:application/json;charset=utf-8
	Accept:application/json
######10.3 请求参数

名称|类型|是否必填|说明
---|---|---|---
agencyNo|String|N|代理商编号
contactsigntime|String|N|签订时间
contactendime|String|N|结束时间
contacttype|String|N|合同类型(0:独家代理商、1：普通代理商）)
contactstarttime|String|N|开始时间
agencyfees|String|N|代理费
contractId|String|N|合同编号
agencyNo|String|N|代理商编号
agencyAreaEntity|代理商代理区域list
areaId|String|N|代理区域编号
province|String|N|代理区域编号
city|String|N|代理区域编号
district|String|N|代理区域编号

样例报文：

{
    "agencyLoginId": "13693358017",
    "contractId": "fefcc2b0-de1a-34eb",
    "agencyAreaEntity": [
        {
            "areaId": "5f7e0198-574b-3d36",
            "province": "天津",
            "city": "天津市",
            "district": "和平区",
            "address": "磊"
        }
    ],
    "contacttype": "0",
    "contactstarttime": "2015-03-05",
    "contactendime": "2015-02-04",
    "contactsigntime": "2015-06-11",
    "agencyfees": "123"
}

######10.4 响应报文
成功响应：

响应报文说明：
名称|类型|是否必填|说明
---|---|---|---
contactsigntime|String|N|签订时间
contactendime|String|N|结束时间
contacttype|String|N|合同类型(0:独家代理商、1：普通代理商）)
contactstarttime|String|N|开始时间
agencyfees|String|N|代理费
contractId|String|N|合同编号
pageNo|int|N|页数
pageSize|int|N|页大小

异常响应：

	1．	"isSuccess":false

异常报文：

名称 | 类型 | 说明
------------ | ------------- | ------------
error| String  | 错误信息

样例报文：

	{"isSuccess":false,"returnCode":"保存失败"}
	
----

#####11. 增加合代理商信息
此接口增加合同主体包括代理区域

######11.1 url
	method: POST
	http://agency.business.com/agencybusiness/saveChannelAgency
	
######11.2 header
	Content_Type:application/json;charset=utf-8
	Accept:application/json
######11.3 请求参数

名称|类型|是否必填|说明
---|---|---|---
channelloginId|String|N|渠道经理登陆id
channelNo|String|N|渠道经理编号
channelLoginName|String|N|渠道经理姓名
agencyloginId|String|N|代理商登陆id
agencyPassword|String|N|代理商登陆密码
agencyNo|String|N|代理商编号
province|String|N|省
city|String|N|市
district|String|N|区
address|String|N|地址
post|String|N|邮编
company|String|N|代理商公司
fixedtelephone|String|N|固定电话
email|String|N|邮件
fax|String|N|传真
agencyName|String|N|代理商姓名
agencyPhone|String|N|代理商电话
fax|String|N|传真

样例报文：

{
    "channelloginName": "管理员",
    "channelNo": "43213",
    "agencyloginId": "13912233123",
    "contractId": "d4c7b4c0-89a3-4c05-a78b-a4109e79d25f",
    "agencyPassword": "%2FqUYOKaJo8o%3D",
    "province": "天津",
    "city": "天津市",
    "district": "和平区",
    "address": "asdf在柑",
    "post": "123",
    "agencyNo": "6cd48741-0820-2c5f",
    "company": "asdf",
    "fixedtelephone": "0522-2222221",
    "email": "1123@342.com",
    "fax": "123",
    "agencyName": "adfa",
    "agencyPhone": "13912233123",
    "agencyfees": 0,
    "agencystatus": "1",
    "isEffect": "1",
    "startRow": 0,
    "endRow": 0
}

######11.4 响应报文
成功响应：

响应报文说明：


异常响应：

	1．	"isSuccess":false

异常报文：

名称 | 类型 | 说明
------------ | ------------- | ------------
error| String  | 错误信息

样例报文：

	{"isSuccess":false,"returnCode":"保存失败"}
	
----


#####12. 检查代理商登录信息(此时必须输入密码)
此接口检查代理商登录信息(此时必须输入密码)

######12.1 url
	method: POST
	http://agency.business.com/agencybusiness/checkLoginAgency
	
######12.2 header
	Content_Type:application/json;charset=utf-8
	Accept:application/json
######12.3 请求参数

名称|类型|是否必填|说明
---|---|---|---
agencyloginId|String|N|代理商登陆id
agencyPassword|String|N|代理商登陆密码


样例报文：

{
    "agencyloginId": "管理员",
    "agencyPassword": "13912233123"
}

######12.4 响应报文
成功响应：

响应报文说明：


异常响应：

	1．	"isSuccess":false

异常报文：

名称 | 类型 | 说明
------------ | ------------- | ------------
error| String  | 错误信息

样例报文：

	{"isSuccess":false,"returnCode":"保存失败"}
	
----

#####13. 单个查询代理商信息
此接口单个查询代理商信息

######13.1 url
	method: POST
	http://agency.business.com/agencybusiness/queryChannelAgency
	
######13.2 header
	Content_Type:application/json;charset=utf-8
	Accept:application/json
######13.3 请求参数

名称|类型|是否必填|说明
---|---|---|---
agencyNo|String|N|代理商编号


样例报文：

{
    "agencyNo": "1491fa99-93d8-2520"
}

######13.4 响应报文
成功响应：

响应报文说明：
channelloginId|String|N|渠道经理登陆id
channelNo|String|N|渠道经理编号
channelLoginName|String|N|渠道经理姓名
agencyloginId|String|N|代理商登陆id
agencyPassword|String|N|代理商登陆密码
agencyNo|String|N|代理商编号
province|String|N|省
city|String|N|市
district|String|N|区
address|String|N|地址
post|String|N|邮编
company|String|N|代理商公司
fixedtelephone|String|N|固定电话
email|String|N|邮件
fax|String|N|传真
agencyName|String|N|代理商姓名
agencyPhone|String|N|代理商电话
fax|String|N|传真

异常响应：

	1．	"isSuccess":false

异常报文：

名称 | 类型 | 说明
------------ | ------------- | ------------
error| String  | 错误信息

样例报文：

	{"isSuccess":false,"returnCode":"保存失败"}
	
----

#####14. 修改密码接口
此接口修改密码接口

######14.1 url
	method: POST
	http://agency.business.com/agencybusiness/updateAgencyPassword
	
######14.2 header
	Content_Type:application/json;charset=utf-8
	Accept:application/json
######14.3 请求参数

名称|类型|是否必填|说明
---|---|---|---
agencyloginId|String|N|代理商登陆id
agencyNo|String|N|代理商编号
agencyOldPassword|String|N|代理商登陆旧密码
agencyNewPassword|String|N|代理商登陆新密码

样例报文：

{
    "agencyloginId": "13912233123",
    "agencyOldPassword": "111111",
    "agencyNewPassword": "222222",
    "agencyNo": "932u424"
}

######14.4 响应报文
成功响应：

响应报文说明：


异常响应：

	1．	"isSuccess":false

异常报文：

名称 | 类型 | 说明
------------ | ------------- | ------------
error| String  | 错误信息

样例报文：

	{"isSuccess":false,"returnCode":"保存失败"}
	
----
