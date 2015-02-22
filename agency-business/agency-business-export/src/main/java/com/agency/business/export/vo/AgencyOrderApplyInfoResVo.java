package com.agency.business.export.vo;

import com.agency.business.domain.bean.InitInvoiceApplyInfo;

import java.math.BigDecimal;
import java.util.List;

/**查询订单
 */
public class AgencyOrderApplyInfoResVo extends BaseResVo {

    //    发票总金额
    private String SumAmount;

    public String getSumAmount() {
        return SumAmount;
    }

    public void setSumAmount(String sumAmount) {
        SumAmount = sumAmount;
    }
}
