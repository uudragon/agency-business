package com.agency.business.service;

import com.agency.business.export.vo.InitOrderApplyInfoReqVo;
import com.agency.business.export.vo.InitOrderApplyInfoResVo;

/**
 */
public interface OrderApplyService {

    public InitOrderApplyInfoResVo saveInitOrderApplyInfo(InitOrderApplyInfoReqVo userActiveApplyReqVo);

    public InitOrderApplyInfoResVo updateInitOrderApplyInfo(InitOrderApplyInfoReqVo userActiveApplyReqVo);

    public InitOrderApplyInfoResVo queryInitOrderApplyInfo(InitOrderApplyInfoReqVo userActiveApplyReqVo);

    public InitOrderApplyInfoResVo deleteInitOrderApplyInfo(InitOrderApplyInfoReqVo userActiveApplyReqVo);
}
