package com.agency.business.web.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * Created by Administrator on 2015/2/20.
 */
@Controller
@RequestMapping(value="/sys")
public class ErpAgencyIndexController {
    private static final Logger logger = LoggerFactory.getLogger(ErpAgencyIndexController.class);

    @RequestMapping(value="index")
    public String index(ModelMap modelMap) {

        return "index";
    }

    @RequestMapping(value="welcome")
    public String welcome(ModelMap modelMap) {

        return "welcome";
    }


    @RequestMapping(value="message")
    public String message(ModelMap modelMap) {

        return "sys/message";
    }


    @RequestMapping(value="information")
    public String information(ModelMap modelMap) {

        return "sys/information";
    }


}
