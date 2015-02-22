package com.agency.business.service;
import com.agency.business.export.vo.GoodsRebateApplyInfoReqVo;
import com.agency.business.export.vo.GoodsRebateApplyInfoResVo;
import com.agency.business.export.vo.InitInvoiceApplyInfoReqVo;
import com.agency.business.export.vo.InitInvoiceApplyInfoResVo;

/**返利管理
 */
public interface GoodsRebateApplyService {

    public GoodsRebateApplyInfoResVo saveGoodsRebateApply(GoodsRebateApplyInfoReqVo goodsRebateApplyInfoReqVo);

    public GoodsRebateApplyInfoResVo updateGoodsRebateApply(GoodsRebateApplyInfoReqVo goodsRebateApplyInfoReqVo);

    public GoodsRebateApplyInfoResVo queryGoodsRebateApply(GoodsRebateApplyInfoReqVo goodsRebateApplyInfoReqVo);
}
