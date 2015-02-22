//package com.agency.business.web.support;
//
//import com.jd.jr.cf.erp.common.exception.CfAppException;
//import com.jd.jr.cf.erp.common.exception.CfAppRuntimeException;
//import org.apache.commons.io.IOUtils;
//import org.springframework.web.servlet.ModelAndView;
//import org.springframework.web.servlet.handler.SimpleMappingExceptionResolver;
//
//import javax.servlet.http.HttpServletRequest;
//import javax.servlet.http.HttpServletResponse;
//import java.io.IOException;
//import java.io.PrintWriter;
//
///**
// * @author lichunguang
// * @Description
// * @createTime 14-11-27 下午6:40
// */
//public class CustomSimpleMappingExceptionResolver extends SimpleMappingExceptionResolver {
//    protected ModelAndView doResolveException(HttpServletRequest request,
//                                              HttpServletResponse response, Object handler, Exception ex) {
//        logger.error(request.getPathInfo()+",error:",ex);
//        Exception resultException = null;
//        CfAppException cfAppException = null;
//        CfAppRuntimeException cfAppRuntimeException = null;
//        if(ex instanceof CfAppRuntimeException){
//            cfAppRuntimeException = (CfAppRuntimeException) ex;
//            resultException = cfAppRuntimeException;
//        } else if(ex instanceof CfAppException){
//            cfAppException = (CfAppException) ex;
//            resultException = cfAppException;
//        } else {
//            cfAppException = new CfAppException(ex);
//            resultException = cfAppException;
//        }
//        //如果是ajax请求直接返回
//        if(request.getHeader("accept").indexOf("application/json") > -1 || (request
//                .getHeader("X-Requested-With")!= null && request
//                .getHeader("X-Requested-With").indexOf("XMLHttpRequest") > -1)) {
//            // JSON格式返回
//            PrintWriter writer = null;
//            try {
//                Integer statusCode = determineStatusCode(request, null);
//                if (statusCode != null) {
//                    applyStatusCodeIfPossible(request, response, statusCode);
//                }
//                response.setContentType("application/json; charset=UTF-8");
//                writer = response.getWriter();
//                String exceptionJson = "";
//                if(cfAppRuntimeException != null){
//                    exceptionJson = cfAppRuntimeException.toJsonStr();
//                } else {
//                    exceptionJson = cfAppException.toJsonStr();
//                }
//                writer.write(exceptionJson);
//                writer.flush();
//                //直接结束
//                return null;
//            } catch (IOException e) {
//                logger.info("CustomSimpleMappingExceptionResolver_cover_exception2JsonError:",e);
//                logger.info("CustomSimpleMappingExceptionResolver_cover_exception2JsonError_sourceException:",ex);
//            }finally {
//                if(writer != null){
//                    IOUtils.closeQuietly(writer);
//                }
//            }
//        }
//        // 如果不是异步请求,或者异步请求出错
//        // Expose ModelAndView for chosen error view.
//        String viewName = determineViewName(ex, request);
//        // Apply HTTP status code for error views, if specified.
//        // Only apply it if we're processing a top-level request.
//        Integer statusCode = determineStatusCode(request, viewName);
//        if (statusCode != null) {
//            applyStatusCodeIfPossible(request, response, statusCode);
//        }
//        return getModelAndView(viewName, resultException, request);
//    }
//}
