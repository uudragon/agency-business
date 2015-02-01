package com.agency.business.dao;

import com.agency.business.domain.bean.InitOrderApplyInfo;

import java.util.List;

/**
 */
public interface OrdersPurchaseMapper {
    /**
     * 采购首期
     *
     * @param initOrderApplyInfo
     * @return
     */
    int saveInitOrderApplyInfo(InitOrderApplyInfo initOrderApplyInfo);

    int updateInitOrderApplyInfo(InitOrderApplyInfo initOrderApplyInfo);

    int deleteInitOrderApplyInfo(InitOrderApplyInfo initOrderApplyInfo);

    long countInitOrderApplyInfo(InitOrderApplyInfo initOrderApplyInfo);

    List<InitOrderApplyInfo> queryInitOrderApplyInfo(InitOrderApplyInfo initOrderApplyInfo);

}
