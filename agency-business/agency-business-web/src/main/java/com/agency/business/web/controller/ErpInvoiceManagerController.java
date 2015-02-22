package com.agency.business.web.controller;

/**
 * Created by Administrator on 2015/2/22.
 */

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * Created by Administrator on 2015/2/20.
 */
@Controller
@RequestMapping(value="/invoiceManager")
public class ErpInvoiceManagerController {


    @RequestMapping(value="invoiceManager")
    public String invoiceManager(ModelMap modelMap){
        return "invoiceManager/invoiceManager";
    }

}
