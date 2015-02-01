##目录
- [代理商接口](#11-url)


----
	注意：linux中/etc/hosts/ 配置host：119.255.25.130 com.agency.business
##1.保存采购单接口(包括：订购首期,订购宣传品,orderType区分:1.订购首期,2:订购宣传品)
###1.1 url
	method: POST
	URL:http://com.agency.business/service/orderapply/saveInitOrderApplyInfo

###1.2 header
	Content_Type:application/json;charset=utf-8
	Accept:application/json
	
--数据库
--采购表
drop table orders_purchase
CREATE TABLE `orders_purchase` (
  `id` bigint(32) NOT NULL AUTO_INCREMENT,
  `purchaseNo` varchar(32) NOT NULL COMMENT '采购单编号',
  `purchaseDate` datetime DEFAULT NULL COMMENT '采购单日期',
  `purchaseProduct` varchar(32) NOT NULL COMMENT '采购产品',
  `purchaseNumber` smallint(4) DEFAULT NULL COMMENT '采购总数量',
  `purchaseType` varchar(32) DEFAULT NULL COMMENT '采购类型(A套餐,宣传品等类型)',
  `orderType` varchar(64) DEFAULT NULL COMMENT '产品类型(1.订购首期,2:订购宣传品)',
  `amount` decimal(15,4) DEFAULT NULL COMMENT '总金额',
  `purchaseStatus` varchar(16) DEFAULT NULL COMMENT '采购单状态',
  `deliveryStatus` varchar(16)DEFAULT NULL COMMENT '发货状态',
  `deliveryDate` datetime DEFAULT NULL COMMENT '发货日期',
  `updateDate` datetime DEFAULT NULL,
  `createDate` datetime DEFAULT NULL,
  `operator` varchar(64) DEFAULT NULL COMMENT '操作者',
  `extParam` varchar(1024) DEFAULT NULL,
  `remark` varchar(128) DEFAULT NULL,
    PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=89 DEFAULT CHARSET=utf8;

###1.3请求参数 报文

{   
    "purchaseNo": "123",
    "purchaseDate": "2015-02-01",
    "purchaseProduct": "456",
    "purchaseNumber": 123,
    "purchaseType": "A套餐",
    "orderType": "1",
    "amount": 1000.01,
    "purchaseStatus": "已支付",
    "deliveryStatus": "未发货",
    "deliveryDate": "2015-02-01",
    "operator": "jiang"
}

返回报文：
isSuccess true：成功。false：异常。
样例报文：
{"isSuccess":true}
{"isSuccess":false}

##1.修改采购单接口(包括：订购首期,订购宣传品,orderType区分:1.订购首期,2:订购宣传品)
###1.1 url
	method: POST
	URL:http://com.agency.business/service/orderapply/updateInitOrderApplyInfo

###1.2 header
	Content_Type:application/json;charset=utf-8
	Accept:application/json

###1.3请求参数 报文

{   
    "purchaseNo": "123",
    "purchaseDate": "2015-02-01",
    "purchaseProduct": "456",
    "purchaseNumber": 123,
    "purchaseType": "A套餐",
    "orderType": "1",
    "amount": 1000.01,
    "purchaseStatus": "已支付",
    "deliveryStatus": "未发货",
    "deliveryDate": "2015-02-01",
    "operator": "jiang"
}

返回报文：
isSuccess true：成功。false：异常。
样例报文：
{"isSuccess":true}

{"isSuccess":false}

##1.查询采购单接口(包括：订购首期,订购宣传品,orderType区分:1.订购首期,2:订购宣传品)
###1.1 url
	method: POST
	URL:http://com.agency.business/service/orderapply/queryInitOrderApplyInfo

###1.2 header
	Content_Type:application/json;charset=utf-8
	Accept:application/json

###1.3请求参数 报文

{
    "purchaseNo": "123",
    "orderType": "1",
    "pageSize": "20",
    "pageNo": "1"
}

返回报文：

{
    "infoarrys": [
        {
            "purchaseNo": "123",
            "purchaseProduct": "456",
            "purchaseNumber": 1234,
            "purchaseType": "A套餐",
            "orderType": "1",
            "amount": 1000.01,
            "purchaseStatus": "未支付",
            "deliveryStatus": "未发货",
            "operator": "jiang",
            "startRow": 0,
            "endRow": 0
        }
    ],
    "pageSize": 20,
    "pageNo": 1,
    "recordsCount": 1,
    "isSuccess": true
}

isSuccess true：成功。false：异常。
样例报文：
{"isSuccess":true}

{"isSuccess":false}


##1.删除采购单接口(包括：订购首期,订购宣传品,orderType区分:1.订购首期,2:订购宣传品)
###1.1 url
	method: POST
	URL:http://com.agency.business/service/orderapply/deleteInitOrderApplyInfo

###1.2 header
	Content_Type:application/json;charset=utf-8
	Accept:application/json

###1.3请求参数 报文

{
    "purchaseNo": "123",
    "pageSize": "20",
    "orderType": "1",
    "pageNo": "1"
}

返回报文：

{
    "isSuccess": true
}

isSuccess true：成功。false：异常。
样例报文：
{"isSuccess":true}

{"isSuccess":false}
