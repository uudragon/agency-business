package com.agency.business.common;

import java.util.ArrayList;
import java.util.List;

/**
 */
public class Constants {

    /**
     * 交易成功返回码
     */
    public final static String SUCCESS_CODE = "UE0000";

    /**
     * 创建用户信息失败返回码
     */
    public final static String ERROR_CREATE = "UE1000";

    /**
     * 更新用户信息失败返回码
     */
    public final static String ERROR_UPDATEUSER = "UE2000";

    /**
     * 创建用户账户失败返回码
     */
    public final static String ERROR_ACCOUNTCREATE = "UE3000";

    /**
     * 更新用户信用信息失败返回码
     */
    public final static String ERROR_UPDATECREDIT = "UE4000";

    /**
     * 查询用户信用信息失败返回码
     */
    public final static String ERROR_QUERYCREFIT = "UE5000";
    /**
     * 查询用户信用信息失败返回码
     */
    public final static String EXIST_QUERYCREFIT = "UE6000";

    /**
     * 插入基本用户信息失败返回码
     */
    public final static String ERROR_INSERTBASEUSER = "UE7000";

    /**
     * 插入信用用户信息失败返回码
     */
    public final static String ERROR_INSERTCREDITUSER = "UE7001";

    /**
     * 插入task失败返回码
     */
    public final static String ERROR_INSERTACCOUNT = "UE7002";

    /**
     * 查询用户注册信息错误
     */
    public final static String ERROR_CHECKUSER = "UE7003";

    /**
     * 插入cf_userbalance失败返回码
     */
    public final static String ERROR_INSERTUSERBALANCE = "UE7004";

    /**
     * 插入cf_userbalancedetails失败返回码
     */
    public final static String ERROR_INSERTUSERBALANCEDETAILS = "UE7005";

    /**
     * 更新cf_userbalance失败返回码：更新金额<可用余额
     */
    public final static String ERROR_UPDATEUSERBALANCE = "UE7006";

    /**
     * 更新cf_userbalance失败返回码：其他错误
     */
    public final static String ERROR_UPDATEUSERBALANCEOTHER = "UE7007";

    /**
     * 调用CDS开户接口失败
     */
    public final static String ERROR_CDSCREATEUSER = "UE7008";

    /**
     * 查询erp接口失败
     */
    public final static String ERROR_SEARCHERP = "UE7009";

    /**
     * 查询是否白条用户失败
     */
    public final static String ERROR_SEARCHBTUSER = "UE7010";

    /**
     * 校验短信验证码错误
     */
    public final static String ERROR_CHECKACTIVENO = "UE7011";

    /**
     * 旅游白条开户失败
     */
    public final static String ERROR_USERREGISTER = "UE7012";

    /**
     * 查询激活单异常
     */
    public final static String ERROR_QUERYACTIVE= "UE7013";

    /**
     * 更新激活单异常
     */
    public final static String ERROR_UPDATEACTIVE= "UE7014";

    /**
     * 调用网银钱包接口,查询用户实名信息异常
     */
    public final static String ERROR_SEARCHUSERINFO= "UE7015";

    /**
     * 校验参数pin返回码
     */
    public final static String PARAM_PIN = "PE0001";

    /**
     * 校验参数name返回码
     */
    public final static String PARAM_NAME = "PE0002";

    /**
     * 校验参数idType返回码
     */
    public final static String PARAM_IDTYPE = "PE0003";

    /**
     * 校验参数idNo返回码
     */
    public final static String PARAM_IDNO = "PE0004";

    /**
     * 校验参数mobile返回码
     */
    public final static String PARAM_MOBILE = "PE0005";

    /**
     * 校验参数cardId返回码
     */
    public final static String PARAM_CARDID = "PE0006";

    /**
     * 校验参数cardNo返回码
     */
    public final static String PARAM_CARDNO = "PE0007";

    /**
     * 查询提交为空
     */
    public final static String PARAM_BLANK = "PE0008";

    /**
     * 校验参数Sponsors返回码
     */
    public final static String PARAM_SPONSORS = "PE0009";
    /**
     * 校验可用余额参数错误。
     */
    public final static String PARAM_USERBALANCE_ERROR = "PE0010";

    /**
     * 校验可用余额参数错误。
     */
    public final static String PARAM_ERROR = "PE0011";

    public final static String ACCOUNT_TYPE = "cf";

    public final static String CLIENT_KEY = "fin_user";

    public final static String CURRENCY = "1";

    public final static String OPERATOR = "System";

//    task库的消息的初始化消息。
    public final static int TASKINIT = 0;

    //    task库的消息的消息类型:创建账户
    public final static int TASKACCOUNTMESSTYPE = 4;
    
//  task库的消息的消息类型:创建账户
  public final static int USERAPPLYTASKATYPE = 9;

    //  task库的消息的消息类型:风控系统打标签
    public final static int TASKUSERTAG = 10;

    //  风控系统给旅游白条用户分的tagid 7
    public final static long TAGID = 7;

    //    task库的消息的消息类型：更新用户可用余额消息
    public final static int TASKUSERAMOUNTTYPE = 7;

//    调用JRG的通过身份证查询会员id的接口
    public final static String T001024001 = "T001024001";

//    调用JRG的通过身份证查询实名信息
    public final static String T001024002 = "T001024002";

//    调用JRG的通过会员id查询相关信息
    public final static String T001025001 = "T001025001";

    //    调用JRG的获取实名操作凭证
    public final static String T001010001 = "T001010001";

    //    调用JRG的查询实名认证信息
    public final static String T001011003 = "T001011003";

//  CDS开户参数。
    public final static String CREATEPRECREDIT = "travel.travelCreditService.getPreCreditInfo";

//
//  CDS开户key
//    申请开户流水号
    public final static String SEQNO = "seq_no";
//申请时间
    public final static String SEQTM = "seq_tm";
//申请人身份证
    public final static String CUSTOMID = "cust_id";
//申请人手机
    public final static String MOBLE = "moble";
//申请人京东pin
    public final static String PIN = "pin";
//    姓名
    public final static String NAME = "name";

    //    商家接入方式
    public final static String MERCHANT_INTERFACE_TYPE = "merchant_interface_type";

    //    商家名称
    public final static String MERCHANT_NAME = "merchant_name";

    //    商家ID
    public final static String MERCHANT_CODE = "merchant_code";

//   cds开户返回的cds_result
    public final static String CDS_RESULT = "cds_result";
//  cds返回的errorcode
    public final static String CDS_ERROR_CODE = "cds_error_code";
//    开户结果
    public final static String DECISIONRESULT = "decision_result";
//旅游白条授信额度
    public final static String CREDITAMT = "ly_baitiao_credit_amt";
//授信失效日期
    public final static String CREDITENDDATE = "ly_baitiao_credit_to_dt";
//决策时间
    public final static String DECISIONTM = "decision_tm";


//    网银返回的key

    //    商户号
    public final static String MERCHANT_NO = "MERCHANT_NO";
    //申请时间
    public final static String OLD_ID = "OLD_ID";
    //会员ID
    public final static String ID = "ID";
    //JDPIN
    public final static String JDPIN = "JDPIN";
    //email
    public final static String EMAIL = "EMAIL";
    //    电话
    public final static String TELEPHONE = "telephone";

    //    电话
    public final static String REALNAMEPHONE = "realnamePhone";

    //    电话
    public final static String CONTACTPHONE = "contactPhone";

    //   姓名
    public final static String REALNAME = "realname";


//  证件类型:身份证
    public final static String CARDTYPE = "1";

    //  状态类型：0:无效，1:有效
    public final static String VALIDSTATUS = "1";

    public final static List<String> CDS_SUCCESS = new ArrayList<String>();

    /**
     * CDS成功状态码
     */
    static {
        CDS_SUCCESS.add("1");   //初次授权成功
        CDS_SUCCESS.add("-1");   //初次授权成功
    }


    //  状态类型：0:无效，1:有效
    public final static String INVALIDSTATUS = "0";

    //    币种：人民币
    public final static String CURRENCY_CNY = "1";

//    调用网银的查询接口key:身份证号
    public final static String CERTUFUCATENO = "certificateNo";
//    会员id
    public final static String VALUE = "value";
    //    会员id
    public final static String WYPIN = "wyPin";
    //    会员id
    public final static String WYID = "id";
    //    凭证
    public final static String AUTH = "auth";

    public final static String AUTH_RESULT = "data";
    //    身份证
    public final static String ROOTCUSTOM = "rootCustomer";

    //    借贷标示:借
    public final static int DEBIT = 1;
    //    借贷标示:贷
    public final static int CREDIT = 2;

//    * 用户状态：正常：1，止付：0，失效：2
    public final static String STATUS_VALID = "1";

    public final static String STATUS_NOPAYVALID = "0";

    public final static String STATUS_INVALID = "2";

//  用户未注册(首次)
    public final static String NOREGISTER = "1";

//  用户已注册（非首次）
    public final static String REGISTER = "0";

    //  逾期
    public final static String OVERDUE = "1";

    //  没逾期
    public final static String NOOVERDUE = "0";

    public final static String CF = "cf";

//    信用状态：1：cf
    public final static String CREDITTYPE_CF = "1";

//  日期转换
    public static final String DATE_FORMAT_1 = "yyyy-MM-dd";

    public final static String CHARSET_UTF8 = "UTF-8";

    public static final String REST_META_TYPE = "application/json";

    public static final String TOKENHEAD = "token.value";

    public static final String CREDITBANKCOMTOKEN = "token.creditbankcom.value";

    public static final String BAITIAO_QUERYINFOBYID_URL = "BaitiaoRpc.queryInfoById_url";

    public static final String BAITIAO_QUERYINFOBYPIN_URL = "BaitiaoRpc.queryInfoByPin_url";
    public static final String BAITIAO_GETBALANCETESLA_URL = "Baitiao.getBalanceTesla_url";

    public static final String EMPTY_STR = "";
    /***
     * 旅游白条用户激活
     */
    
    //操作成功url
    public static String cf_user_active_0000000 = "cf_user_active_0000000";
    
    //插入认证信息失败
    public static String cf_user_active_0001001 = "cf_user_active_0001001";
    
    //更新认证信息失败
    public static String cf_user_active_0001002 = "cf_user_active_0001002";
    
    //查询认证信息失败
    public static String cf_user_active_0001003 = "cf_user_active_0001003";
    
   //查询激活信息为空
    public static String cf_user_active_0001004 = "cf_user_active_0001004";
    
    public static String SUCCESS = "SUCCESS";

    //  下划线
    public static final String UNDER_LINE = "_";

    //  用户系统
    public static final String USER = "user";

    //  平台pin
    public static final String PLATPIN = "platpin";
//    京东pin
    public static final String JD_PIN = "jdpin";


}
