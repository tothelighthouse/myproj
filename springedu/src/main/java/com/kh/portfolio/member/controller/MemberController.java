package com.kh.portfolio.member.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kh.portfolio.common.Code;
import com.kh.portfolio.member.dao.MemberDAOImplXML;
import com.kh.portfolio.member.svc.MemberSVC;
import com.kh.portfolio.member.vo.MemberVO;

@Controller
@RequestMapping("/member")
public class MemberController {
	private static final Logger logger = 
			LoggerFactory.getLogger(MemberDAOImplXML.class);

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
		region.add(new Code("충북","충북"));
		region.add(new Code("경남","경남"));
		region.add(new Code("경북","경북"));
		region.add(new Code("부산","부산"));

		model.addAttribute("region",region);

		//성별
		List<Code> gender = new ArrayList<>();
		gender.add(new Code("남","남자"));
		gender.add(new Code("여","여자"));

		model.addAttribute("gender", gender);
	}

	@ModelAttribute
	public void init(Model model) {
		//지역
		List<Code> region = new ArrayList<>();
		region.add(new Code("서울","서울"));
		region.add(new Code("경기","경기"));
		region.add(new Code("인천","인천"));
		region.add(new Code("대전","대전"));
		region.add(new Code("충북","충북"));
		region.add(new Code("충남","충남"));
		region.add(new Code("충북","충북"));
		region.add(new Code("경남","경남"));
		region.add(new Code("경북","경북"));
		region.add(new Code("부산","부산"));
		model.addAttribute("region",region);
	}

	@ModelAttribute("gender")
	public List<Code> init2() {
		//지역
		List<Code> gender = new ArrayList<>();
		gender.add(new Code("남","남자"));
		gender.add(new Code("여","여자"));
		return gender;
	}


	//회원 가입 양식
	@RequestMapping("/joinForm")
	public String memberJoinForm(Model model) {
		model.addAttribute("mvo",new MemberVO());
		return "member/joinForm";
	}

	//회원 등록
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
		if(memberSVC.selectMember(memberVO.getId())!=null) {
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
	//회원 수정 양식
	//	@PostMapping("/modifyForm/{id:.+}")
	@GetMapping("/modifyForm/{id:.+}")
	public String modifyForm(@PathVariable("id") String id, Model model) {
		MemberVO memberVO = memberSVC.selectMember(id);
		memberVO.setPw(null);
		model.addAttribute("mvo", memberVO);
		return "member/modifyForm";
	}
	//회원 수정
	@PostMapping("/modify")
	public String modify(
			@Valid @ModelAttribute("mvo") MemberVO memberVO,
			BindingResult result,
			Model model,
			HttpSession session
			) {
		logger.info("/modify 호출됨!!");
		//유효성 체크
		if(result.hasErrors()) {
			logger.info(result.toString());
			memberVO.setPw(null);
			return "member/modifyForm";
		}
		// 회원 정보 수정
		int cnt = memberSVC.modifyMember(memberVO);
		logger.info("수정 처리 결과 : " + cnt);

		//세션 정보 수정
		session.removeAttribute("member");
		session.setAttribute("member", memberVO);
		return "redirect:/member/modifyForm/" + memberVO.getId();
	}

	//회원 탈퇴 양식
	@GetMapping("/outForm")
	public String outForm() {

		return "member/outForm";
	}

	//회원 탈퇴
	@PostMapping("/out")
	public String out(
			@RequestParam("id") String id,
			@RequestParam("pw") String pw,
			HttpSession session,
			Model model) {
		int cnt = memberSVC.outMember(id, pw);
		if(cnt == 1) {
			session.invalidate();
			return "redirect:/";
		}else {
			model.addAttribute("svr_msg","비밀번호 오류!!");
			return "member/outForm";
		}
	}


	//	//아이디 찾기(get방식)
	//	@GetMapping(value = "/id/{tel}/{birth}", produces = "application/json")
	//	@ResponseBody
	//	public ResponseEntity<String> findId(
	//			@PathVariable("tel") String tel,
	//			@PathVariable("birth") String birth
	//			){
	//		ResponseEntity<String> res = null;
	//		String findId = null;
	//
	//		if(findId != null) {
	//			res = new ResponseEntity<String>(findId, HttpStatus.OK); // 200
	//		}else {
	//			res = new ResponseEntity<String>("찾고자하는 아이디가 없습니다.",HttpStatus.BAD_REQUEST); // 400
	//		}
	//		return res;
	//	}
	//	//비밀번호 변경 화면
	//	@GetMapping("/findPWForm")
	//	public String findPWForm() {
	//
	//		return "member/findPWForm";
	//	}
	//아이디 찾기 양식
	@GetMapping("/findIDForm")
	public String findIDForm() {
		return "member/findIDForm";
	}

	//아이디 찾기 post 방식
	@PostMapping(value = "/id", produces = "application/json")
	@ResponseBody
	public ResponseEntity<Map> findId(
			@RequestBody MemberVO memberVO
			){
		logger.info("tel :" + memberVO.getTel());
		logger.info("birth:" + memberVO.getBirth());

		ResponseEntity<Map> res = null;
		String findId = null;

		memberVO.setBirth(java.sql.Date.valueOf(memberVO.getBirth().toString()));
		findId = memberSVC.findID(memberVO.getTel(), memberVO.getBirth());
		Map<String, Object> map = new HashMap<String, Object>();
		if(findId != null) {
			map.put("sucess", true);
			map.put("id", findId);
			res = new ResponseEntity<Map>(map, HttpStatus.OK); // 200
		}else {
			map.put("sucess", false);
			map.put("id", findId);
			map.put("msg","찾고자 하는 아이디가 없습니다");
			res = new ResponseEntity<Map>(map, HttpStatus.OK); // 400
		}
		return res;
	}
	//비밀번호 변경 화면
	@GetMapping("/findPWForm")
	public String findPWForm() {

		return "member/findPWForm";
	}

	//비밀번호 변경 대상 찾기
	@PostMapping(value = "/findPW", produces = "application/json;charset=utf-8")
	@ResponseBody
	public ResponseEntity<Map> findPW(
			@RequestBody MemberVO memberVO
			) {
		ResponseEntity<Map> res = null;
		logger.info("비밀번호 변경 요청: " + memberVO.toString());


		memberVO.setBirth(java.sql.Date.valueOf(memberVO.getBirth().toString()));
		int cnt = memberSVC.findPW(memberVO);
		Map<String, Boolean> map = new HashMap<>();

		if(cnt == 1) {
			map.put("success",true);
			res = new ResponseEntity<Map>(map,HttpStatus.OK);
		}else {
			map.put("success", false);
			res = new ResponseEntity<Map>(map,HttpStatus.OK);
		}
		return res;
	}
	//비밀번호 변경
	//postman 실행시 오류가 나는 경우 header section 에 content-type을 application/json으로 다시 지정을 해줄것
	@PostMapping(value = "/changePW",produces = "application/json;charset=utf-8")
	@ResponseBody
	public ResponseEntity<Map> changePW(
			@RequestBody MemberVO memberVO
			){
		ResponseEntity<Map> res = null;
		int cnt = memberSVC.changPW(memberVO.getId(), memberVO.getPw());
		Map<String, Boolean> map = new HashMap<>();
		if(cnt == 1) {
			map.put("success",true);
			res = new ResponseEntity<Map>(map,HttpStatus.OK);
		}else {
			map.put("success",false);
			res = new ResponseEntity<Map>(map,HttpStatus.OK);
		}

		return res;
	}



}





























