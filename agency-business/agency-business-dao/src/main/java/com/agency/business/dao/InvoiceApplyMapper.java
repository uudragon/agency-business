package com.agency.business.dao;

import com.agency.business.domain.bean.InitInvoiceApplyInfo;

import java.util.List;

/**
 */
public interface InvoiceApplyMapper {
    /**
     *发票管理
     * @param InitInvoiceApplyInfo
     * @return
     */
    int saveInvoiceApplyInfo(InitInvoiceApplyInfo InitInvoiceApplyInfo);

    int updateInitInvoiceApplyInfo(InitInvoiceApplyInfo InitInvoiceApplyInfo);

    int deleteInitInvoiceApplyInfo(InitInvoiceApplyInfo InitInvoiceApplyInfo);

    long countInitInvoiceApplyInfo(InitInvoiceApplyInfo initInvoiceApplyInfo);

    List<InitInvoiceApplyInfo> queryInitInvoiceApplyInfo(InitInvoiceApplyInfo initInvoiceApplyInfo);

}
