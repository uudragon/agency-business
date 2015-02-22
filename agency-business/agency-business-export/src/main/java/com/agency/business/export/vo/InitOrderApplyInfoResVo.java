package com.agency.business.export.vo;

import com.agency.business.domain.bean.InitOrderApplyInfo;

import java.util.List;

/**
 */
public class InitOrderApplyInfoResVo extends BaseResVo {

    List <InitOrderApplyInfo> infoarrys;

    public List<InitOrderApplyInfo> getInfoarrys() {
        return infoarrys;
    }

    public void setInfoarrys(List<InitOrderApplyInfo> infoarrys) {
        this.infoarrys = infoarrys;
    }
}
