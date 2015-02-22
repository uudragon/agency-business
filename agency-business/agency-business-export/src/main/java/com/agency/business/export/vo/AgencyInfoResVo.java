package com.agency.business.export.vo;

import com.agency.business.domain.bean.AgencyInfo;

import java.util.List;

/**
 */
public class AgencyInfoResVo extends BaseResVo {

    List<AgencyInfo> infoarrys;

    public List<AgencyInfo> getInfoarrys() {
        return infoarrys;
    }

    public void setInfoarrys(List<AgencyInfo> infoarrys) {
        this.infoarrys = infoarrys;
    }
}
