package com.agency.business.export.vo;

import com.agency.business.domain.bean.ChannelAgency;

import java.util.List;

public class ChannelAgencyResVo extends BaseResVo {

    List<ChannelAgency> infoarrys;

    public List<ChannelAgency> getInfoarrys() {
        return infoarrys;
    }

    public void setInfoarrys(List<ChannelAgency> infoarrys) {
        this.infoarrys = infoarrys;
    }
}
