package com.agency.business.service;

import com.agency.business.export.vo.InitOrderApplyInfoReqVo;
import com.agency.business.export.vo.InitOrderApplyInfoResVo;

/**
 */
public interface InvoiceApplyService {

    public InitOrderApplyInfoResVo saveInvoiceApplyInfo(InitOrderApplyInfoReqVo userActiveApplyReqVo);

    public InitOrderApplyInfoResVo updateInvoiceApplyInfo(InitOrderApplyInfoReqVo userActiveApplyReqVo);

    public InitOrderApplyInfoResVo queryInitInvoiceApplyInfo(InitOrderApplyInfoReqVo userActiveApplyReqVo);
}
