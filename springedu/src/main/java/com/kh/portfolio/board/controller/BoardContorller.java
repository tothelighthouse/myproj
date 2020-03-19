package com.kh.portfolio.board.controller;

import java.io.UnsupportedEncodingException;
import java.lang.reflect.Member;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpRequest;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kh.portfolio.board.svc.BoardSVC;
import com.kh.portfolio.board.vo.BoardCategoryVO;
import com.kh.portfolio.board.vo.BoardFileVO;
import com.kh.portfolio.board.vo.BoardVO;
import com.kh.portfolio.member.vo.MemberVO;

@Controller
@RequestMapping("/board")
public class BoardContorller {
	public static final Logger logger = LoggerFactory.getLogger(BoardContorller.class);

	@Inject
	BoardSVC boardSVC;

	@ModelAttribute
	public void getBoardCategory(Model model) {
		List<BoardCategoryVO> boardCategoryVO = boardSVC.getCategory();
		model.addAttribute("boardCategoryVO", boardCategoryVO);
	}

	// 게시글 작성 양식
	@GetMapping("/writeForm/{returnPage}")
	public String writeForm(
			@PathVariable String returnPage,
			Model model, HttpServletRequest request) {
		MemberVO memberVO = (MemberVO) request.getSession().getAttribute("member");
		BoardVO boardVO = new BoardVO();
		boardVO.setBid(memberVO.getId());
		boardVO.setBnickname(memberVO.getNickname());
		model.addAttribute("boardVO", boardVO);
		model.addAttribute("returnPage", returnPage);
		return "/board/writeForm";
	}

	// 게시글 작성
	@PostMapping("/write/{returnPage}")
	public String write(
			@PathVariable String returnPage,
			@Valid @ModelAttribute("boardVO") BoardVO boardVO,
			BindingResult result,
			// HttpSession session,
			HttpServletRequest request) {
		logger.info(boardVO.toString());
		HttpSession session = request.getSession();
		MemberVO memberVO = (MemberVO) session.getAttribute("member");
		boardVO.setBid(memberVO.getId());
		boardVO.setBnickname(memberVO.getNickname());

		if (result.hasErrors()) {
			return "/board/writeForm";
		}

		int cnt = boardSVC.write(boardVO);
		if (cnt == 1) {
			return "redirect:/board/view/" + returnPage + "/" + boardVO.getBnum();
		} else {
			return "/board/writeForm";
		}
	}

	 //게시글 수정 양식
	@GetMapping("/modifyForm/{bnum}")
	public String modifyForm(@PathVariable String bnum, Model model) {
		Map<String, Object> map = boardSVC.view(bnum);
		BoardVO boardVO = (BoardVO) map.get("board");
		List<BoardFileVO> files = (List<BoardFileVO>) map.get("files");
		model.addAttribute("boardVO", boardVO);

		if (files != null && files.size() > 0)
			model.addAttribute("files", files);
		return "/board/modifyForm";
	}

	//게시글수정
	@PostMapping("/modify/{returnPage}")
	public String modify(
			@PathVariable String returnPage,
			@Valid @ModelAttribute("boardVO") BoardVO boardVO,
			BindingResult result
			) {
		if(result.hasErrors()) {
			return "/board/view";
		}
		logger.info("게시글 수정 내용:" + boardVO.toString());
		boardSVC.modify(boardVO);
		return "redirect:/board/view/"+ returnPage + "/" +boardVO.getBnum();
	}
	//목록보기
	@GetMapping({"/list",
				 "/list/{reqPage}",
				 "/list/{reqPage}/{searchType}/{keyword}"
	})
	public String listAll(
			@PathVariable(required = false) String reqPage,
			@PathVariable(required = false) String searchType,
			@PathVariable(required = false) String keyword,
			HttpSession session,
			Model model) {
		MemberVO memberVO = (MemberVO) session.getAttribute("member");
		// if(memberVO != null) {
		// logger.info("세션있음" + memberVO.toString());
		// }else {
		// logger.info("세션없음");
		// }
		model.addAttribute("list", boardSVC.list(reqPage,searchType,keyword));
		//페이지 제어
		model.addAttribute("pc", boardSVC.getPageCriteria(reqPage, searchType, keyword));	
		return "board/list";
	}

	// 게시글 보기
	@GetMapping("/view/{returnPage}/{bnum}")
	public String view(
			@PathVariable("bnum") String bnum,
			@ModelAttribute @PathVariable("returnPage") String returnPage,
			Model model) {

		Map<String, Object> map = boardSVC.view(bnum);
		BoardVO boardVO = (BoardVO) map.get("board");
		List<BoardFileVO> files = null;
		if (map.get("files") != null) {
			files = (List<BoardFileVO>) map.get("files");
		}

		model.addAttribute("boardVO", boardVO);
		model.addAttribute("files", files);
		//		model.addAttribute("returnPage", returnPage);  @ModelAttribute를 사용하면 생략가능
		return "/board/viewForm";
	}

	// 첨부파일 다운로드
	@GetMapping("/file/{fid}")
	public ResponseEntity<byte[]> getFile(@PathVariable String fid) {
		BoardFileVO boardFileVO = boardSVC.fileView(fid);
		logger.info("getFile" + boardFileVO.toString());

		final HttpHeaders headers = new HttpHeaders();
		String mtypes[] = boardFileVO.getFtype().split("/");
		headers.setContentType(new MediaType(mtypes[0], mtypes[1]));
		headers.setContentLength(boardFileVO.getFsize());

		String filename = null;
		try {
			filename = new String(boardFileVO.getFname().getBytes("euc-kr"), "ISO-8859-1");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		headers.setContentDispositionFormData("attachment", filename);
		return new ResponseEntity<byte[]>(boardFileVO.getFdata(), headers, HttpStatus.OK);
	}

	// 게시글 삭제
	@GetMapping("/delete/{returnPage}/{bnum}")
	public String delete(
			@PathVariable String returnPage,
			@PathVariable String bnum,
			Model model) {

		// 1) 게시글 및 첨부파일 삭제
		boardSVC.delete(bnum);
		// 2) 게시글 목록 가져오기
		List<BoardVO> list = boardSVC.list();
		model.addAttribute("list", list);
		return "redirect:/board/list/" + returnPage;
	}
	//파일 1개 삭제
	@DeleteMapping("/file/{fid}")
	@ResponseBody
	public ResponseEntity<Boolean> fileDelete(@PathVariable String fid) {
		int cnt = boardSVC.fileDelete(fid);
		if (cnt == 1) {
			return new ResponseEntity<Boolean>(true, HttpStatus.OK);
		} else {
			return new ResponseEntity<Boolean>(false, HttpStatus.FAILED_DEPENDENCY);
		}
	}

	// 답글 양식
	@GetMapping("/replyForm/{returnPage}/{bnum}")
	public String replyForm(
			@ModelAttribute @PathVariable String returnPage,
			@PathVariable("bnum") String bnum,
			Model model) {
		Map<String, Object> map = boardSVC.view(bnum);
		BoardVO boardVO = (BoardVO) map.get("board");
//		List<BoardFileVO> files = null;
//		if (map.get("files") != null) {
//			files = (List<BoardFileVO>) map.get("files");
//		}
		boardVO.setBtitle("[답글]" + boardVO.getBtitle());
		boardVO.setBcontent("[원글]" + boardVO.getBcontent());
		model.addAttribute("boardVO", boardVO);
		return "board/replyForm";
	}
	//답글 작성
	@PostMapping("/reply/{returnPage}")
	public String reply(
			@PathVariable String returnPage,
			@Valid @ModelAttribute("boardVO") BoardVO boardVO, 
			BindingResult result,
			HttpServletRequest request) {
		logger.info("답글 처리:" + boardVO.toString());
		if (result.hasErrors()) {
			return "board/replyForm";
		}

		MemberVO memberVO = (MemberVO) request.getSession().getAttribute("member");
		boardVO.setBid(memberVO.getId());
		boardVO.setBnickname(memberVO.getNickname());

		boardSVC.reply(boardVO);
		return "redirect:/board/list/" + returnPage;
	}

}
