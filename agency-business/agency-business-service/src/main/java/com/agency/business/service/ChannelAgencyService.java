package com.agency.business.service;
import com.agency.business.export.vo.ChannelAgencyReqVo;
import com.agency.business.export.vo.ChannelAgencyResVo;

/**渠道管理商1
 */
public interface ChannelAgencyService {

    public ChannelAgencyResVo saveChannelAgency(ChannelAgencyReqVo channelAgencyReqVo);

    public ChannelAgencyResVo updateChannelAgency(ChannelAgencyReqVo channelAgencyReqVo);

    public ChannelAgencyResVo queryChannelAgency(ChannelAgencyReqVo channelAgencyReqVo);
}
