package com.agency.business.service.impl;


import com.agency.business.common.Constants;
import com.agency.business.common.InvoiceStatusConstants;
import com.agency.business.common.utils.FormatUtil;
import com.agency.business.dao.GoodsRebateMapper;
import com.agency.business.dao.InvoiceApplyMapper;
import com.agency.business.domain.bean.InitInvoiceApplyInfo;
import com.agency.business.export.vo.GoodsRebateApplyInfoReqVo;
import com.agency.business.export.vo.GoodsRebateApplyInfoResVo;
import com.agency.business.export.vo.InitInvoiceApplyInfoReqVo;
import com.agency.business.export.vo.InitInvoiceApplyInfoResVo;
import com.agency.business.service.GoodsRebateApplyService;
import com.agency.business.service.InvoiceApplyService;
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

/**返利管理1
 */
@Service("goodsRebateApplyService")
public class GoodsRebateApplyServiceImpl implements GoodsRebateApplyService {
    private static final Logger logger = LoggerFactory.getLogger(GoodsRebateApplyServiceImpl.class);
    @Autowired
    private GoodsRebateMapper goodsRebateMapper;
    @Autowired
    @Qualifier("goodsRebateTransactionManager")
    private PlatformTransactionManager goodsRebateTransactionManager;

    @Override
    public GoodsRebateApplyInfoResVo saveGoodsRebateApply(GoodsRebateApplyInfoReqVo goodsRebateApplyInfoReqVo) {
        return null;  //To change body of implemented methods use File | Settings | File Templates.
    }
    @Override
    public GoodsRebateApplyInfoResVo updateGoodsRebateApply(GoodsRebateApplyInfoReqVo goodsRebateApplyInfoReqVo) {
        return null;  //To change body of implemented methods use File | Settings | File Templates.
    }
    @Override
    public GoodsRebateApplyInfoResVo queryGoodsRebateApply(GoodsRebateApplyInfoReqVo goodsRebateApplyInfoReqVo) {
        return null;  //To change body of implemented methods use File | Settings | File Templates.
    }
}
