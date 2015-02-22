package com.agency.business.export.vo;

import java.io.Serializable;

/**发票管理
 */
public class InitInvoiceApplyInfoReqVo implements Serializable {
    /**
     * 代理商编码
     */
    private String agentNo;
//    申请编号
    private String applyNo;
//    开始时间
    private String beginTime;
//    结束时间
    private String  endTime;
//    发票金额
    private String amount;
//    发票抬头
    private String invoicehead;
//    申请人
    private String applyMan;
//    申请日期
    private String applydate;
//    申请状态
    private String applystatus;
    private String operator;
    private String extParam;
    private String remark;
//    每页显示条数
    private int pageSize;
//    当前页数
    private int pageNo;

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

    public String getBeginTime() {
        return beginTime;
    }

    public void setBeginTime(String beginTime) {
        this.beginTime = beginTime;
    }

    public String getEndTime() {
        return endTime;
    }

    public void setEndTime(String endTime) {
        this.endTime = endTime;
    }

    public String getAmount() {
        return amount;
    }

    public void setAmount(String amount) {
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

    public String getApplydate() {
        return applydate;
    }

    public void setApplydate(String applydate) {
        this.applydate = applydate;
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

    public int getPageSize() {
        return pageSize;
    }

    public void setPageSize(int pageSize) {
        this.pageSize = pageSize;
    }

    public int getPageNo() {
        return pageNo;
    }

    public void setPageNo(int pageNo) {
        this.pageNo = pageNo;
    }
}
