package com.agency.business.web.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * Created by Administrator on 2015/2/20.
 */
@Controller
@RequestMapping(value="/salesManager")
public class ErpSalesManagerController {


//
//    <li>
//    <a href="#" onclick="content('/salesManager/returnedManage');">退货管理</a>
//    </li>
//    <li>
//    <a href="#" onclick="content('/salesManager/barterManage');">换货管理</a>
//    </li>
    @RequestMapping(value="returnedManage")
    public String returnedManage(ModelMap modelMap){
        return "salesManager/returnedManage";
    }
    @RequestMapping(value="barterManage")
    public String barterManage(ModelMap modelMap){
        return "salesManager/barterManage";
    }


}
