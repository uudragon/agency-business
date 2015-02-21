package com.agency.business.domain.bean;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

/**发票管理
 */
public class InitInvoiceApplyInfo implements Serializable {
    /**
     * 代理商编码
     */
    private String agentNo;
    //    申请编号
    private String applyNo;
    //    开始时间
    private Date beginTime;
    //    结束时间
    private Date  endTime;
    //    发票金额
    private BigDecimal amount;
    //    发票抬头
    private String invoicehead;
    //    申请人
    private String applyMan;
    //    申请日期
    private Date applydate;
    //    申请状态
    private String applystatus;
    private String operator;
    private String extParam;
    private String remark;
    //   起始条数
    private int startRow;
    //   结束条数
    private int endRow;

    public String getAgentNo() {
        return agentNo;
    }

    public void setAgentNo(String agentNo) {
        this.agentNo = agentNo;
    }

    public String getApplyNo() {
        return applyNo;
    }

    public void setApplyNo(String applyNo) {
        this.applyNo = applyNo;
    }

    public Date getBeginTime() {
        return beginTime;
    }

    public void setBeginTime(Date beginTime) {
        this.beginTime = beginTime;
    }

    public Date getEndTime() {
        return endTime;
    }

    public void setEndTime(Date endTime) {
        this.endTime = endTime;
    }

    public BigDecimal getAmount() {
        return amount;
    }

    public void setAmount(BigDecimal amount) {
        this.amount = amount;
    }

    public String getInvoicehead() {
        return invoicehead;
    }

    public void setInvoicehead(String invoicehead) {
        this.invoicehead = invoicehead;
    }

    public String getApplyMan() {
        return applyMan;
    }

    public void setApplyMan(String applyMan) {
        this.applyMan = applyMan;
    }

    public String getApplystatus() {
        return applystatus;
    }

    public void setApplystatus(String applystatus) {
        this.applystatus = applystatus;
    }

    public String getOperator() {
        return operator;
    }

    public void setOperator(String operator) {
        this.operator = operator;
    }

    public String getExtParam() {
        return extParam;
    }

    public void setExtParam(String extParam) {
        this.extParam = extParam;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

    public Date getApplydate() {
        return applydate;
    }

    public void setApplydate(Date applydate) {
        this.applydate = applydate;
    }

    public int getStartRow() {
        return startRow;
    }

    public void setStartRow(int startRow) {
        this.startRow = startRow;
    }

    public int getEndRow() {
        return endRow;
    }

    public void setEndRow(int endRow) {
        this.endRow = endRow;
    }
}
