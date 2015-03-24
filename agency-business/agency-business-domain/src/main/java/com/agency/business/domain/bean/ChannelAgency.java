package com.agency.business.domain.bean;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

/**渠道商管理
 */
public class ChannelAgency implements Serializable {
    private String channelloginId;
    private String channelLoginName;
    private String agencyloginId;
    private String agencyAreaNo;
    private String province;
    private String city;
    private String district;
    private String address;
    private String agencyName;
    private String agencyPhone;
    private String taskstandards;
    private Date taskstarttime;
    private Date taskendtime;
    private Date contactsigntime;
    private Date contactendime;
    private String contacttype;
    private BigDecimal agencyfees;
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

    public Date getTaskstarttime() {
        return taskstarttime;
    }

    public void setTaskstarttime(Date taskstarttime) {
        this.taskstarttime = taskstarttime;
    }

    public Date getTaskendtime() {
        return taskendtime;
    }

    public void setTaskendtime(Date taskendtime) {
        this.taskendtime = taskendtime;
    }

    public Date getContactsigntime() {
        return contactsigntime;
    }

    public void setContactsigntime(Date contactsigntime) {
        this.contactsigntime = contactsigntime;
    }

    public Date getContactendime() {
        return contactendime;
    }

    public void setContactendime(Date contactendime) {
        this.contactendime = contactendime;
    }

    public String getContacttype() {
        return contacttype;
    }

    public void setContacttype(String contacttype) {
        this.contacttype = contacttype;
    }

    public BigDecimal getAgencyfees() {
        return agencyfees;
    }

    public void setAgencyfees(BigDecimal agencyfees) {
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

    public String getAgencyAreaNo() {
        return agencyAreaNo;
    }

    public void setAgencyAreaNo(String agencyAreaNo) {
        this.agencyAreaNo = agencyAreaNo;
    }

    public String getChannelLoginName() {
        return channelLoginName;
    }

    public void setChannelLoginName(String channelLoginName) {
        this.channelLoginName = channelLoginName;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getAgencyName() {
        return agencyName;
    }

    public void setAgencyName(String agencyName) {
        this.agencyName = agencyName;
    }

    public String getAgencyPhone() {
        return agencyPhone;
    }

    public void setAgencyPhone(String agencyPhone) {
        this.agencyPhone = agencyPhone;
    }
}
