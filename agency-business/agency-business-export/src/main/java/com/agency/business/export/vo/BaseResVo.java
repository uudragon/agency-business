package com.agency.business.export.vo;

import java.io.Serializable;

/**
 */
public class BaseResVo implements Serializable {
    /**
     * 返回码
     * 000000：成功
     */
    private String resultCode;

    /**
     * 返回状态码描述
     */
    private String resultMsg;

    /**是否成功
     */
    private boolean isSuccess = true;

    private int pageSize;
    private int pageNo;
    private long recordsCount;

    public String getResultCode() {
        return resultCode;
    }

    public void setResultCode(String resultCode) {
        this.resultCode = resultCode;
    }

    public String getResultMsg() {
        return resultMsg;
    }

    public void setResultMsg(String resultMsg) {
        this.resultMsg = resultMsg;
    }

    public boolean isSuccess() {
        return isSuccess;
    }

    public void setSuccess(boolean success) {
        isSuccess = success;
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

    public long getRecordsCount() {
        return recordsCount;
    }

    public void setRecordsCount(long recordsCount) {
        this.recordsCount = recordsCount;
    }
}
