package com.agency.business.service;
import com.agency.business.export.vo.InitInvoiceApplyInfoReqVo;
import com.agency.business.export.vo.InitInvoiceApplyInfoResVo;

/**
 */
public interface InvoiceApplyService {

    public InitInvoiceApplyInfoResVo saveInvoiceApplyInfo(InitInvoiceApplyInfoReqVo initInvoiceApplyInfoReqVo);

    public InitInvoiceApplyInfoResVo updateInvoiceApplyInfo(InitInvoiceApplyInfoReqVo initInvoiceApplyInfoReqVo);

    public InitInvoiceApplyInfoResVo queryInitInvoiceApplyInfo(InitInvoiceApplyInfoReqVo initInvoiceApplyInfoReqVo);
}
