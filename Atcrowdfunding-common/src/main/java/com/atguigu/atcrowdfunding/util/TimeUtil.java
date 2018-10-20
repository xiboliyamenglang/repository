package com.atguigu.atcrowdfunding.util;

import java.text.SimpleDateFormat;
import java.util.Date;

public class TimeUtil {

    public static String formatDateToString(Date date){
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        try {
            return sdf.format(date);
        } catch (Exception e) {
            e.printStackTrace();
            return "";
        }
    }
}
