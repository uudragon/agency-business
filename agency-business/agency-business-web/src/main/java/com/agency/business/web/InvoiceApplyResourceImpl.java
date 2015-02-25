package com.agency.business.web;

import com.agency.business.export.InvoiceApplyResource;
import com.agency.business.export.OrderApplyResource;
import com.agency.business.export.vo.InitInvoiceApplyInfoReqVo;
import com.agency.business.export.vo.InitInvoiceApplyInfoResVo;
import com.agency.business.export.vo.InitOrderApplyInfoReqVo;
import com.agency.business.export.vo.InitOrderApplyInfoResVo;
import com.agency.business.service.InvoiceApplyService;
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
    private InvoiceApplyService invoiceApplyService;
    @Override
    public InitInvoiceApplyInfoResVo saveInvoiceApplyInfo(InitInvoiceApplyInfoReqVo initInvoiceApplyInfoReqVo) {
        return invoiceApplyService.saveInvoiceApplyInfo(initInvoiceApplyInfoReqVo);  //To change body of implemented methods use File | Settings | File Templates.
    }

    @Override
    public InitInvoiceApplyInfoResVo updateInvoiceApplyInfo(InitInvoiceApplyInfoReqVo initInvoiceApplyInfoReqVo) {
        return invoiceApplyService.updateInvoiceApplyInfo(initInvoiceApplyInfoReqVo); //To change body of implemented methods use File | Settings | File Templates.
    }

    @Override
    public InitInvoiceApplyInfoResVo queryInvoiceApplyInfo(InitInvoiceApplyInfoReqVo initInvoiceApplyInfoReqVo) {
        return invoiceApplyService.queryInitInvoiceApplyInfo(initInvoiceApplyInfoReqVo);  //To change body of implemented methods use File | Settings | File Templates.
    }
}
