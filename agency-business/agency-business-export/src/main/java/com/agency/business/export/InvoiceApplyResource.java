package com.agency.business.export;

import com.agency.business.export.vo.InitOrderApplyInfoReqVo;
import com.agency.business.export.vo.InitOrderApplyInfoResVo;

import javax.ws.rs.Consumes;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;

/**
 *订购首期产品和接口
 */
@Path("/service/invoiceApply")
@Consumes({"application/json"})
@Produces({"application/json"})
public interface InvoiceApplyResource {

    /**
     * 保存首期产品
     * @param
     * @return
     */
    @POST
    @Path("/saveInvoiceApplyInfo")
    public InitOrderApplyInfoResVo saveInvoiceApplyInfo(InitOrderApplyInfoReqVo userActiveApplyReqVo);

    
    /**
     * 更新首期产品
     * @param
     * @return
     */
    @POST
    @Path("updateInvoiceApplyInfo")
    public InitOrderApplyInfoResVo updateInvoiceApplyInfo(InitOrderApplyInfoReqVo userActiveApplyReqVo);

    /**
     * 查询首期产品
     * @param
     * @return
     */
    @POST
    @Path("queryInitOrderApplyInfo")
    public InitOrderApplyInfoResVo queryInitOrderApplyInfo(InitOrderApplyInfoReqVo userActiveApplyReqVo);

    /**
     * 删除查询首期产品
     * @param
     * @return
     */
    @POST
    @Path("deleteInvoiceApplyInfo")
    public InitOrderApplyInfoResVo deleteInvoiceApplyInfo(InitOrderApplyInfoReqVo userActiveApplyReqVo);
}
