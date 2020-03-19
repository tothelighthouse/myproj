package com.kh.portfolio.admin.controller;
//import net.sf.json.JSONArray;
import java.util.List;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kh.portfolio.member.svc.MemberSVC;
import com.kh.portfolio.member.vo.MemberVO;

@Controller
@RequestMapping("/admin")
public class AdminController {

	private static final Logger logger = LoggerFactory.getLogger(AdminController.class);
	@Inject
	MemberSVC memberSVC;

	//	@GetMapping(value = "/memberList", produces = "applicaton/json")
	@GetMapping("/memberList")
	//	@ResponseBody
	public String memberList(
			@ModelAttribute("memberList") List<MemberVO> memberList,
			Model model) {
		memberList = memberSVC.selectAllMember();
		model.addAttribute("memberList", memberList);
		//		JSONArray mapResult = JSONArray.fromObject(memberList);

		logger.info(memberList.toString());
		return "admin/memberList";
	}

}

































