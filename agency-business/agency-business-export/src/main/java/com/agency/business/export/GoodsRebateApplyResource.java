package com.agency.business.export;

import com.agency.business.export.vo.GoodsRebateApplyInfoReqVo;
import com.agency.business.export.vo.GoodsRebateApplyInfoResVo;

import javax.ws.rs.Consumes;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
/**
 *返利接口
 */
@Path("/agency/service/goodsrebateApply")
@Consumes({"application/json"})
@Produces({"application/json"})
public interface GoodsRebateApplyResource {

    /**
     * 保存返利管理
     * @return
     */
    @POST
    @Path("/saveGoodsRebateApplyInfo")
    public GoodsRebateApplyInfoResVo saveGoodsRebateApplyInfo(GoodsRebateApplyInfoReqVo goodsRebateApplyInfoReqVo);
    /**
     * 更新返利管理
     *
     * @param
     * @return
     */
    @POST
    @Path("updateGoodsRebateApplyInfo")
    public GoodsRebateApplyInfoResVo updateGoodsRebateApplyInfo(GoodsRebateApplyInfoReqVo goodsRebateApplyInfoReqVo);

    /**
     * 查询返利管理
     * @param
     * @return
     */
    @POST
    @Path("queryGoodsRebateApplyInfo")
    public GoodsRebateApplyInfoResVo queryGoodsRebateApplyInfo(GoodsRebateApplyInfoReqVo goodsRebateApplyInfoReqVo);
}