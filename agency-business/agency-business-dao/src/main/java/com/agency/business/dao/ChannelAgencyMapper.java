package com.agency.business.dao;


import com.agency.business.domain.bean.ChannelAgency;

import java.util.List;


/**渠道商管理
 */
public interface ChannelAgencyMapper {

    int saveChannelAgency(ChannelAgency channelAgency);

    int updateChannelAgency(ChannelAgency channelAgency);

    int deleteChannelAgency(ChannelAgency channelAgency);

    long countChannelAgency(ChannelAgency channelAgency);

    List<ChannelAgency> queryChannelAgency(ChannelAgency channelAgency);
}
