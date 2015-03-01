package com.agency.business.export;

import com.agency.business.export.vo.ChannelAgencyReqVo;
import com.agency.business.export.vo.ChannelAgencyResVo;

import javax.ws.rs.Consumes;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;

/**
 *渠道管理商
 */
@Path("/agency/service/channelagency")
@Consumes({"application/json"})
@Produces({"application/json"})
public interface ChannelAgencyResource {
    /**
     * 保存渠道商管理
     */
    @POST
    @Path("/saveChannelAgency")
    public ChannelAgencyResVo saveChanneAgency(ChannelAgencyReqVo channelAgencyReqVo);
    /**
     * 更新渠道商管理
     *
     * @param
     * @return
     */
    @POST
    @Path("updateChannelAgency")
    public ChannelAgencyResVo updateChanneAgency(ChannelAgencyReqVo channelAgencyReqVo);

    /**
     * 查询渠道商管理
     * @return
     */
    @POST
    @Path("queryChannelAgency")
    public ChannelAgencyResVo queryChanneAgency(ChannelAgencyReqVo channelAgencyReqVo);

}