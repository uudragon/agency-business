package com.agency.business.web.controller;

/**
 * Created by Administrator on 2015/2/20.
 */

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * Created by Administrator on 2015/2/20.
 */
@Controller
@RequestMapping(value="/orderManager")
public class ErpOrderManagerController {

//    <li>
//    <a href="#" onclick="content('/erp/substituteOrder');">代客户下单</a>
//    </li>
//    <li>
//    <a href="#" onclick="content('/erp/orderedFirst');">订购首期</a>
//    </li>
//    <li>
//    <a href="#" onclick="content('/erp/orderedSales');">订购宣传品</a>
//    </li>

    @RequestMapping(value="substituteOrder")
    public String substituteOrder(ModelMap modelMap){
        return "orderManager/substituteOrder";
    }

    @RequestMapping(value="orderedFirst")
    public String orderedFirst(ModelMap modelMap){
        return "orderManager/orderedFirst";
    }

    @RequestMapping(value="orderedSales")
    public String orderedSales(ModelMap modelMap){
        return "orderManager/orderedSales";
    }

    @RequestMapping(value="createOrder")
    public String createOrder(ModelMap modelMap){
        return "orderManager/createOrder";
    }

    @RequestMapping(value="queryOrder")
    public String queryOrder(ModelMap modelMap){
        return "orderManager/queryOrder";
    }



}
