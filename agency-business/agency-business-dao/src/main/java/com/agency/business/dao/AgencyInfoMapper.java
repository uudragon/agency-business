package com.agency.business.dao;


import com.agency.business.domain.bean.AgencyInfo;

import java.util.List;


/**代理商信息管理
 */
public interface AgencyInfoMapper {

    int saveAgencyInfo(AgencyInfo agencyInfo);

    int updateAgencyInfo(AgencyInfo agencyInfo);

    int deleteAgencyInfo(AgencyInfo agencyInfo);

    long countAgencyInfo(AgencyInfo agencyInfo);

    List<AgencyInfo> queryAgencyInfo(AgencyInfo agencyInfo);
}
