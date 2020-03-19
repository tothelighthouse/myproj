package com.kh.portfolio.board.svc;

import java.util.List;
import java.util.Map;

import com.kh.portfolio.board.vo.BoardCategoryVO;
import com.kh.portfolio.board.vo.BoardFileVO;
import com.kh.portfolio.board.vo.BoardVO;
import com.kh.portfolio.common.PageCriteria;

public interface BoardSVC {

	//카테고리 읽어오기
	List<BoardCategoryVO> getCategory();
	//게시글 작성
	int write(BoardVO boardVO);
	//게시글 수정
	int modify(BoardVO boardVO);
	//게시글 삭제
	int delete(String bnum);

	//첨부파일 1건 삭제
	int fileDelete(String fid);
	//게시글 보기
	Map<String, Object> view(String bnum);
	//게시글 목록
	//1)전체
	List<BoardVO> list();
	//2)검색어 없는 게시글 페이징
	List<BoardVO> list(int startRec, int endRec);
	//3)검색어 있는 게시글 페이징(요청 페이지, 검색유형, 검색어)
	List<BoardVO> list( String reqPage, String searchType, String keyword);
	
	//페이지 제어
	PageCriteria getPageCriteria(String reqPage, String searchType,String keyword);

	//게시글 답글 작성
	int reply(BoardVO boardVO);
	//첨부파일 조회
	BoardFileVO fileView(String fid);
}
