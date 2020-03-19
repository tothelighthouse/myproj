package com.kh.portfolio.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping(value="/test")
public class TestController {

	@RequestMapping(value = {"/1","/2","/3"},method = {RequestMethod.GET,RequestMethod.POST}) 
	public String t1() {

		return "test";
	}
	// 		상대경로
	//			return "redirect:./";
	//			return "redirect:../test"; 가능
	//			return "redirect:"; 불가능
	//		절대경로
	//			return "redirect:/test"; 가능
	//			return "redirect:http://localhost:9080/portfolio/test"; 가능

	@GetMapping("/abc1") // 값이 없으면 클래스의 매핑값을 사용
	public String temp1() {
		return "redirect:./";
	}
	@GetMapping("/abc2") // 값이 없으면 클래스의 매핑값을 사용
	public String temp2() {
		return "redirect:../test";
	}
	@GetMapping("/abc3") // 값이 없으면 클래스의 매핑값을 사용
	public String temp3() {
		return "redirect:.";
	}
	@GetMapping("/abc4") // 값이 없으면 클래스의 매핑값을 사용
	public String temp4() {

		return "redirect:/test";
	}
	
	@GetMapping("/abc5") // 값이 없으면 클래스의 매핑값을 사용
	public String temp5() {
		return "forward:";
	}

	
	
}










