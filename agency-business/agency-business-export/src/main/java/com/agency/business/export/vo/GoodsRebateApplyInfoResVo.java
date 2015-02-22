package com.agency.business.export.vo;

import com.agency.business.domain.bean.GoodsRebateApplyInfo;
import com.agency.business.domain.bean.InitInvoiceApplyInfo;

import java.util.List;

/**返利管理
 */
public class GoodsRebateApplyInfoResVo extends BaseResVo {
    List <GoodsRebateApplyInfo> infoarrys;

    public List<GoodsRebateApplyInfo> getInfoarrys() {
        return infoarrys;
    }

    public void setInfoarrys(List<GoodsRebateApplyInfo> infoarrys) {
        this.infoarrys = infoarrys;
    }
}
