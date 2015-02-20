package com.agency.business.export.vo;

import com.agency.business.domain.bean.InitInvoiceApplyInfo;
import com.agency.business.domain.bean.InitOrderApplyInfo;

import java.util.List;

/**查询订单
 */
public class InitInvoiceApplyInfoResVo extends BaseResVo {
    List <InitInvoiceApplyInfo> infoarrys;
    private int pageSize;
    private int pageNo;
    private long recordsCount;

    public int getPageSize() {
        return pageSize;
    }

    public void setPageSize(int pageSize) {
        this.pageSize = pageSize;
    }

    public int getPageNo() {
        return pageNo;
    }

    public void setPageNo(int pageNo) {
        this.pageNo = pageNo;
    }

    public long getRecordsCount() {
        return recordsCount;
    }

    public void setRecordsCount(long recordsCount) {
        this.recordsCount = recordsCount;
    }

    public List<InitInvoiceApplyInfo> getInfoarrys() {
        return infoarrys;
    }

    public void setInfoarrys(List<InitInvoiceApplyInfo> infoarrys) {
        this.infoarrys = infoarrys;
    }
}
