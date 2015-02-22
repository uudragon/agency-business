package com.agency.business.service;
import com.agency.business.export.vo.AgencyInfoReqVo;
import com.agency.business.export.vo.AgencyInfoResVo;
import com.agency.business.export.vo.InitInvoiceApplyInfoReqVo;
import com.agency.business.export.vo.InitInvoiceApplyInfoResVo;

/**代理商管理1
 */
public interface AgencyApplyService {

    public AgencyInfoResVo saveAgencyInfo(AgencyInfoReqVo agencyInfoReqVo);

    public AgencyInfoResVo updateAgencyInfo(AgencyInfoReqVo agencyInfoReqVo);

    public AgencyInfoResVo queryAgencyInfo(AgencyInfoReqVo agencyInfoReqVo);
}
