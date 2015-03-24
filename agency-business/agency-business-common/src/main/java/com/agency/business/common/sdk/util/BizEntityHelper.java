package com.agency.business.common.sdk.util;

import org.cf.frontend.sdk.vo.BizEntity;
import org.cf.frontend.sdk.vo.receiveOrder.ReceiveOrderReqVo;

/**
 */
public abstract class BizEntityHelper {

    /**
     * 校验签名数据
     *
     * @param bizEntity
     * @param privateKey
     * @return
     */
    public static boolean verifySignSHA256(BizEntity bizEntity, String privateKey) {
        StringBuilder sb = new StringBuilder(512);
        sb.append(bizEntity.getVersion());
        sb.append(bizEntity.getCharset());
        sb.append(bizEntity.getTradeType());
        sb.append(bizEntity.getData());
        sb.append(bizEntity.getMerchantCode());
        sb.append(privateKey);

        String tempSign = AlgorithmUtils.sha256Digest(sb.toString(), bizEntity.getCharset());

        if (tempSign.equalsIgnoreCase(bizEntity.getSign()))
            return true;
        return false;
    }

    /**
     * 验证字符串签名
     * @param data 呆验签的原始数据
     * @param privateSignKey 私钥
     * @param charset 字符集编码
     * @param sign 加密串
     * @return
     */
    public static boolean verifySignStringSHA256(String data, String privateSignKey,String charset,String sign,String merchantNo) {
        StringBuilder sb = new StringBuilder(512);
        sb.append(data);
        sb.append(merchantNo);
        sb.append(privateSignKey);
        String tempSign = AlgorithmUtils.sha256Digest(sb.toString(), charset);

        if (tempSign.equalsIgnoreCase(sign))
            return true;
        return false;
    }

    public static String signStringSHA256(String data, String privateSignKey,String charset,String merchantNo) {
        StringBuilder sb = new StringBuilder(512);
        sb.append(data);
        sb.append(merchantNo);
        sb.append(privateSignKey);
        String tempSign = AlgorithmUtils.sha256Digest(sb.toString(), charset);
        return tempSign;
    }
    /**
     * 生成签名
     *
     * @param bizEntity
     * @param privateKey
     */
    public static void createSignSHA256(BizEntity bizEntity, String privateKey) {
        StringBuilder sb = new StringBuilder(512);
        sb.append(bizEntity.getVersion());
        sb.append(bizEntity.getCharset());
        sb.append(bizEntity.getTradeType());
        sb.append(bizEntity.getData());
        sb.append(bizEntity.getMerchantCode());
        sb.append(privateKey);
        bizEntity.setSign(AlgorithmUtils.sha256Digest(sb.toString(), bizEntity.getCharset()));
    }


    /**
     * 创建密文方法，用于各种交易报文中的DATA字段加密
     *
     * @param plainText  明文，报文中的DATA明文数据
     * @param privateKey 加密key由商家颁发
     * @param charset    字符集，使用指定的字符集进行加密运算，系统中默认使用UTF-8
     * @return
     */
    public static String createCipherText(String plainText, String privateKey, String charset) {
        String cipherText = AlgorithmUtils.urlEncode((AlgorithmUtils.base64Encode(AlgorithmUtils.des3Encrypt(plainText, privateKey, charset))), charset);
        return cipherText;
    }

    /**
     * 由密文返向为明文，用于各种交易报文中的DATA字段解密。
     *
     * @param cipherText 密文，交易报文中传输的密文
     * @param privateKey 解密使用的key由商家颁发
     * @param charset    字符集，使用指定的字符集进行加密运算，系统中默认使用UTF-8
     * @return
     */
    public static String reverseCipherText(String cipherText, String privateKey, String charset) {
        String plainText = AlgorithmUtils.des3Decrypt(AlgorithmUtils.base64Decode(AlgorithmUtils.urlDecode(cipherText, charset)), privateKey, charset);
        return plainText;
    }

    public static void main(String[] args) {
        String privateKey = "012345678901234567890123";
        String charset = "UTF-8";

        BizEntity entity = new BizEntity();
        entity.setCharset("UTF-8");
        entity.setTradeType("01"); //代表支付交易
        entity.setVersion("1.1.0");

        /**
         * 收单对象
         */
        ReceiveOrderReqVo receiveOrderReqVo = new ReceiveOrderReqVo();
        receiveOrderReqVo.setAmount("10000.10");
        receiveOrderReqVo.setPagebackUrl("http://xxx.xxx.xxx.xxx/callback");
        receiveOrderReqVo.setComment("用户贷款");
        receiveOrderReqVo.setMerchantCode("100001");
        receiveOrderReqVo.setMerchantOrderId("111111111111");
        receiveOrderReqVo.setMerchantUserId("test_xiaoming");
        receiveOrderReqVo.setProductName("韩国七日游");

        String plainText = GsonUtils.toJson(receiveOrderReqVo);
        String cipherText = createCipherText(plainText, privateKey, charset);
        System.out.println("cipherText:" + cipherText);
        entity.setData(cipherText);
        createSignSHA256(entity, privateKey);


        //这个时候我们的业务实体对象就是已经是加过密并且签名过的了

    }

}
