package com.agency.business.export.vo;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

/**渠道商管理
 */
public class ChannelAgencyReqVo implements Serializable {
    private String channelloginId;
    private String agencyloginId;
    private String agencyAreaNo;
    private String province;
    private String city;
    private String district;
    private String taskstandards;
    private String taskstarttime;
    private String taskendtime;
    private String contactsigntime;
    private String contactendime;
    private String contacttype;
    private String agencyfees;
    private String agencystatus;
    private String abolishreason;
    private String iscontract;
    private String operator;
    private String extParam;
    private String remark;
    //   起始条数
    private int startRow;
    //   结束条数
    private int endRow;
    public String getChannelloginId() {
        return channelloginId;
    }

    public void setChannelloginId(String channelloginId) {
        this.channelloginId = channelloginId;
    }

    public String getAgencyloginId() {
        return agencyloginId;
    }

    public void setAgencyloginId(String agencyloginId) {
        this.agencyloginId = agencyloginId;
    }

    public String getAgencyAreaNo() {
        return agencyAreaNo;
    }

    public void setAgencyAreaNo(String agencyAreaNo) {
        this.agencyAreaNo = agencyAreaNo;
    }

    public String getProvince() {
        return province;
    }

    public void setProvince(String province) {
        this.province = province;
    }

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public String getDistrict() {
        return district;
    }

    public void setDistrict(String district) {
        this.district = district;
    }

    public String getTaskstandards() {
        return taskstandards;
    }

    public void setTaskstandards(String taskstandards) {
        this.taskstandards = taskstandards;
    }

    public String getTaskstarttime() {
        return taskstarttime;
    }

    public void setTaskstarttime(String taskstarttime) {
        this.taskstarttime = taskstarttime;
    }

    public String getTaskendtime() {
        return taskendtime;
    }

    public void setTaskendtime(String taskendtime) {
        this.taskendtime = taskendtime;
    }

    public String getContactsigntime() {
        return contactsigntime;
    }

    public void setContactsigntime(String contactsigntime) {
        this.contactsigntime = contactsigntime;
    }

    public String getContactendime() {
        return contactendime;
    }

    public void setContactendime(String contactendime) {
        this.contactendime = contactendime;
    }

    public String getContacttype() {
        return contacttype;
    }

    public void setContacttype(String contacttype) {
        this.contacttype = contacttype;
    }

    public String getAgencyfees() {
        return agencyfees;
    }

    public void setAgencyfees(String agencyfees) {
        this.agencyfees = agencyfees;
    }

    public String getAgencystatus() {
        return agencystatus;
    }

    public void setAgencystatus(String agencystatus) {
        this.agencystatus = agencystatus;
    }

    public String getAbolishreason() {
        return abolishreason;
    }

    public void setAbolishreason(String abolishreason) {
        this.abolishreason = abolishreason;
    }

    public String getIscontract() {
        return iscontract;
    }

    public void setIscontract(String iscontract) {
        this.iscontract = iscontract;
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
