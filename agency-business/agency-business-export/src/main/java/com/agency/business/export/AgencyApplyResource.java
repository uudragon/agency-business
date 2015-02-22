package com.agency.business.export;

import com.agency.business.export.vo.AgencyInfoReqVo;
import com.agency.business.export.vo.AgencyInfoResVo;
import com.agency.business.export.vo.InitOrderApplyInfoReqVo;
import com.agency.business.export.vo.InitOrderApplyInfoResVo;

import javax.ws.rs.Consumes;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;

/**
 *代理商信息管理
 */
@Path("/service/agencyApply")
@Consumes({"application/json"})
@Produces({"application/json"})
public interface AgencyApplyResource {
    /**
     * 保存代理商信息
     */
    @POST
    @Path("/saveAgencyInfo")
    public AgencyInfoResVo saveAgencyInfo(AgencyInfoReqVo agencyInfoReqVo);
    /**
     * 更新返利管理
     *
     * @param
     * @return
     */
    @POST
    @Path("updateAgencyInfo")
    public AgencyInfoResVo updateAgencyInfo(AgencyInfoReqVo agencyInfoReqVo);

    /**
     * 查询返利管理
     * @return
     */
    @POST
    @Path("queryAgencyInfo")
    public AgencyInfoResVo queryAgencyInfo(AgencyInfoReqVo agencyInfoReqVo);

}