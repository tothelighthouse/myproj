package com.kh.portfolio.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import com.kh.portfolio.member.vo.MemberVO;
public class LoginInterceptor implements HandlerInterceptor {
	
	private static final Logger logger = LoggerFactory.getLogger(LoginInterceptor.class);
	
	//컨트롤러 수행전
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		
		String uri = request.getRequestURI();
		String contextPath = request.getContextPath();
		String reqURI = uri.substring(contextPath.length());
		
		logger.info("요청uri : " + reqURI);
		
		MemberVO memberVO = (MemberVO)request.getSession().getAttribute("member");
		if(memberVO == null || memberVO.getId().equals("")) {
			logger.info("권한 없는 사용자가 접근 시도합니다");
			response.sendRedirect(request.getContextPath() + "/loginForm?reqURI=" + reqURI);
			return false;
		}
		
		return HandlerInterceptor.super.preHandle(request, response, handler);
	}
	//컨트롤러 수행후 뷰 생성전
	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		// TODO Auto-generated method stub
		HandlerInterceptor.super.postHandle(request, response, handler, modelAndView);
	}
	//뷰 생성후
	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex)
			throws Exception {
		// TODO Auto-generated method stub
		HandlerInterceptor.super.afterCompletion(request, response, handler, ex);
	}

		
}
