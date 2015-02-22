package com.agency.business.dao;

import com.agency.business.domain.bean.GoodsRebateApplyInfo;

import java.util.List;

/**返利管理
 */
public interface GoodsRebateMapper {

    int saveGoodsRebateApplyInfo(GoodsRebateApplyInfo GoodsRebate);

    int updateGoodsRebateApplyInfo(GoodsRebateApplyInfo GoodsRebate);

    long countGoodsRebateApplyInfo(GoodsRebateApplyInfo GoodsRebate);

    List<GoodsRebateApplyInfo> queryGoodsRebateApplyInfo(GoodsRebateApplyInfo GoodsRebate);

}
