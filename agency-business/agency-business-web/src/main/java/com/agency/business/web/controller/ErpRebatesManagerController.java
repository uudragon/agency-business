package com.agency.business.web.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * Created by Administrator on 2015/2/20.
 */
@Controller
@RequestMapping(value="/rebatesManager")
public class ErpRebatesManagerController {
//    <ul class="nav nav-second-level">
//    <li>
//    <a href="#" onclick="content('/erp/applyRebates');">申请返利</a>
//    </li>
//    <li>
//    <a href="#" onclick="content('/erp/queryRebates');">查询返利</a>
//    </li>
//    </ul>
    @RequestMapping(value="applyRebates")
    public String applyRebates(ModelMap modelMap){
        return "rebatesManager/applyRebates";
    }
    @RequestMapping(value="queryRebates")
    public String queryRebates(ModelMap modelMap){
        return "rebatesManager/queryRebates";
    }
}
