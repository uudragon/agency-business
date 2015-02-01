package com.agency.business.web;

import com.agency.business.export.OrderApplyResource;
import com.agency.business.export.vo.InitOrderApplyInfoReqVo;
import com.agency.business.export.vo.InitOrderApplyInfoResVo;
import com.agency.business.service.OrderApplyService;
import com.jd.payment.paycommon.utils.GsonUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * User: jiangzuohui
 * Date: 15-2-1
 * Time: 上午10:41
 * To change this template use File | Settings | File Templates.
 */
@Controller
public class OrderApplyResourceImpl implements OrderApplyResource {

    private static final Logger logger = LoggerFactory.getLogger(OrderApplyResourceImpl.class);

    @Autowired
    private OrderApplyService orderApplyService;

    @Override
    public InitOrderApplyInfoResVo saveInitOrderApplyInfo(InitOrderApplyInfoReqVo userActiveApplyReqVo) {
        InitOrderApplyInfoResVo initOrderApplyInfoResVo = new InitOrderApplyInfoResVo();
        try{
            initOrderApplyInfoResVo = orderApplyService.saveInitOrderApplyInfo(userActiveApplyReqVo);
        }catch (Exception e){
            logger.error("订购首期产品异常,请求参数:" + GsonUtils.toJson(userActiveApplyReqVo),e);
            initOrderApplyInfoResVo.setSuccess(false);
        }
        return initOrderApplyInfoResVo;
    }

    @Override
    public InitOrderApplyInfoResVo updateInitOrderApplyInfo(InitOrderApplyInfoReqVo userActiveApplyReqVo) {
        InitOrderApplyInfoResVo initOrderApplyInfoResVo = new InitOrderApplyInfoResVo();
        try{
            initOrderApplyInfoResVo = orderApplyService.updateInitOrderApplyInfo(userActiveApplyReqVo);
        }catch (Exception e){
            logger.error("订购首期产品异常,请求参数:" + GsonUtils.toJson(userActiveApplyReqVo),e);
            initOrderApplyInfoResVo.setSuccess(false);
        }
        return initOrderApplyInfoResVo;
    }

    @Override
    public InitOrderApplyInfoResVo queryInitOrderApplyInfo(InitOrderApplyInfoReqVo userActiveApplyReqVo) {
        return orderApplyService.queryInitOrderApplyInfo(userActiveApplyReqVo);
    }

    public InitOrderApplyInfoResVo deleteInitOrderApplyInfo(InitOrderApplyInfoReqVo userActiveApplyReqVo){
        return orderApplyService.deleteInitOrderApplyInfo(userActiveApplyReqVo);
    }
}
