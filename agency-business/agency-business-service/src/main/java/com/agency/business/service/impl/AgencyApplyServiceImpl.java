package com.agency.business.service.impl;


import com.agency.business.common.Constants;
import com.agency.business.common.InvoiceStatusConstants;
import com.agency.business.common.utils.FormatUtil;
import com.agency.business.dao.AgencyInfoMapper;
import com.agency.business.dao.InvoiceApplyMapper;
import com.agency.business.domain.bean.AgencyInfo;
import com.agency.business.domain.bean.InitInvoiceApplyInfo;
import com.agency.business.export.vo.AgencyInfoReqVo;
import com.agency.business.export.vo.AgencyInfoResVo;
import com.agency.business.export.vo.InitInvoiceApplyInfoReqVo;
import com.agency.business.export.vo.InitInvoiceApplyInfoResVo;
import com.agency.business.service.AgencyApplyService;
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

/**代理商管理
 */
@Service("agencyApplyService")
public class AgencyApplyServiceImpl implements AgencyApplyService {
    private static final Logger logger = LoggerFactory.getLogger(AgencyApplyServiceImpl.class);
    @Autowired
    private AgencyInfoMapper gencyInfoMapper;
    @Autowired
    @Qualifier("orderTransactionManager")
    private PlatformTransactionManager orderTransactionManager;
    @Override
    public AgencyInfoResVo saveAgencyInfo(AgencyInfoReqVo agencyInfoReqVo) {
        AgencyInfoResVo agencyInfoResVo = new AgencyInfoResVo();
        DefaultTransactionDefinition defaultTransactionDefinition = new DefaultTransactionDefinition();
        defaultTransactionDefinition.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);
        defaultTransactionDefinition.setIsolationLevel(TransactionDefinition.ISOLATION_READ_COMMITTED);
        TransactionStatus transactionStatus = orderTransactionManager.getTransaction(defaultTransactionDefinition);
        try {
            if(Constants.isDefault.equals(agencyInfoReqVo.getDefault())){

            }
            gencyInfoMapper.saveAgencyInfo(buildAgencyApplyInfo(agencyInfoReqVo));
            orderTransactionManager.commit(transactionStatus);
            agencyInfoResVo.setSuccess(true);
        } catch (Exception e) {
            orderTransactionManager.rollback(transactionStatus);
            logger.error("插入发票请求异常", e);
            agencyInfoResVo.setSuccess(false);
        }


        return null;
    }

    @Override
    public AgencyInfoResVo updateAgencyInfo(AgencyInfoReqVo agencyInfoReqVo) {
        return null;  //To change body of implemented methods use File | Settings | File Templates.
    }

    @Override
    public AgencyInfoResVo queryAgencyInfo(AgencyInfoReqVo agencyInfoReqVo) {
        return null;  //To change body of implemented methods use File | Settings | File Templates.
    }

    public AgencyInfo buildAgencyApplyInfo(AgencyInfoReqVo agencyInfoReqVo){
        AgencyInfo agencyInfo = new AgencyInfo();
        agencyInfo.setAddress(agencyInfoReqVo.getAddress());
        agencyInfo.setAgentNo(agencyInfoReqVo.getAgentNo());
        agencyInfo.setCity(agencyInfoReqVo.getCity());
        agencyInfo.setCompanyName(agencyInfoReqVo.getCompanyName());
        agencyInfo.setContactName(agencyInfoReqVo.getContactName());
        agencyInfo.setDefault(agencyInfoReqVo.getDefault());
        agencyInfo.setDistrict(agencyInfoReqVo.getDistrict());
        agencyInfo.setEmail(agencyInfoReqVo.getEmail());
        agencyInfo.setEndRow(agencyInfoReqVo.getEndRow());
        agencyInfo.setStartRow(agencyInfoReqVo.getStartRow());
        agencyInfo.setContactMobile(agencyInfoReqVo.getContactMobile());
        agencyInfo.setExtParam(agencyInfoReqVo.getExtParam());
        agencyInfo.setFax(agencyInfoReqVo.getFax());
        agencyInfo.setLoginId(agencyInfoReqVo.getLoginId());
        agencyInfo.setFixMobile(agencyInfoReqVo.getFixMobile());
        agencyInfo.setOperator(agencyInfoReqVo.getOperator());
        agencyInfo.setStreet(agencyInfoReqVo.getStreet());
        agencyInfo.setProvince(agencyInfoReqVo.getProvince());
        agencyInfo.setPost(agencyInfoReqVo.getPost());
        logger.info("操作代理商信息,请求参数:" + GsonUtils.toJson(agencyInfo));
        return agencyInfo;
    }
}
