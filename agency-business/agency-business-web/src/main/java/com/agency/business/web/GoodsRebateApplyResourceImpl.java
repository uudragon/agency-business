package com.agency.business.web;

import com.agency.business.export.GoodsRebateApplyResource;
import com.agency.business.export.vo.AgencyInfoReqVo;
import com.agency.business.export.vo.AgencyInfoResVo;
import com.agency.business.export.vo.GoodsRebateApplyInfoReqVo;
import com.agency.business.export.vo.GoodsRebateApplyInfoResVo;
import com.agency.business.service.AgencyApplyService;
import com.agency.business.service.GoodsRebateApplyService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
@Controller
public class GoodsRebateApplyResourceImpl implements GoodsRebateApplyResource {

    private static final Logger logger = LoggerFactory.getLogger(GoodsRebateApplyResourceImpl.class);
    @Autowired
    private GoodsRebateApplyService goodsRebateApplyService;

    @Override
    public GoodsRebateApplyInfoResVo saveGoodsRebateApplyInfo(GoodsRebateApplyInfoReqVo goodsRebateApplyInfoReqVo) {
        return goodsRebateApplyService.saveGoodsRebateApply(goodsRebateApplyInfoReqVo);  //To change body of implemented methods use File | Settings | File Templates.
    }

    @Override
    public GoodsRebateApplyInfoResVo updateGoodsRebateApplyInfo(GoodsRebateApplyInfoReqVo goodsRebateApplyInfoReqVo) {
        return goodsRebateApplyService.updateGoodsRebateApply(goodsRebateApplyInfoReqVo);  //To change body of implemented methods use File | Settings | File Templates.
    }

    @Override
    public GoodsRebateApplyInfoResVo queryGoodsRebateApplyInfo(GoodsRebateApplyInfoReqVo goodsRebateApplyInfoReqVo) {
        return goodsRebateApplyService.queryGoodsRebateApply(goodsRebateApplyInfoReqVo);  //To change body of implemented methods use File | Settings | File Templates.
    }
}
