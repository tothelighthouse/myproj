package com.kh.portfolio.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import lombok.Data;



@Controller
public class TestController2 {

	private static final Logger logger = LoggerFactory.getLogger(TestController2.class);

	//1) HttpServletRequest 이용 방법
	@RequestMapping(value= {"/test2/t1"}, method = {RequestMethod.POST, RequestMethod.GET})
	public String test(HttpServletRequest request) {
		String name = request.getParameter("name");
		String age = request.getParameter("age");
		logger.info("이름 : " + name);
		logger.info("나이 : " + age);
		return "test";
	}

	//2) RequestParam (각각 키 값에 객체)이용 / 요청 파라미터를 매개변수 선언시 자동 형변환
	@RequestMapping(value= {"/test2/t2"}, method = {RequestMethod.POST, RequestMethod.GET})
	public String test2(
			@RequestParam String name,
			@RequestParam int age) {
		logger.info("이름 : " + name);
		logger.info("나이 : " + age);
		return "test";
	}
	//2-1) RequestParam (각각 키값과 전달 받으려는 객체 이름이 다를시)이용 / 요청 파라미터를 매개변수 선언시 자동 형변환

	@RequestMapping(value= {"/test2/t4"}, method = {RequestMethod.POST, RequestMethod.GET})
	public String test4(
			@RequestParam("name") String rename,
			@RequestParam("age") int reage) {
		logger.info("이름 : " + rename);
		logger.info("나이 : " + reage);
		return "test";
	}
	//2-3) RequestParam (맵 객체)이용 / 요청 파라미터를 매개변수 선언시 자동 형변환
	@RequestMapping(value= {"/test2/t3"}, method = {RequestMethod.POST, RequestMethod.GET})
	public String test3(
			@RequestParam Map<String, Object> map) {
		logger.info("이름 : " + (String)(map.get("name")));
		logger.info("나이 : " + map.get("age"));
		return "test";
	}
	//3) VO 객체 이용
	@GetMapping("/test/t7")
	public String test7(
			@ModelAttribute("per") Person person,
			Model model) {
		logger.info(person.toString());
		Map<String, Object> map = model.asMap();
		for(String key : map.keySet()) {
			logger.info(key + ":" + map.get(key).toString());
		}
		return "test";
	}
	@GetMapping("/test/t5")
	public String test5(Person person) {
		logger.info(person.toString());
		return "test";
	}
	@GetMapping("/test/t6")
	public String test6(Person person, Model model) {
		logger.info(person.toString());
		Map<String, Object> map = model.asMap();
		for(String key : map.keySet()) {
			logger.info(key + ":" + map.get(key).toString());
		}
		return "test";
	}

	//입력 양식(test2); 이름, 나이
	@GetMapping("/test/t9")
	public String test9() {
		return "test4";
	}
	//입력 처리
	@PostMapping("/test/t10")
	public String test10(
			//			@ModelAttribute("per") Person person, 
			Person person, 
			//Person class를 이 파일 내에 정의 한 경우에 jsp 뷰 페이지에서 person 필드에 접근 불가함 
			//한 파일내에서 public class 는 하나만 선언 가능하기 때문에 별도의 클래스 파일 생성 필요
			Model model) {												
		logger.info(person.toString());					
		Map<String, Object> map = model.asMap();
		for(String key : map.keySet()) {
			logger.info(key + ":" + map.get(key).toString());
		}
		return "test";
	}
	@RequestMapping("/test/t11")
	public String test11(
			@Valid @ModelAttribute("per") Person person, 
			BindingResult result,
			//Person class를 이 파일 내에 정의 한 경우에 jsp 뷰 페이지에서 person 필드에 접근 불가함 
			//한 파일내에서 public class 는 하나만 선언 가능하기 때문에 별도의 클래스 파일 생성 필요
			Model model) {												
		logger.info(person.toString());					
		Map<String, Object> map = model.asMap();
		for(String key : map.keySet()) {
			logger.info(key + ":" + map.get(key).toString());
		}
		if(result.hasErrors()) {
			return "test4";
		}
		return "test2";
		
	}
	
	@GetMapping("/test/t12/{name}/{age}")
	public String t12(
			@PathVariable("name") String name,//매개변수 이름과 변수명 동일시 @PathVariable 생략 가능
			@PathVariable("age") String age,
			Model model
			) {
		model.addAttribute("name", name);
		model.addAttribute("age", age);
		logger.info("이름 : "+ name);
		logger.info("나이 : "+ age);
		return "test";
	}
	@GetMapping("/test/t13/{name}/{age}")
	public ModelAndView t13(
			@PathVariable("name") String name,//매개변수 이름과 변수명 동일시 @PathVariable 생략 가능
			@PathVariable("age") String age
			) {
		ModelAndView mav = new ModelAndView("test");
		mav.addObject("name", name);
		mav.addObject("age", age);
//		mav.setViewName("test");
		logger.info("이름 : "+ name);
		logger.info("나이 : "+ age);
		return mav;
	}
	@GetMapping("/test/t14")
	public String t14() {
		return "modifyForm";
	}
}






























