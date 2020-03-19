package com.kh.portfolio.board.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.xml.ws.Response;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.kh.portfolio.board.svc.RboardSVC;
import com.kh.portfolio.board.vo.RboardVO;
import com.kh.portfolio.board.vo.VoteVO;
import com.kh.portfolio.common.PageCriteria;
import com.kh.portfolio.common.RecordCriteria;

@RestController
@RequestMapping("/rboard")
public class RboardController {
	@Inject
	RboardSVC rboardSVC;

	private static final Logger logger = LoggerFactory.getLogger(RboardController.class);

	//댓글 작성
	@PostMapping(value = "",produces = "application/json")
	@ResponseBody
	public ResponseEntity<Map> write(
			@RequestBody(required = true)RboardVO rboardVO) {
		ResponseEntity<Map> res = null;
		Map<String, Object> map = new HashMap<>();

		//유효성 체크
		if(rboardVO.getBnum() > 0 				 	&&
				rboardVO.getRid() != null 			&&
				rboardVO.getRnickname() != null &&
				rboardVO.getRcontent() !=null) {
			logger.info("write() 호출됨");
			logger.info("rboardVO : " + rboardVO.toString());

			//댓글작성
			rboardSVC.write(rboardVO);
			//성공
			map.put("success", "success");
			map.put("rnum", rboardVO.getRnum());
			logger.info("rboardVO.getRnum 값 : " + String.valueOf(rboardVO.getRnum()));
			res = new ResponseEntity<Map>(map,HttpStatus.OK);
		}else {
			//실패
			map.put("success", "fail");
			map.put("rnum", rboardVO.getRnum());
			res = new ResponseEntity<Map>(map, HttpStatus.BAD_REQUEST);
		}

		return res;
	}
	//댓글 수정
	@PutMapping(value = "", produces = "application/json")
	@ResponseBody
	public ResponseEntity<String> modify(@RequestBody(required = true) RboardVO rboardVO) {
		ResponseEntity<String> res = null;
		//유효성 체크
		if(rboardVO.getRcontent() !=null &&
				rboardVO.getRnum() > 0) {
			rboardSVC.modify(rboardVO);
			res = new ResponseEntity<String>("success", HttpStatus.OK);
		}else {
			res = new ResponseEntity<String>("fail", HttpStatus.OK);
		}
		return res;

	}
//	@DeleteMapping(value = "",produces = "application/json")
//	@ResponseBody
//	public ResponseEntity<String> delete(@RequestBody(required = true) RboardVO rboardVO) {
	//@RequestBody 로 매개변수를 받는 방법 : 요청 body의 json을 받기 위해서는 매개변수가 RboardVO가 되어야 자동으로 필드 rnum에 바인딩되고(잭슨) 사용가능해짐 
//		ResponseEntity<String> res = null;
//		logger.info(String.valueOf(rboardVO.getRnum()));
//		if(rboardVO.getRnum() > 0.0) {
//			rboardSVC.delete(String.valueOf(rboardVO.getRnum()));
//			res = new ResponseEntity<String>("sucess", HttpStatus.OK);
//		}else {
//			res = new ResponseEntity<String>("fail", HttpStatus.BAD_REQUEST);
//		}
//		return res;
//	}
	@DeleteMapping(value = "/{rnum}",produces = "application/json")
	@ResponseBody
	//@PathVariable로 매개변수를 받는 방법 : String으로 직접 수신 가능
	public ResponseEntity<String> delete(@PathVariable(required = true) String rnum) {
		ResponseEntity<String> res = null;
		logger.info(rnum);
		if(rnum != null) {
			rboardSVC.delete(rnum);
			res = new ResponseEntity<String>("success", HttpStatus.OK);
		}else {
			res = new ResponseEntity<String>("fail", HttpStatus.BAD_REQUEST);
		}
		return res;
	}

	//대댓글 작성
	@PostMapping(value = "/reply",produces = "application/json")
	@ResponseBody
	public ResponseEntity<Map> reply(
			@RequestBody(required = true)RboardVO rboardVO) {
		logger.info("대댓글 작성 호출됨");
		ResponseEntity<Map> res = null;
		Map<String, Object> map = new HashMap<>();

		//유효성 체크
		if(
			rboardVO.getBnum() > 0 				 	&&
			rboardVO.getPrnum() > 0 &&
			rboardVO.getRid() != null &&
			rboardVO.getRnickname() !=null &&
			rboardVO.getRcontent() !=null) {

			//댓글작성
			logger.info(rboardVO.toString());
			//성공
			rboardSVC.reply(rboardVO);
			map.put("success", "success");
			map.put("rnum", rboardVO.getRnum());
			res = new ResponseEntity<Map>(map,HttpStatus.OK);
		}else {
			//실패
			map.put("success", "fail");
			map.put("rnum", rboardVO.getRnum());
			res = new ResponseEntity<Map>(map, HttpStatus.BAD_REQUEST);
		}

		return res;
	}
	
	//댓글 선호, 비선호
	@PutMapping(value = "/vote", produces = "application/json")
	@ResponseBody
	public ResponseEntity<String> vote(@RequestBody VoteVO voteVO){
		ResponseEntity<String> res = null;
		
		//유효성 체크
		if(voteVO.getRnum() > 0 && 			// 댓글번호
				voteVO.getBnum() > 0 &&			// 원글번호
				voteVO.getRid() != null &&	//투표자 아이디
				voteVO.getVote() != null 		// '1':선호, '2':비선호
				) {
			//댓글 선호, 비선호 변경
			rboardSVC.mergeVote(voteVO);

			//성공
			res = new ResponseEntity<String>("success", HttpStatus.OK);
		}else {
			//실패
			res = new ResponseEntity<String>("fail", HttpStatus.BAD_REQUEST);
		}
		return res;
	}
	
	//댓글 목록 조회
	@GetMapping(value="/{page}/{bnum}",produces = "application/json")
	public ResponseEntity<Map<String, Object>> list(
			@PathVariable String page,
			@PathVariable(required = true) String bnum
			){
		ResponseEntity<Map<String, Object>> res = null;
		Map<String, Object> map = new HashMap<String, Object>();
		logger.info("댓글 목록 호출됨!");
		try {
			//페이지 정보
			RecordCriteria rc = new RecordCriteria(Integer.valueOf(page));
			PageCriteria pc = new PageCriteria(rc, rboardSVC.replyTotalRec(bnum));

			//댓글 목록
			List<RboardVO> list = rboardSVC.list(Integer.valueOf(bnum), 
					rc.getStartRec(), 
					rc.getEndRec());
			map.put("pc", pc);
			map.put("list", list);
			res = new ResponseEntity<Map<String,Object>>(map, HttpStatus.OK);
		}catch(Exception e){
			res = new ResponseEntity<Map<String,Object>>(map, HttpStatus.BAD_REQUEST);
		}
		return res;
	}
}


























