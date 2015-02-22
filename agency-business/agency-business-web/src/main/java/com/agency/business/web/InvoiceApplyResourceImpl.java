package com.agency.business.web;

import com.agency.business.export.InvoiceApplyResource;
import com.agency.business.export.OrderApplyResource;
import com.agency.business.export.vo.InitOrderApplyInfoReqVo;
import com.agency.business.export.vo.InitOrderApplyInfoResVo;
import com.agency.business.service.OrderApplyService;
import com.jd.payment.paycommon.utils.GsonUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

/**
 * Created with IntelliJ IDEA.
 * User: jiangzuohui
 * Date: 15-2-1
 */
@Controller
public class InvoiceApplyResourceImpl implements InvoiceApplyResource {

    private static final Logger logger = LoggerFactory.getLogger(InvoiceApplyResourceImpl.class);
    @Autowired
    private OrderApplyService orderApplyService;
    @Override
    public InitOrderApplyInfoResVo saveInvoiceApplyInfo(InitOrderApplyInfoReqVo userActiveApplyReqVo) {
        return null;  //To change body of implemented methods use File | Settings | File Templates.
    }

    @Override
    public InitOrderApplyInfoResVo updateInvoiceApplyInfo(InitOrderApplyInfoReqVo userActiveApplyReqVo) {
        return null;  //To change body of implemented methods use File | Settings | File Templates.
    }

    @Override
    public InitOrderApplyInfoResVo queryInitInvoiceApplyInfo(InitOrderApplyInfoReqVo userActiveApplyReqVo) {
        return null;  //To change body of implemented methods use File | Settings | File Templates.
    }
}
