package com.agency.business.export.vo;

import com.agency.business.domain.bean.GoodsRebateApplyInfo;
import com.agency.business.domain.bean.InitInvoiceApplyInfo;

import java.util.List;

/**返利管理
 */
public class GoodsRebateApplyInfoResVo extends BaseResVo {
    List <GoodsRebateApplyInfo> infoarrys;
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

    public List<GoodsRebateApplyInfo> getInfoarrys() {
        return infoarrys;
    }

    public void setInfoarrys(List<GoodsRebateApplyInfo> infoarrys) {
        this.infoarrys = infoarrys;
    }
}
