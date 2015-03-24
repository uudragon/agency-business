package com.agency.business.service.impl;


import com.agency.business.common.Constants;
import com.agency.business.common.utils.FormatUtil;
import com.agency.business.dao.AgencyInfoMapper;
import com.agency.business.dao.ChannelAgencyMapper;
import com.agency.business.domain.bean.AgencyInfo;
import com.agency.business.domain.bean.ChannelAgency;
import com.agency.business.domain.bean.GoodsRebateApplyInfo;
import com.agency.business.export.vo.*;
import com.agency.business.service.AgencyApplyService;
import com.agency.business.service.ChannelAgencyService;
import com.jd.payment.paycommon.utils.GsonUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.TransactionDefinition;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;

import java.math.BigDecimal;
import java.util.List;

/**
 * 渠道管理商
 */
@Service("channelAgencyService")
public class ChannelAgencyServiceImpl implements ChannelAgencyService {
    private static final Logger logger = LoggerFactory.getLogger(ChannelAgencyServiceImpl.class);
    @Autowired
    private ChannelAgencyMapper channelAgencyMapper;
    @Autowired
    @Qualifier("orderTransactionManager")
    private PlatformTransactionManager orderTransactionManager;

    @Override
    public ChannelAgencyResVo saveChannelAgency(ChannelAgencyReqVo channelAgencyReqVo) {
        ChannelAgencyResVo channelAgencyResVo = new ChannelAgencyResVo();
        DefaultTransactionDefinition defaultTransactionDefinition = new DefaultTransactionDefinition();
        defaultTransactionDefinition.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);
        defaultTransactionDefinition.setIsolationLevel(TransactionDefinition.ISOLATION_READ_COMMITTED);
        TransactionStatus transactionStatus = orderTransactionManager.getTransaction(defaultTransactionDefinition);
        try {
            channelAgencyMapper.saveChannelAgency(buildChannelAgency(channelAgencyReqVo));
            orderTransactionManager.commit(transactionStatus);
            channelAgencyResVo.setSuccess(true);
        } catch (Exception e) {
            orderTransactionManager.rollback(transactionStatus);
            logger.error("渠道经理管理请求异常", e);
            channelAgencyResVo.setSuccess(false);
        }
        return channelAgencyResVo;
    }
    @Override
    public ChannelAgencyResVo updateChannelAgency(ChannelAgencyReqVo channelAgencyReqVo) {
        ChannelAgencyResVo channelAgencyResVo = new ChannelAgencyResVo();
        DefaultTransactionDefinition defaultTransactionDefinition = new DefaultTransactionDefinition();
        defaultTransactionDefinition.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);
        defaultTransactionDefinition.setIsolationLevel(TransactionDefinition.ISOLATION_READ_COMMITTED);
        TransactionStatus transactionStatus = orderTransactionManager.getTransaction(defaultTransactionDefinition);
        try {
            channelAgencyMapper.updateChannelAgency(buildChannelAgency(channelAgencyReqVo));
            orderTransactionManager.commit(transactionStatus);
            channelAgencyResVo.setSuccess(true);
        } catch (Exception e) {
            orderTransactionManager.rollback(transactionStatus);
            logger.error("渠道经理管理请求异常", e);
            channelAgencyResVo.setSuccess(false);
        }
        return channelAgencyResVo;  //To change body of implemented methods use File | Settings | File Templates.
    }
    @Override
    public ChannelAgencyResVo queryChannelAgency(ChannelAgencyReqVo channelAgencyReqVo) {

        return null;  //To change body of implemented methods use File | Settings | File Templates.
    }
    public ChannelAgency buildChannelAgency(ChannelAgencyReqVo channelAgencyReqVo) {
        ChannelAgency channelAgency  = new ChannelAgency();
        if (channelAgencyReqVo.getContactendime() != null && channelAgencyReqVo.getContactendime().length() != 0) {
            channelAgency.setContactendime(FormatUtil.parseDate(channelAgencyReqVo.getContactendime(), Constants.DATE_FORMAT_1));
        }
        if (channelAgencyReqVo.getContactsigntime() != null && channelAgencyReqVo.getContactsigntime().length() != 0) {
            channelAgency.setContactsigntime(FormatUtil.parseDate(channelAgencyReqVo.getContactsigntime(), Constants.DATE_FORMAT_1));
        }
        if (channelAgencyReqVo.getTaskstarttime() != null && channelAgencyReqVo.getTaskstarttime().length() != 0) {
            channelAgency.setTaskstarttime(FormatUtil.parseDate(channelAgencyReqVo.getTaskstarttime(), Constants.DATE_FORMAT_1));
        }
        if (channelAgencyReqVo.getTaskendtime() != null && channelAgencyReqVo.getTaskendtime().length() != 0) {
            channelAgency.setTaskendtime(FormatUtil.parseDate(channelAgencyReqVo.getTaskendtime(), Constants.DATE_FORMAT_1));
        }
        channelAgency.setAddress(channelAgencyReqVo.getAddress());
        channelAgency.setAgencyPhone(channelAgencyReqVo.getAgencyPhone());
        channelAgency.setAgencyName(channelAgencyReqVo.getAgencyName());
        channelAgency.setChannelLoginName(channelAgencyReqVo.getChannelLoginName());
        channelAgency.setAbolishreason(channelAgencyReqVo.getAbolishreason());
        channelAgency.setAgencyAreaNo(channelAgencyReqVo.getAgencyAreaNo());
        channelAgency.setAgencystatus(channelAgencyReqVo.getAgencystatus());
        channelAgency.setAgencyfees((channelAgencyReqVo.getAgencyfees() == null || channelAgencyReqVo.getAgencyfees().length() == 0)? BigDecimal.ZERO:new BigDecimal(channelAgencyReqVo.getAgencyfees()));
        channelAgency.setAgencyloginId(channelAgencyReqVo.getAgencyloginId());
        channelAgency.setChannelloginId(channelAgencyReqVo.getChannelloginId());
        channelAgency.setCity(channelAgencyReqVo.getCity());
        channelAgency.setProvince(channelAgencyReqVo.getProvince());
        channelAgency.setDistrict(channelAgencyReqVo.getDistrict());
        channelAgency.setContacttype(channelAgencyReqVo.getContacttype());
        channelAgency.setIscontract(channelAgencyReqVo.getIscontract());
        channelAgency.setTaskstandards(channelAgencyReqVo.getTaskstandards());
        channelAgency.setOperator(channelAgencyReqVo.getOperator());
        channelAgency.setExtParam(channelAgencyReqVo.getExtParam());
        channelAgency.setRemark(channelAgencyReqVo.getRemark());
        logger.info("操作返利管理,请求参数:" + GsonUtils.toJson(channelAgency));
        return channelAgency;
    }

}
