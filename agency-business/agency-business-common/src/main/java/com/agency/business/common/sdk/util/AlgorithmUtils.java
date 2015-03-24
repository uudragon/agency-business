package com.agency.business.common.sdk.util;

import sun.misc.BASE64Decoder;
import sun.misc.BASE64Encoder;

import javax.crypto.Cipher;
import javax.crypto.SecretKey;
import javax.crypto.spec.SecretKeySpec;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.security.MessageDigest;

public abstract class AlgorithmUtils {
    /**
     * 使用3Des进行加密，
     *
     * @param plainText
     * @param charset
     * @return
     */
    public static byte[] des3Encrypt(String plainText, String key, String charset) {

        try {
            SecretKey secretKey = new SecretKeySpec(key.getBytes(charset), "DESede");
/*
            KeyGenerator kg = KeyGenerator.getInstance("DESede");
            kg.init(new SecureRandom(key.getBytes(charset)));
            SecretKey secretKey = kg.generateKey();
*/
            Cipher cipher = Cipher.getInstance("DESede/ECB/PKCS5Padding");
            cipher.init(Cipher.ENCRYPT_MODE, secretKey);

            return cipher.doFinal(plainText.getBytes(charset));

        } catch (Exception ex) {
            throw new RuntimeException(ex);
        }
    }

    /**
     * 使用3DES进行解密
     *
     * @param cipherText
     * @param key
     * @param charset
     * @return
     */
    public static String des3Decrypt(byte[] cipherText, String key, String charset) {
        try {
            SecretKey secretKey = new SecretKeySpec(key.getBytes(charset), "DESede");

/*
            KeyGenerator kg = KeyGenerator.getInstance("DESede");
            // kg.init(56);
            kg.init(new SecureRandom(key.getBytes(charset)));
            SecretKey secretKey = kg.generateKey();
*/

            Cipher c1 = Cipher.getInstance("DESede/ECB/PKCS5Padding");
            c1.init(Cipher.DECRYPT_MODE, secretKey);    //初始化为解密模式
            byte[] bytes = c1.doFinal(cipherText);
            return new String(bytes, charset);

        } catch (Exception ex) {
            throw new RuntimeException(ex);
        }
    }

    /**
     * 使用Base64进行编码
     *
     * @param input
     * @param charset
     * @return
     */
    public static String base64Encode(String input, String charset) {
        try {
            return base64Encode(input.getBytes(charset));
        } catch (UnsupportedEncodingException e) {
            throw new RuntimeException(e);
        }
    }

    /**
     * base64解码
     *
     * @param input
     * @return
     */
    public static String base64Encode(byte[] input) {
        BASE64Encoder base64Encoder = new BASE64Encoder();
        return base64Encoder.encode(input);
    }

    /**
     * 使用Base64进行解码
     *
     * @param input
     * @return
     */
    public static byte[] base64Decode(String input) {
        try {
            BASE64Decoder base64Decoder = new BASE64Decoder();
            byte[] bytes = base64Decoder.decodeBuffer(input);
            return bytes;
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    /**
     * 按url编码方式对给定字符串进行编码
     *
     * @param input
     * @param charset
     * @return
     */
    public static String urlEncode(String input, String charset) {
        try {
            return URLEncoder.encode(input, charset);
        } catch (UnsupportedEncodingException e) {
            throw new RuntimeException(e);
        }
    }

    /**
     * @param input
     * @param charset
     * @return
     */
    public static String urlDecode(String input, String charset) {
        try {
            return URLDecoder.decode(input, charset);
        } catch (UnsupportedEncodingException e) {
            throw new RuntimeException(e);
        }
    }

    /**
     * 使用sha256
     *
     * @param input
     * @param charset
     * @return
     */
    public static String sha256Digest(String input, String charset) {
        try {
            MessageDigest md = MessageDigest.getInstance("SHA-256");
            byte[] bytes = md.digest(input.getBytes(charset));

            StringBuilder sb = new StringBuilder(64);
            for (int i = 0; i < bytes.length; i++) {
                String hex = Integer.toHexString(0xff & bytes[i]);
                if (hex.length() == 1) sb.append('0');
                sb.append(hex);
            }

            return sb.toString();
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    public static void main(String[] args) {
        String json = "{\"pin\":\"cgx117\",\"clientKey\":\"insurance_system\",\"testzhongwen\":\"包含有京东商城快捷支付平台，强大的wo83d79f987296fe04af1e3eeeeed6fd178defa209cd4b9de0af20b6317fa84955rker中文字符\"}";
        String charset = "UTF-8";
        String privateKey = "123456789012345678901234";

        String cipherText = urlEncode((base64Encode(des3Encrypt(json, privateKey, charset))), charset);
        System.out.println("cipherText:" + cipherText);

        String plainText = des3Decrypt(base64Decode(urlDecode(cipherText, charset)), privateKey, charset);
        System.out.println("plainText:" + plainText);

        System.out.println("sha256Digest:" + sha256Digest(json, charset));

    }

}
