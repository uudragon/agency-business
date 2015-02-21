package com.agency.business.export;

import com.agency.business.export.vo.InitOrderApplyInfoReqVo;
import com.agency.business.export.vo.InitOrderApplyInfoResVo;

import javax.ws.rs.Consumes;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;

/**
 *返利接口
 */
@Path("/service/goodsrebateApply")
@Consumes({"application/json"})
@Produces({"application/json"})
public interface GoodsRebateApplyResource {

    /**
     * 保存返利管理
     * @return
     */
    @POST
    @Path("/saveGoodsRebateApplyInfo")
    public InitOrderApplyInfoResVo saveInvoiceApplyInfo(InitOrderApplyInfoReqVo userActiveApplyReqVo);
    /**
     * 更新返利管理
     *
     * @param
     * @return
     */
    @POST
    @Path("updateGoodsRebateApplyInfo")
    public InitOrderApplyInfoResVo updateInvoiceApplyInfo(InitOrderApplyInfoReqVo userActiveApplyReqVo);

    /**
     * 查询返利管理
     *
     * @param
     * @return
     */
    @POST
    @Path("queryGoodsRebateApplyInfo")
    public InitOrderApplyInfoResVo queryInitInvoiceApplyInfo(InitOrderApplyInfoReqVo userActiveApplyReqVo);

}