package com.kh.portfolio.board.dao;

import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import com.kh.portfolio.board.vo.BoardCategoryVO;
import com.kh.portfolio.board.vo.BoardFileVO;
import com.kh.portfolio.board.vo.BoardVO;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
@Repository
public class BoardDAOImplXML implements BoardDAO {
	
	private static final Logger logger = LoggerFactory.getLogger(BoardDAOImplXML.class);
	@Inject
	SqlSession sqlSession;

	//카테고리 읽어오기
	@Override
	public List<BoardCategoryVO> getCategory() {
		return sqlSession.selectList("mappers.BoardDAO-mapper.getCategory");
	}

	//게시글 작성
	@Override
	public int write(BoardVO boardVO) {
		return sqlSession.insert("mappers.BoardDAO-mapper.write", boardVO);
	}

	@Override
	public int fileWrite(BoardFileVO boardFileVO) {
		logger.info("파일 쓰기 !!!");
		return sqlSession.insert("mappers.BoardDAO-mapper.fileWrite",boardFileVO);
	}

	//게시글 수정
	@Override
	public int modify(BoardVO boardVO) {
		return sqlSession.update("mappers.BoardDAO-mapper.modify",boardVO);
	}

	//게시글 삭제
	@Override
	public int delete(String bnum) {
		return sqlSession.delete("mappers.BoardDAO-mapper.delete",Long.valueOf(bnum));
	}
	
	
	//첨부파일 1건 삭제
	@Override
	public int fileDelete(String fid) {
		return sqlSession.delete("mappers.BoardDAO-mapper.fileDelete",Long.valueOf(fid));
	}
	
	//게시글 첨부파일 전체 삭제
	@Override
	public int filesDelete(String bnum) {
		return sqlSession.delete("mappers.BoardDAO-mapper.filesDelete",Long.valueOf(bnum));
	}

	//게시글 보기
	@Override
	public BoardVO view(String bnum) {
		return sqlSession.selectOne("mappers.BoardDAO-mapper.view",Long.valueOf(bnum));
	}

	@Override
	public List<BoardFileVO> fileViews(String bnum) {
		return sqlSession.selectList("mappers.BoardDAO-mapper.fileViews",Long.valueOf(bnum));
	}
	//조회수 +1 증가
	@Override
	public int updateHit(String bnum) {
		return sqlSession.update("mappers.BoardDAO-mapper.updateHit",Long.valueOf(bnum));
	}

	//게시글 목록
	//1)전체
	@Override
	public List<BoardVO> list() {
		return sqlSession.selectList("mappers.BoardDAO-mapper.list1");
	}
	//2)검색어 없는 게시글 페이징
	@Override
	public List<BoardVO> list(int startRec, int endRec) {
		Map<String, Object> map = new HashMap<>();
		map.put("startRec",startRec);
		map.put("endRec",endRec);
		return sqlSession.selectList("mappers.BoardDAO-mapper.list2",map);
	}
//3)검색어 있는 게시글검색(전체,제목,내용,작성자ID,별칭)
	@Override
	public List<BoardVO> list(int startRec, int endRec, String searchType, String keyword) {
		Map<String,Object> map = new HashMap<>();
		map.put("startRec", startRec);
		map.put("endRec", endRec);
		map.put("searchType",searchType);
		if(keyword != null) {
			map.put("list",Arrays.asList(keyword.split("\\s+")));
		}
		return sqlSession.selectList("mappers.BoardDAO-mapper.list3", map);
	}
	
	//총 레코드수
	@Override
	public int totalRecordCount(String searchType, String keyword) {
		logger.info("keyword :" + keyword);
		Map<String,Object> map = new HashMap<>();
		map.put("searchType",searchType);
		
		if(keyword != null) {
			map.put("list",Arrays.asList(keyword.split("\\s+")));
		}
		logger.info("keyword2 :" + map.get("list"));
		return sqlSession.selectOne("mappers.BoardDAO-mapper.totalRecordCount",map);
	}
	
	//게시글 답글 작성
	@Override
	public int reply(BoardVO boardVO) {
		//1) 이전 답글 step 업데이트
		updateStep(boardVO.getBgroup(), boardVO.getBstep());
		//2) 답글 달기
		return sqlSession.insert("mappers.BoardDAO-mapper.reply", boardVO);
	}
	//이전 답글 step 업데이트
	private int updateStep(int bgroup, int bstep) {
		Map<String, Object> map = new HashMap<>();
		map.put("bgroup", bgroup);
		map.put("bstep", bstep);
		
		return sqlSession.update("mappers.BoardDAO-mapper.updateStep",map);
	}
	
	//첨부 파일 조회
	@Override
	public BoardFileVO fileView(String fid) {
		return sqlSession.selectOne("mappers.BoardDAO-mapper.fileView",Long.valueOf(fid));
	}
}


















