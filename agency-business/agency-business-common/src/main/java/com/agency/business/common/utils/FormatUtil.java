package com.agency.business.common.utils;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * .
 */
public class FormatUtil {
    public static Date parseDate(String timeStr, String fmtStr) {
        SimpleDateFormat sdf = new SimpleDateFormat(fmtStr);
        try {
            return sdf.parse(timeStr);
        } catch (ParseException e) {
            throw new RuntimeException("格式化日期异常");
        }
    }

    public static String formatDate(Date time, String fmt) {
        SimpleDateFormat sdf = new SimpleDateFormat(fmt);
        if (time == null) {
            return null;
        } else {
            return sdf.format(time);
        }
    }

    public static String formatDate(Date time) {
        return formatDate(time, "yyyy-MM-dd HH:mm:ss");
    }

    public static long parseLong(String s) {
        try {
            return Long.parseLong(s);
        } catch (Exception e) {
        }
        throw new RuntimeException("格式化日期异常");
    }

    public static void main(String[] args) {

//        System.out.println(parseDate("20150201","yyyy-MM-dd"));


        String time = "2013-02-07";
        SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMdd hh:mm:ss");
        Date date;
        try {date = formatter.parse(time);
            System.out.println(date.getTime());
        } catch (ParseException e) {
            e.printStackTrace();
        }
    }
}
