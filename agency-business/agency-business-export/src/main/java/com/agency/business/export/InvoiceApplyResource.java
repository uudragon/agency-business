package com.agency.business.export;

import com.agency.business.export.vo.InitInvoiceApplyInfoReqVo;
import com.agency.business.export.vo.InitInvoiceApplyInfoResVo;
import com.agency.business.export.vo.InitOrderApplyInfoReqVo;
import com.agency.business.export.vo.InitOrderApplyInfoResVo;

import javax.ws.rs.Consumes;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;

/**
 * 订购首期产品和接口
 */
@Path("/agency/service/invoiceApply")
@Consumes({"application/json"})
@Produces({"application/json"})
public interface InvoiceApplyResource {

    /**
     * 保存发票信息
     * @return
     */
    @POST
    @Path("/saveInvoiceApplyInfo")
    public InitInvoiceApplyInfoResVo saveInvoiceApplyInfo(InitInvoiceApplyInfoReqVo initInvoiceApplyInfoReqVo);
    /**
     * 更新发票信息
     *
     * @param
     * @return
     */
    @POST
    @Path("updateInvoiceApplyInfo")
    public InitInvoiceApplyInfoResVo updateInvoiceApplyInfo(InitInvoiceApplyInfoReqVo initInvoiceApplyInfoReqVo);

    /**
     * 查询发票信息
     *
     * @param
     * @return
     */
    @POST
    @Path("queryInitInvoiceApplyInfo")
    public InitInvoiceApplyInfoResVo queryInvoiceApplyInfo(InitInvoiceApplyInfoReqVo initInvoiceApplyInfoReqVo);

}