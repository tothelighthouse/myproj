package com.kh.portfolio.board.controller;

import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.portfolio.board.svc.BoardSVC;
import com.kh.portfolio.board.vo.BoardCategoryVO;
import com.kh.portfolio.board.vo.BoardVO;
import com.kh.portfolio.member.vo.MemberVO;

@Controller
public class mainController {
	public static final Logger logger = LoggerFactory.getLogger(mainController.class);

	@Inject
	BoardSVC boardSVC;

	// 게시글 작성 양식
	@RequestMapping("/")
	public String writeForm() {
		logger.info("메인컨트롤러 입니다");
		return "index";
	}
}











