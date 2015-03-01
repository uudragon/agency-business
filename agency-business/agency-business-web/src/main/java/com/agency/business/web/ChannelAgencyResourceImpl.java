package com.agency.business.web;

import com.agency.business.export.ChannelAgencyResource;
import com.agency.business.export.vo.ChannelAgencyReqVo;
import com.agency.business.export.vo.ChannelAgencyResVo;
import com.agency.business.service.ChannelAgencyService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

/**
 */
@Controller
public class ChannelAgencyResourceImpl implements ChannelAgencyResource {

    private static final Logger logger = LoggerFactory.getLogger(ChannelAgencyResourceImpl.class);
    @Autowired
    private ChannelAgencyService channelAgencyService;

    /**
     * 保存渠道商管理
     */
    public ChannelAgencyResVo saveChanneAgency(ChannelAgencyReqVo channelAgencyReqVo){
        return channelAgencyService.saveChannelAgency(channelAgencyReqVo);
    }
    /**
     * 更新渠道商管理
     *
     * @param
     * @return
     */
    public ChannelAgencyResVo updateChanneAgency(ChannelAgencyReqVo channelAgencyReqVo){
        return channelAgencyService.updateChannelAgency(channelAgencyReqVo);
    }

    /**
     * 查询渠道商管理
     * @return
     */
    public ChannelAgencyResVo queryChanneAgency(ChannelAgencyReqVo channelAgencyReqVo){
        return channelAgencyService.queryChannelAgency(channelAgencyReqVo);
    }

}
