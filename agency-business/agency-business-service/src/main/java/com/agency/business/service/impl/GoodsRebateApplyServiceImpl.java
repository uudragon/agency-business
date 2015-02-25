package com.agency.business.service.impl;


import com.agency.business.common.Constants;
import com.agency.business.common.utils.FormatUtil;
import com.agency.business.dao.GoodsRebateMapper;
import com.agency.business.domain.bean.GoodsRebateApplyInfo;
import com.agency.business.export.vo.*;
import com.agency.business.service.GoodsRebateApplyService;
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
 * 返利管理1
 */
@Service("goodsRebateApplyService")
public class GoodsRebateApplyServiceImpl implements GoodsRebateApplyService {
    private static final Logger logger = LoggerFactory.getLogger(GoodsRebateApplyServiceImpl.class);
    @Autowired
    private GoodsRebateMapper goodsRebateMapper;
    @Autowired
    @Qualifier("orderTransactionManager")
    private PlatformTransactionManager orderTransactionManager;

    @Override
    public GoodsRebateApplyInfoResVo saveGoodsRebateApply(GoodsRebateApplyInfoReqVo goodsRebateApplyInfoReqVo) {
        GoodsRebateApplyInfoResVo goodsRebateApplyInfoResVo = new GoodsRebateApplyInfoResVo();
        DefaultTransactionDefinition defaultTransactionDefinition = new DefaultTransactionDefinition();
        defaultTransactionDefinition.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);
        defaultTransactionDefinition.setIsolationLevel(TransactionDefinition.ISOLATION_READ_COMMITTED);
        TransactionStatus transactionStatus = orderTransactionManager.getTransaction(defaultTransactionDefinition);
        try {
            goodsRebateMapper.saveGoodsRebateApplyInfo(buildGoodsRebateApplyInfo(goodsRebateApplyInfoReqVo));
            orderTransactionManager.commit(transactionStatus);
            goodsRebateApplyInfoResVo.setSuccess(true);
        } catch (Exception e) {
            orderTransactionManager.rollback(transactionStatus);
            logger.error("插入返利管理异常", e);
            goodsRebateApplyInfoResVo.setSuccess(false);
        }
        return goodsRebateApplyInfoResVo;  //To change body of implemented methods use File | Settings | File Templates.
    }
    @Override
    public GoodsRebateApplyInfoResVo updateGoodsRebateApply(GoodsRebateApplyInfoReqVo goodsRebateApplyInfoReqVo) {
        GoodsRebateApplyInfoResVo goodsRebateApplyInfoResVo = new GoodsRebateApplyInfoResVo();
        DefaultTransactionDefinition defaultTransactionDefinition = new DefaultTransactionDefinition();
        defaultTransactionDefinition.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);
        defaultTransactionDefinition.setIsolationLevel(TransactionDefinition.ISOLATION_READ_COMMITTED);
        TransactionStatus transactionStatus = orderTransactionManager.getTransaction(defaultTransactionDefinition);
        try {
            goodsRebateMapper.updateGoodsRebateApplyInfo(buildGoodsRebateApplyInfo(goodsRebateApplyInfoReqVo));
            orderTransactionManager.commit(transactionStatus);
            goodsRebateApplyInfoResVo.setSuccess(true);
        } catch (Exception e) {
            orderTransactionManager.rollback(transactionStatus);
            logger.error("更新返利管理异常", e);
            goodsRebateApplyInfoResVo.setSuccess(false);
        }
        return goodsRebateApplyInfoResVo;  //To change body of implemented methods use File | Settings | File Templates.
    }

    @Override
    public GoodsRebateApplyInfoResVo queryGoodsRebateApply(GoodsRebateApplyInfoReqVo goodsRebateApplyInfoReqVo) {
        GoodsRebateApplyInfoResVo goodsRebateApplyInfoResVo = new GoodsRebateApplyInfoResVo();
        //        调用刘冰的接口，库存的接口
        List<GoodsRebateApplyInfo> list = goodsRebateMapper.queryGoodsRebateApplyInfo(buildGoodsRebateApplyInfo(goodsRebateApplyInfoReqVo));
//      处理接口重复的字段
        goodsRebateApplyInfoResVo.setInfoarrys(list);

        return goodsRebateApplyInfoResVo;  //To change body of implemented methods use File | Settings | File Templates.
    }

    public GoodsRebateApplyInfo buildGoodsRebateApplyInfo(GoodsRebateApplyInfoReqVo goodsRebateApplyInfoReqVo) {
        GoodsRebateApplyInfo goodsRebateApplyInfo = new GoodsRebateApplyInfo();
        if (goodsRebateApplyInfoReqVo.getApplytime() != null && goodsRebateApplyInfoReqVo.getApplytime().length() != 0) {
            goodsRebateApplyInfo.setApplytime(FormatUtil.parseDate(goodsRebateApplyInfoReqVo.getApplytime(),Constants.DATE_FORMAT_1));
        }
        goodsRebateApplyInfo.setCartid(goodsRebateApplyInfoReqVo.getCartid());
        goodsRebateApplyInfo.setContact(goodsRebateApplyInfoReqVo.getContact());
        goodsRebateApplyInfo.setCustomerAddress(goodsRebateApplyInfoReqVo.getCustomerAddress());
        goodsRebateApplyInfo.setDeliveryStatus(goodsRebateApplyInfoReqVo.getDeliveryStatus());
        goodsRebateApplyInfo.setCustomerName(goodsRebateApplyInfoReqVo.getCustomerName());
        goodsRebateApplyInfo.setOrderNo(goodsRebateApplyInfoReqVo.getOrderNo());
        goodsRebateApplyInfo.setContact(goodsRebateApplyInfoReqVo.getContact());
        goodsRebateApplyInfo.setDeliveryNo(goodsRebateApplyInfoReqVo.getCustomerName());
        goodsRebateApplyInfo.setDeliveryStatus(goodsRebateApplyInfoReqVo.getDeliveryStatus());
        goodsRebateApplyInfo.setEndRow(goodsRebateApplyInfoReqVo.getEndRow());
        goodsRebateApplyInfo.setStartRow(goodsRebateApplyInfoReqVo.getStartRow());
        goodsRebateApplyInfo.setGoodsNum(goodsRebateApplyInfoReqVo.getGoodsNum());
        goodsRebateApplyInfo.setGoodsreBateNo(goodsRebateApplyInfoReqVo.getGoodsreBateNo());
        goodsRebateApplyInfo.setGoodsType(goodsRebateApplyInfoReqVo.getGoodsType());
        goodsRebateApplyInfo.setRebateAmount(goodsRebateApplyInfoReqVo.getRebateAmount());
        goodsRebateApplyInfo.setRebateStatus(goodsRebateApplyInfoReqVo.getRebateStatus());
        goodsRebateApplyInfo.setLoginId(goodsRebateApplyInfoReqVo.getLoginId());
        logger.info("操作返利管理,请求参数:" + GsonUtils.toJson(goodsRebateApplyInfo));
        return goodsRebateApplyInfo;
    }

}
