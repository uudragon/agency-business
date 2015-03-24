package com.agency.business.common.sdk.util;

import org.apache.commons.codec.digest.DigestUtils;

import java.io.UnsupportedEncodingException;

/**
 */
public class SHA256Util {
    /**
     * 对数据进行SHA256签名
     * @param data
     * @return
     */
    public static String digestBySHA256 (String data, String charSet) {
        try {
            return DigestUtils.sha256Hex(data.getBytes(charSet));
        } catch (UnsupportedEncodingException e) {

            throw new RuntimeException("SHA256Util exception: data=" + data);
        }

    }
    
    /**
	 * SHA256验签方法
	 * 
	 * @param text 明文
	 * @param key 密钥
	 * @param sha256 密文
	 * @return true/false
	 * @throws Exception
	 */
	public static boolean verify(String text, String key, String sha256, String charSet) throws Exception {
		String sha256Text = digestBySHA256(text + key, charSet);
		
		if(sha256Text.equalsIgnoreCase(sha256)){
			return true;
		} else {
			return false;
		}
	}
}
