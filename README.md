#目录

代理商订单保存接口
代理商订单查询接口
单笔代理商订单查询接口
支付完成接口
退款接口
审查完成接口
1.代理商订单保存接口

接收客服系统发送的订单信息，按照一定规则将其拆分成发货单并返回将发货单信息返回给客服系统

1.1 url

method: POST
agency/orders/save/
注意：结尾的’/’不能省略
1.2 header

Content_Type:application/json;charset=utf-8
Accept:application/json
1.3 请求参数

名称	类型	是否必填	说明
orders_no	String	Y	订单号
orders_type	INT	Y	订单类型。0：首期订单；1：促销品订单
customer_name	String	Y	客户姓名
customer_phone	String	Y	客户手机
customer_tel	String	Y	客户电话
customer_addr	String	Y	客户地址
has_invoice	int	Y	是否有发票。0：无；1：有
amount	decimal	Y	总金额
payment	INT	Y	支付方式，1银行;2支付宝
creator	String	Y	创建人
updater	String	Y	需改人
details	Array	Y	明细
$$$订单明细

名称	类型	是否必填	说明
code	String	Y	套餐/宣传品编号
name	String	Y	套餐/宣传品名称
qty	INT	Y	数量
amount	DECIMAL	Y	单品金额。
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
1.4 响应报文

成功响应：

HTTP_STATUS_CODE:200
响应报文说明： 无

异常响应：

a．    HTTP_STATUS_CODE:400 Bad request；
b．    HTTP_STATUS_CODE:500 Server Error
异常报文：

名称	类型	说明
error	String	错误信息
样例报文：

{'error':'Orders saved error.'}
