package com.agency.business.common.utils;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.math.BigDecimal;
import java.text.DecimalFormat;
import java.text.NumberFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Map;

/**
 * 数据格式化通用类

 */
public class Format {
    private static Logger logger =LoggerFactory.getLogger(Format.class);


    /**
     * 把金额从元转换成分
     * eg:12.34 to  1234
     * @param amountStr
     * @return
     */
    public static String amountYuanTOamountFen(String amountStr) {
        BigDecimal bigDecimalYuan = new BigDecimal(amountStr);
        BigDecimal bigDecimalFen  = bigDecimalYuan.multiply(new BigDecimal(100));
        return    formatBigDecimalToStr(bigDecimalFen);
    }


    /**
     * 把金额从分转换成元
     * eg:1234 to  12.34
     * @param amountStr
     * @return
     */
    public static BigDecimal amountFenTOamountYuan(String amountStr) {
        if(amountStr == null || "".equals(amountStr)) {
            return new BigDecimal(0);
        }
        BigDecimal bigDecimalFen = new BigDecimal(amountStr);
        BigDecimal bigDecimalYuan  = bigDecimalFen.divide(new BigDecimal(100));

        return bigDecimalYuan;
    }


    /**
     * 把金额从分转换成元
     * eg:1234 to  12.34
     * @param amountStr
     * @return
     */
    public static String amountFenTOamountYuanStr(String amountStr) {

        if(amountStr == null || "".equals(amountStr)) {
            return "0";
        }
        BigDecimal bigDecimalFen = new BigDecimal(amountStr);
        BigDecimal bigDecimalYuan  = bigDecimalFen.divide(new BigDecimal(100));

        return number2String(bigDecimalYuan,"########0.00");
    }


    /**
     * null "" 格式化为null
     *
     * @param value
     * @return null
     */
    public static String stringNull(String value) {
        if(value != null)
        {
            value = value.trim();
            if(value.equals(""))
            {
                value = null;
            }
        }

        return value;
    }

    /**
     * null "" 格式化为""
     *
     * @param value
     * @return ""
     */
    public static String stringBlank(String value) {
        value = stringNull(value);

        if(value == null)
        {
            value = "";
        }

        return value;
    }

    /**
     * 日期字符串格式化为日期类型
     * e.g. yyyy-MM-dd HH:mm:ss
     *
     * @param value
     * @param format
     * @return Date
     */
    public static Date string2Date(String value, String format) {
        Date result = null;

        try{
            SimpleDateFormat sdf = new SimpleDateFormat(stringNull(format));
            result = sdf.parse(stringNull(value));
        }
        catch(Exception e){
            logger.error(value + " | " + format, e);
        }

        return result;
    }

    /**
     * 日期类型格式化为字符串
     * e.g. yyyy-MM-dd HH:mm:ss
     *
     * @param value
     * @param format
     * @return String
     */
    public static String date2String(Date value, String format) {
        String result = null;

        try{
            SimpleDateFormat sdf = new SimpleDateFormat(stringNull(format));
            result = sdf.format(value);
        }
        catch(Exception e){
            logger.error(value + " | " + format, e);
        }

        return result;
    }

    /**
     * 数字类型格式化为字符串
     * e.g. ########0.00
     *
     * @param value
     * @param format
     * @return String
     */
    public static String number2String(BigDecimal value, String format) {
        String result = null;

        try{
            DecimalFormat df = new DecimalFormat(stringNull(format));
            result = df.format(value);
        }
        catch(Exception e){
            logger.error(value + " | " + format, e);
        }

        return result;
    }

    /**
     * 数组格式化为字符串
     *
     * @param object
     * @return String
     */
    public static String array2String(Object[] object) {
        StringBuilder result = new StringBuilder();

        result.append("{");

        int n = 0;
        for(Object obj : object)
        {
            result.append(obj.toString());
            if(++ n < object.length)
            {
                result.append(", ");
            }
        }

        result.append("}");

        return result.toString();
    }

    /**
     * 异常格式化为字符串
     *
     * @param t
     * @return String
     */
    public static String exception2String(Throwable t) {
        StringBuilder result = new StringBuilder();

        result.append(t.toString());
        result.append("\n");

        StackTraceElement[] stes = t.getStackTrace();
        for(StackTraceElement ste : stes)
        {
            result.append(ste.toString());
            result.append("\n");
        }

        return result.toString();
    }

    /**
     * 判断字符串是否为空
     * @param value
     * @return
     */
    public static boolean isEmpty(String value) {
        boolean result = false;

        value = Format.stringNull(value);
        if(value == null)
        {
            result = true;
        }

        return result;
    }


    public static String JdTypeToCB(Map<Object,Object> map,Object jdValue,String suffer) {
        String obj = jdValue.toString();
        String value  = Format.stringNull((String) map.get(suffer + jdValue));
        if(value == null ) {
            return obj;
        }
        return value;
    }

    /**
     * 格式化金额
     * @param ll
     * @return
     */
    public static String formatBigDecimalToStr(BigDecimal ll) {
        DecimalFormat format = (DecimalFormat) NumberFormat.getPercentInstance();
        format.applyPattern( "##########0");
        if(ll!= null )
            return format.format(ll) ;//format.format(ll.divide(new BigDecimal(100)));
        else
            return "";
    }

    public static String CBDateFormatJDDate(String date ,String time) {
        String dateStr = date;
        String timeStr = time;
        StringBuffer s  = new StringBuffer();
        if(dateStr !=null && !"".equals(dateStr) && timeStr!=null && !"".equals(timeStr)) {
            if(dateStr.length()==8 && timeStr.length() == 6) {
                String yy = dateStr.substring(0,4);
                String mm = dateStr.substring(4,6);
                String dd = dateStr.substring(6,8);
                String hh = timeStr.substring(0,2);
                String mi = timeStr.substring(2,4);
                String ss = timeStr.substring(4,6);

                s.append(yy).append("-").append(mm).append("-").append(dd).append(" ")
                        .append(hh).append(":").append(mi).append(":").append(ss);

            }
        }
        return s.toString();
    }

    public static void main(String [] agres) throws  Exception{

    }

}