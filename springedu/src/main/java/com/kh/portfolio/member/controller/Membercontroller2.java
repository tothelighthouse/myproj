package com.kh.portfolio.member.controller;

import java.util.ArrayList;
import java.util.List;

import javax.inject.Inject;
import javax.validation.Valid;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.portfolio.common.Code;
import com.kh.portfolio.member.svc.MemberSVC;
import com.kh.portfolio.member.vo.MemberVO;

@Controller
@RequestMapping("/memberTest")
public class Membercontroller2 {
	
	private static final Logger logger 
	= LoggerFactory.getLogger(MemberController.class);
	
	@Inject
	MemberSVC memberSVC;
	
	@ModelAttribute
	public void initData(Model model) {
		//지역
		List<Code> region = new ArrayList<>();
		region.add(new Code("서울","서울"));
		region.add(new Code("경기","경기"));
		region.add(new Code("인천","인천"));
		region.add(new Code("대전","대전"));
		region.add(new Code("충북","충북"));
		region.add(new Code("충남","충남"));
		region.add(new Code("경북","경북"));
		region.add(new Code("경남","경남"));
		region.add(new Code("울산","울산"));
		model.addAttribute("region", region);
		
		//성별
		List<Code> gender = new ArrayList<>();
		gender.add(new Code("남","남자"));
		gender.add(new Code("여","여자"));
		model.addAttribute("gender", gender);
	}
	
	//회원가입양식
	@RequestMapping("/joinForm")
	public String memberJoinForm(Model model) {
		model.addAttribute("mvo",new MemberVO());
		return "member/joinForm";
	}
	
	//회원등록
	@RequestMapping("/join")
	public String memberJoin(
			@Valid @ModelAttribute("mvo") MemberVO memberVO,
			BindingResult result,
			Model model) {
		logger.info(memberVO.toString());
		
		//1)유효성 오류체크 중 오류가 발견되면 회원 가입 페이지로 이동
		if(result.hasErrors()) {
			return "member/joinForm";
		}
		//2)회원 중복체크
		if(memberSVC.selectMember(memberVO.getId()) != null) {
			model.addAttribute("svr_msg", "중복된 아이디입니다!");
			return "member/joinForm";
		}
		
		//3)회원 가입처리
		int cnt = memberSVC.joinMember(memberVO);
		if(cnt == 1) {
			return "member/loginForm";
		}else {
			return "redirect:/";
		}
	}
	
//	@RequestMapping("/test")
//	public void test(@RequestParam("name") String name,
//									 @RequestParam("age") String age) {
//		logger.info("name :" + name);
//		logger.info("age :" + age);
//	}
}







