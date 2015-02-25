package com.agency.business.service.impl;


import com.agency.business.common.utils.FormatUtil;
import com.agency.business.dao.OrdersPurchaseMapper;
import com.agency.business.domain.bean.InitOrderApplyInfo;
import com.agency.business.export.vo.AgencyOrderApplyInfoReqVo;
import com.agency.business.export.vo.AgencyOrderApplyInfoResVo;
import com.agency.business.export.vo.InitOrderApplyInfoReqVo;
import com.agency.business.export.vo.InitOrderApplyInfoResVo;
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
import com.agency.business.common.Constants;
import java.math.BigDecimal;
import java.util.List;

/**
 */
@Service("orderApplyService")
public class OrderApplyServiceImpl implements OrderApplyService {
    private static final Logger logger = LoggerFactory.getLogger(OrderApplyServiceImpl.class);
    @Autowired
    private OrdersPurchaseMapper ordersPurchaseMapper;
    @Autowired
    @Qualifier("orderTransactionManager")
    private PlatformTransactionManager orderTransactionManager;

    @Override
    public InitOrderApplyInfoResVo saveInitOrderApplyInfo(InitOrderApplyInfoReqVo userActiveApplyReqVo) {
        InitOrderApplyInfoResVo initOrderApplyInfoResVo = new InitOrderApplyInfoResVo();
        logger.info("订购产品请求参数:" + GsonUtils.toJson(userActiveApplyReqVo));

        DefaultTransactionDefinition defaultTransactionDefinition = new DefaultTransactionDefinition();
        defaultTransactionDefinition.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);
        defaultTransactionDefinition.setIsolationLevel(TransactionDefinition.ISOLATION_READ_COMMITTED);
        TransactionStatus transactionStatus = orderTransactionManager.getTransaction(defaultTransactionDefinition);
        try {
            ordersPurchaseMapper.saveInitOrderApplyInfo(buildInitOrderApplyInfo(userActiveApplyReqVo));
            orderTransactionManager.commit(transactionStatus);
        } catch (Exception e) {
            orderTransactionManager.rollback(transactionStatus);
            logger.error("插入订购产品请求异常", e);
            initOrderApplyInfoResVo.setSuccess(false);
        }
        return initOrderApplyInfoResVo;
    }

    @Override
    public InitOrderApplyInfoResVo updateInitOrderApplyInfo(InitOrderApplyInfoReqVo userActiveApplyReqVo) {
        InitOrderApplyInfoResVo initOrderApplyInfoResVo = new InitOrderApplyInfoResVo();
        logger.info("修改购买产品请求参数:" + GsonUtils.toJson(userActiveApplyReqVo));
        DefaultTransactionDefinition defaultTransactionDefinition = new DefaultTransactionDefinition();
        defaultTransactionDefinition.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);
        defaultTransactionDefinition.setIsolationLevel(TransactionDefinition.ISOLATION_READ_COMMITTED);
        TransactionStatus transactionStatus = orderTransactionManager.getTransaction(defaultTransactionDefinition);
        try {
            ordersPurchaseMapper.updateInitOrderApplyInfo(buildInitOrderApplyInfo(userActiveApplyReqVo));
            orderTransactionManager.commit(transactionStatus);
        } catch (Exception e) {
            orderTransactionManager.rollback(transactionStatus);
            logger.error("修改购买产品异常",e);
            initOrderApplyInfoResVo.setSuccess(false);
        }
        return initOrderApplyInfoResVo;
    }

    @Override
    public InitOrderApplyInfoResVo queryInitOrderApplyInfo(InitOrderApplyInfoReqVo userActiveApplyReqVo) {
        logger.info("查询购买产品请求参数:" + GsonUtils.toJson(userActiveApplyReqVo));
        InitOrderApplyInfoResVo initOrderApplyInfoResVo = new InitOrderApplyInfoResVo();
        InitOrderApplyInfo initOrderApplyInfo = new InitOrderApplyInfo();
        initOrderApplyInfo = buildInitOrderApplyInfo(userActiveApplyReqVo);
        long count = ordersPurchaseMapper.countInitOrderApplyInfo(initOrderApplyInfo);
        initOrderApplyInfoResVo.setRecordsCount(count);
        initOrderApplyInfoResVo.setPageNo(userActiveApplyReqVo.getPageNo());
        initOrderApplyInfoResVo.setPageSize(userActiveApplyReqVo.getPageSize());
        if(userActiveApplyReqVo.getPageNo() != 0){
            initOrderApplyInfo.setStartRow((userActiveApplyReqVo.getPageNo()-1) * userActiveApplyReqVo.getPageSize());
            initOrderApplyInfo.setEndRow(initOrderApplyInfo.getStartRow() + userActiveApplyReqVo.getPageSize() - 1);
        }
        List<InitOrderApplyInfo> list =  ordersPurchaseMapper.queryInitOrderApplyInfo(initOrderApplyInfo);
        initOrderApplyInfoResVo.setInfoarrys(list);
        return initOrderApplyInfoResVo;
    }

    public InitOrderApplyInfoResVo deleteInitOrderApplyInfo(InitOrderApplyInfoReqVo userActiveApplyReqVo){
        InitOrderApplyInfoResVo initOrderApplyInfoResVo = new InitOrderApplyInfoResVo();
        logger.info("删除购买产品请求参数:" + GsonUtils.toJson(userActiveApplyReqVo));
        DefaultTransactionDefinition defaultTransactionDefinition = new DefaultTransactionDefinition();
        defaultTransactionDefinition.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);
        defaultTransactionDefinition.setIsolationLevel(TransactionDefinition.ISOLATION_READ_COMMITTED);
        TransactionStatus transactionStatus = orderTransactionManager.getTransaction(defaultTransactionDefinition);
        try {
            ordersPurchaseMapper.deleteInitOrderApplyInfo(buildInitOrderApplyInfo(userActiveApplyReqVo));
            orderTransactionManager.commit(transactionStatus);
        } catch (Exception e) {
            orderTransactionManager.rollback(transactionStatus);
            logger.error("删除购买产品异常",e);
            initOrderApplyInfoResVo.setSuccess(false);
        }
        return initOrderApplyInfoResVo;
    }

    public AgencyOrderApplyInfoResVo queryAgencyOrderInfo(AgencyOrderApplyInfoReqVo agencyOrderApplyInfoReqVo){
        AgencyOrderApplyInfoResVo agencyOrderApplyInfoResVo = new AgencyOrderApplyInfoResVo();
        InitOrderApplyInfo initOrderApplyInfo = new InitOrderApplyInfo();
        initOrderApplyInfo.setLoginId(agencyOrderApplyInfoReqVo.getLoginId());
        initOrderApplyInfo.setStartDate(FormatUtil.parseDate(agencyOrderApplyInfoReqVo.getBeginTime(),Constants.DATE_FORMAT_1));
        initOrderApplyInfo.setEndDate(FormatUtil.parseDate(agencyOrderApplyInfoReqVo.getEndTime(),Constants.DATE_FORMAT_1));
        InitOrderApplyInfo initOrderApplyInfo1 = ordersPurchaseMapper.queryOrderApplyInfo(initOrderApplyInfo);
        agencyOrderApplyInfoResVo.setSumAmount(initOrderApplyInfo1.getAmount().toString());
        //        调用订单系统的代理商下单接口（已经支付）

        return agencyOrderApplyInfoResVo;
    }

    private InitOrderApplyInfo buildInitOrderApplyInfo(InitOrderApplyInfoReqVo initOrderApplyInfoReqVo){
        InitOrderApplyInfo initOrderApplyInfo = new InitOrderApplyInfo();
        initOrderApplyInfo.setPurchaseNo(initOrderApplyInfoReqVo.getPurchaseNo());
        initOrderApplyInfo.setPurchaseNumber(initOrderApplyInfoReqVo.getPurchaseNumber());
        if(initOrderApplyInfoReqVo.getPurchaseDate() != null && initOrderApplyInfoReqVo.getPurchaseDate().length() != 0){
            initOrderApplyInfo.setPurchaseDate(FormatUtil.parseDate(initOrderApplyInfoReqVo.getPurchaseDate(),Constants.DATE_FORMAT_1));
        }
        initOrderApplyInfo.setPurchaseProduct(initOrderApplyInfoReqVo.getPurchaseProduct());
        initOrderApplyInfo.setPurchaseStatus(initOrderApplyInfoReqVo.getPurchaseStatus());
        initOrderApplyInfo.setAmount(initOrderApplyInfoReqVo.getAmount() == null ? BigDecimal.ZERO : new BigDecimal(initOrderApplyInfoReqVo.getAmount()));
        initOrderApplyInfo.setPurchaseType(initOrderApplyInfoReqVo.getPurchaseType());
        initOrderApplyInfo.setOrderType(initOrderApplyInfoReqVo.getOrderType());
        initOrderApplyInfo.setDeliveryStatus(initOrderApplyInfoReqVo.getDeliveryStatus());
        if(initOrderApplyInfoReqVo.getDeliveryDate() != null && initOrderApplyInfoReqVo.getDeliveryDate().length() != 0){
            initOrderApplyInfo.setDeliveryDate(FormatUtil.parseDate(initOrderApplyInfoReqVo.getDeliveryDate(),Constants.DATE_FORMAT_1));
        }

        initOrderApplyInfo.setOperator(initOrderApplyInfoReqVo.getOperator());
        initOrderApplyInfo.setRemark(initOrderApplyInfoReqVo.getRemark());
        initOrderApplyInfo.setExtParam(initOrderApplyInfoReqVo.getExtParam());
        logger.info("采购产品转化后请求参数:" + GsonUtils.toJson(initOrderApplyInfo));
        return  initOrderApplyInfo;
    }


}
