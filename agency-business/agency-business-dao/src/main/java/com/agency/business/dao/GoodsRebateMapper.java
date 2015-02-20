package com.agency.business.dao;

import com.agency.business.domain.bean.InitOrderApplyInfo;

import java.util.List;

/**返利管理
 */
public interface GoodsRebateMapper {
    /**
     *
     */
    int saveInitOrderApplyInfo(InitOrderApplyInfo initOrderApplyInfo);

    int updateInitOrderApplyInfo(InitOrderApplyInfo initOrderApplyInfo);

    int deleteInitOrderApplyInfo(InitOrderApplyInfo initOrderApplyInfo);

    long countInitOrderApplyInfo(InitOrderApplyInfo initOrderApplyInfo);

    List<InitOrderApplyInfo> queryInitOrderApplyInfo(InitOrderApplyInfo initOrderApplyInfo);
//  查询代理商金额
    InitOrderApplyInfo queryOrderApplyInfo(InitOrderApplyInfo initOrderApplyInfo);
}
