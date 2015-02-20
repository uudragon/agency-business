package com.agency.business.service.impl;


import com.agency.business.common.Constants;
import com.agency.business.common.InvoiceStatusConstants;
import com.agency.business.common.utils.FormatUtil;
import com.agency.business.dao.InvoiceApplyMapper;
import com.agency.business.dao.OrdersPurchaseMapper;
import com.agency.business.domain.bean.InitInvoiceApplyInfo;
import com.agency.business.domain.bean.InitOrderApplyInfo;
import com.agency.business.export.vo.InitInvoiceApplyInfoReqVo;
import com.agency.business.export.vo.InitInvoiceApplyInfoResVo;
import com.agency.business.export.vo.InitOrderApplyInfoReqVo;
import com.agency.business.export.vo.InitOrderApplyInfoResVo;
import com.agency.business.service.InvoiceApplyService;
import com.agency.business.service.OrderApplyService;
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
import org.springframework.util.StringUtils;

import java.math.BigDecimal;
import java.util.List;

/**
 */
@Service("invoiceApplyService")
public class InvoiceApplyServiceImpl implements InvoiceApplyService {
    private static final Logger logger = LoggerFactory.getLogger(InvoiceApplyServiceImpl.class);
    @Autowired
    private InvoiceApplyMapper invoiceApplyMapper;
    @Autowired
    @Qualifier("orderTransactionManager")
    private PlatformTransactionManager invoiceTransactionManager;

    @Override
    public InitInvoiceApplyInfoResVo saveInvoiceApplyInfo(InitInvoiceApplyInfoReqVo initInvoiceApplyInfoReqVo) {
        InitInvoiceApplyInfoResVo initInvoiceApplyInfoResVo = new InitInvoiceApplyInfoResVo();
        DefaultTransactionDefinition defaultTransactionDefinition = new DefaultTransactionDefinition();
        defaultTransactionDefinition.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);
        defaultTransactionDefinition.setIsolationLevel(TransactionDefinition.ISOLATION_READ_COMMITTED);
        TransactionStatus transactionStatus = invoiceTransactionManager.getTransaction(defaultTransactionDefinition);
        try {
            invoiceApplyMapper.saveInvoiceApplyInfo(buildInitInvoiceApplyInfo(initInvoiceApplyInfoReqVo));
            invoiceTransactionManager.commit(transactionStatus);
            initInvoiceApplyInfoResVo.setSuccess(true);
        } catch (Exception e) {
            invoiceTransactionManager.rollback(transactionStatus);
            logger.error("插入发票请求异常", e);
            initInvoiceApplyInfoResVo.setSuccess(false);
        }
        return initInvoiceApplyInfoResVo;  //To change body of implemented methods use File | Settings | File Templates.
    }

    @Override
    public InitInvoiceApplyInfoResVo updateInvoiceApplyInfo(InitInvoiceApplyInfoReqVo initInvoiceApplyInfoReqVo) {
        InitInvoiceApplyInfoResVo initInvoiceApplyInfoResVo = new InitInvoiceApplyInfoResVo();
        DefaultTransactionDefinition defaultTransactionDefinition = new DefaultTransactionDefinition();
        defaultTransactionDefinition.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);
        defaultTransactionDefinition.setIsolationLevel(TransactionDefinition.ISOLATION_READ_COMMITTED);
        TransactionStatus transactionStatus = invoiceTransactionManager.getTransaction(defaultTransactionDefinition);
        try {
            invoiceApplyMapper.updateInitInvoiceApplyInfo(buildInitInvoiceApplyInfo(initInvoiceApplyInfoReqVo));
            invoiceTransactionManager.commit(transactionStatus);
            initInvoiceApplyInfoResVo.setSuccess(true);
        } catch (Exception e) {
            invoiceTransactionManager.rollback(transactionStatus);
            logger.error("更新发票请求异常", e);
            initInvoiceApplyInfoResVo.setSuccess(false);
        }

        return null;  //To change body of implemented methods use File | Settings | File Templates.
    }

    @Override
    public InitInvoiceApplyInfoResVo queryInitInvoiceApplyInfo(InitInvoiceApplyInfoReqVo initInvoiceApplyInfoReqVo) {
        InitInvoiceApplyInfoResVo initInvoiceApplyInfoResVo = new InitInvoiceApplyInfoResVo();
        List<InitInvoiceApplyInfo> list = invoiceApplyMapper.queryInitInvoiceApplyInfo(buildInitInvoiceApplyInfo(initInvoiceApplyInfoReqVo));
        initInvoiceApplyInfoResVo.setInfoarrys(list);
        return initInvoiceApplyInfoResVo;  //To change body of implemented methods use File | Settings | File Templates.
    }

    public InitInvoiceApplyInfo buildInitInvoiceApplyInfo(InitInvoiceApplyInfoReqVo initInvoiceApplyInfoReqVo) {
        InitInvoiceApplyInfo initInvoiceApplyInfo = new InitInvoiceApplyInfo();
        initInvoiceApplyInfo.setAgentNo(initInvoiceApplyInfoReqVo.getAgentNo());
        initInvoiceApplyInfo.setAmount(initInvoiceApplyInfoReqVo.getAmount() == null ? BigDecimal.ZERO : new BigDecimal(initInvoiceApplyInfoReqVo.getAmount()));
        initInvoiceApplyInfo.setApplyMan(initInvoiceApplyInfoReqVo.getApplyMan());
        initInvoiceApplyInfo.setApplydate(FormatUtil.parseDate(initInvoiceApplyInfoReqVo.getApplydate(), Constants.DATE_FORMAT_1));
        initInvoiceApplyInfo.setBeginTime(FormatUtil.parseDate(initInvoiceApplyInfoReqVo.getBeginTime(), Constants.DATE_FORMAT_1));
        initInvoiceApplyInfo.setEndTime(FormatUtil.parseDate(initInvoiceApplyInfoReqVo.getBeginTime(), Constants.DATE_FORMAT_1));
        initInvoiceApplyInfo.setApplyNo(initInvoiceApplyInfoReqVo.getApplyNo());
        if (initInvoiceApplyInfo.getApplystatus() == null || initInvoiceApplyInfo.getApplystatus().length() == 0) {
            initInvoiceApplyInfo.setApplystatus(InvoiceStatusConstants.HASAPPLIED);
        } else {
            initInvoiceApplyInfo.setApplystatus(initInvoiceApplyInfoReqVo.getApplystatus());
        }
        initInvoiceApplyInfo.setInvoicehead(initInvoiceApplyInfoReqVo.getInvoicehead());
        initInvoiceApplyInfo.setOperator(initInvoiceApplyInfoReqVo.getApplyMan());
        logger.info("操作发票的请求参数:" + GsonUtils.toJson(initInvoiceApplyInfo));
        return initInvoiceApplyInfo;
    }
}
