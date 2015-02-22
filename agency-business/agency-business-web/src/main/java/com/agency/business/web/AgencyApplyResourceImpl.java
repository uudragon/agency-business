package com.agency.business.web;

import com.agency.business.export.AgencyApplyResource;
import com.agency.business.export.InvoiceApplyResource;
import com.agency.business.export.vo.AgencyInfoReqVo;
import com.agency.business.export.vo.AgencyInfoResVo;
import com.agency.business.export.vo.InitOrderApplyInfoReqVo;
import com.agency.business.export.vo.InitOrderApplyInfoResVo;
import com.agency.business.service.AgencyApplyService;
import com.agency.business.service.OrderApplyService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

/**
 */
@Controller
public class AgencyApplyResourceImpl implements AgencyApplyResource {

    private static final Logger logger = LoggerFactory.getLogger(AgencyApplyResourceImpl.class);
    @Autowired
    private AgencyApplyService agencyApplyService;

    @Override
    public AgencyInfoResVo saveAgencyInfo(AgencyInfoReqVo agencyInfoReqVo) {
        return agencyApplyService.saveAgencyInfo(agencyInfoReqVo);  //To change body of implemented methods use File | Settings | File Templates.
    }
    @Override
    public AgencyInfoResVo updateAgencyInfo(AgencyInfoReqVo agencyInfoReqVo) {
        return agencyApplyService.updateAgencyInfo(agencyInfoReqVo);  //To change body of implemented methods use File | Settings | File Templates.
    }

    @Override
    public AgencyInfoResVo queryAgencyInfo(AgencyInfoReqVo agencyInfoReqVo) {
        return agencyApplyService.queryAgencyInfo(agencyInfoReqVo);  //To change body of implemented methods use File | Settings | File Templates.
    }
}
