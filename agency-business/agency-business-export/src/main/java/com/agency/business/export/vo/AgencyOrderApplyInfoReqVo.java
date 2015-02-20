package com.agency.business.export.vo;

import java.io.Serializable;
import java.util.Date;

/**代理商订单
 */

public class AgencyOrderApplyInfoReqVo implements Serializable {
//     * 开始日
    private String beginTime;
//    结束日
    private String endTime;
//    申请人
    private String loginId;
    // 申请状态
    private String status;
    private String operator;
    private String extParam;
    private String remark;

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

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getLoginId() {
        return loginId;
    }

    public void setLoginId(String loginId) {
        this.loginId = loginId;
    }
}
