package com.kh.portfolio.board.svc;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.kh.portfolio.admin.controller.AdminController;
import com.kh.portfolio.board.dao.BoardDAO;
import com.kh.portfolio.board.vo.BoardCategoryVO;
import com.kh.portfolio.board.vo.BoardFileVO;
import com.kh.portfolio.board.vo.BoardVO;
import com.kh.portfolio.common.FindCriteria;
import com.kh.portfolio.common.PageCriteria;
import com.kh.portfolio.common.RecordCriteria;
@Service
public class BoardSVCImpl implements BoardSVC {

	private static final Logger logger = LoggerFactory.getLogger(BoardSVCImpl.class);

	@Inject
	BoardDAO boardDAO;
	
	//카테고리 읽어오기
	@Override
	public List<BoardCategoryVO> getCategory() {
		return boardDAO.getCategory();
	}

	//게시글 작성
	@Transactional
	@Override
	public int write(BoardVO boardVO) {
		//1) 게시글 작성
		int cnt = boardDAO.write(boardVO);

		//2) bnum 가져오기 => mybatis: selectkey 사용

		//3) 첨부파일 있는 경우
		logger.info("첨부갯수:"+boardVO.getFiles().size());
		if(boardVO.getFiles()!=null && boardVO.getFiles().size()>0) {
			fileWrite(boardVO.getFiles(),boardVO.getBnum());
		}
		return cnt;
	}
	//첨부파일 저장
	private void fileWrite(List<MultipartFile> files, long bnum) {
		for(MultipartFile file : files) {
			try {
				logger.info("파일 첨부" + file.getOriginalFilename());

				BoardFileVO boardFileVO = new BoardFileVO();
				//게시글 번호
				boardFileVO.setBnum(bnum);
				//첨부 파일 이름
				boardFileVO.setFname(file.getOriginalFilename());
				boardFileVO.setFsize(file.getSize());
				boardFileVO.setFtype(file.getContentType());
				boardFileVO.setFdata(file.getBytes());
				if(file.getSize() > 0) {
					boardDAO.fileWrite(boardFileVO);
				}
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
	}

	//게시글 수정
	@Transactional
	@Override
	public int modify(BoardVO boardVO) {
		//1) 게시글 수정
		int cnt = boardDAO.modify(boardVO);

		//2) bnum 가져오기 => mybatis: selectkey 사용

		//3) 첨부파일 있는 경우
		if(boardVO.getFiles()!=null && boardVO.getFiles().size()>0) {
			fileWrite(boardVO.getFiles(),boardVO.getBnum());
		}
		return cnt;
	}

	//게시글 삭제
	@Transactional
	@Override
	public int delete(String bnum) {
		int cnt = 0;
		boardDAO.filesDelete(bnum);
		cnt = boardDAO.delete(bnum);
		return cnt;
	}
	
	//첨부파일 1건 삭제
	@Override
	public int fileDelete(String fid) {
		int cnt = boardDAO.fileDelete(fid);
		return cnt;
	}


	//게시글 보기
	@Override
	public Map<String, Object> view(String bnum) {
		//1)게시글 가져오기
		BoardVO boardVO = boardDAO.view(bnum);
		//2)첨부파일 가져오기
		List<BoardFileVO> files = boardDAO.fileViews(bnum);
		//3)조회수 +1증가
		boardDAO.updateHit(bnum);

		Map<String, Object> map = new HashMap<>();
		map.put("board", boardVO);
		if(files!=null && files.size() > 0) {
			map.put("files", files);
		}
		return map;
	}

	//게시글 목록
	//1)전체
	@Override
	public List<BoardVO> list() {
		// TODO Auto-generated method stub
		return boardDAO.list();
	}
	//2)검색어 없는 게시글 페이징
	@Override
	public List<BoardVO> list(int startRec, int endRec) {
		// TODO Auto-generated method stub
		return null;
	}
	//3)검색어 있는 게시글 페이징
	@Override
	public List<BoardVO> list(String reqPage, String searchType, String keyword) {
		int l_reqPage = 0;
		
		if(reqPage==null || reqPage.trim().isEmpty()) {
			l_reqPage = 1;
		}else {
			l_reqPage = Integer.parseInt(reqPage);
		}
		
		RecordCriteria recordCriteria = new RecordCriteria(l_reqPage);
		
		return boardDAO.list(
				recordCriteria.getStartRec(),
				recordCriteria.getEndRec(),
				searchType,
				keyword);
	}
	
	//페이지 제어
	@Override
	public PageCriteria getPageCriteria(String reqPage, String searchType, String keyword) {
		
		PageCriteria 		pc = null;					//한페이지에 보여줄 페이징 계산하는 클래스
		FindCriteria 		fc = null;					//PageCriteira + 검색타입, 검색어		
		
		int totalRec = 0;										//전체레코드 수
		
		int l_reqPage = 0;
		
		//요청 페이지 정보가 없으면 1로 초기화
		if(reqPage == null || reqPage.trim().isEmpty()) {
			l_reqPage =  1;
		}else {
			l_reqPage = Integer.parseInt(reqPage);
		}
			
		totalRec = boardDAO.totalRecordCount(searchType,keyword);
		
		fc = new FindCriteria(l_reqPage, searchType, keyword);
		pc = new PageCriteria(fc, totalRec);
		
		return pc;
	}

	//게시글 답글 작성
	
	@Transactional
	@Override
	public int reply(BoardVO boardVO) {
		//1) 게시글 작성
		int cnt = boardDAO.reply(boardVO);

		//2) bnum 가져오기 => mybatis: selectkey 사용

		//3) 첨부파일 있는 경우
		logger.info("첨부갯수:"+boardVO.getFiles().size());
		if(boardVO.getFiles()!=null && boardVO.getFiles().size()>0) {
			fileWrite(boardVO.getFiles(),boardVO.getBnum());
		}
		return cnt;
	}
	//첨부 파일 조회
	@Override
	public BoardFileVO fileView(String fid) {
		return boardDAO.fileView(fid);
	}

}

























