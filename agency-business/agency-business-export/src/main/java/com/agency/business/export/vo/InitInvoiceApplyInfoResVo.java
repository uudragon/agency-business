package com.agency.business.export.vo;

import com.agency.business.domain.bean.InitInvoiceApplyInfo;
import com.agency.business.domain.bean.InitOrderApplyInfo;

import java.util.List;

/**查询订单
 */
public class InitInvoiceApplyInfoResVo extends BaseResVo {
    List <InitInvoiceApplyInfo> infoarrys;

    public List<InitInvoiceApplyInfo> getInfoarrys() {
        return infoarrys;
    }

    public void setInfoarrys(List<InitInvoiceApplyInfo> infoarrys) {
        this.infoarrys = infoarrys;
    }
}
