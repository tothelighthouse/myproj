package com.kh.portfolio.board.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.mybatis.spring.SqlSessionTemplate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import com.kh.portfolio.board.vo.RboardVO;
import com.kh.portfolio.board.vo.VoteVO;

@Repository
public class RboardDAOImplXML implements RboardDAO {
	private static final Logger logger = LoggerFactory.getLogger(RboardDAOImplXML.class);
	
	@Inject
	SqlSessionTemplate sqlSession;
	
	//댓글 등록
	@Override
	public int write(RboardVO rboardVO) {
		int cnt =
		sqlSession.insert("mappers.RboardDAO-mapper.write",rboardVO);
		logger.info("dao rboardVO.getRnum()"+rboardVO.getRnum());
		return cnt;
		//return sqlSession.insert("mappers.RboardDAO-mapper.write",rboardVO);
	}
	
	//댓글 목록
	@Override
	public List<RboardVO> list(int bnum, int startRec, int endRec) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("bnum", bnum);
		map.put("startRec", startRec);
		map.put("endRec", endRec);
		return sqlSession.selectList("mappers.RboardDAO-mapper.list",map);
	}
	
	//댓글 수정
	@Override
	public int modify(RboardVO rboardVO) {
		return sqlSession.update("mappers.RboardDAO-mapper.modify",rboardVO);
	}
	
	//댓글 삭제
	@Override
	public int delete(String rnum) {
		return sqlSession.delete("mappers.RboardDAO-mapper.delete",Long.parseLong(rnum));
	}
	
	//대댓글 작성
	@Override
	public int reply(RboardVO rboardVO) {
		//1) 이전 댓글 step 업데이트
		updateStep(rboardVO.getRgroup(),rboardVO.getRstep());
		
		//2) 대댓글 작성
		return sqlSession.insert("mappers.RboardDAO-mapper.reply",rboardVO);
	}
	
	//이전댓글 step 업데이트
	@Override
	public int updateStep(int rgroup, int rstep) {
		Map<String,Object> map = new HashMap<>();
		map.put("rgroup", rgroup);
		map.put("rstep", rstep);
		return sqlSession.update("mappers.RboardDAO-mapper.updateStep", map);
	}
	
	//댓글정보 읽어오기
	@Override
	public RboardVO replyView(long rnum) {
		return sqlSession.selectOne("mappers.RboardDAO-mapper.replyView", rnum);
	}	

	//댓글 호감/비호감
	//투표여부 체크
	@Override
	public int checkVote(VoteVO voteVO) {
		return sqlSession.selectOne("mappers.RboardDAO-mapper.checkVote",voteVO);
	}
	//투표이력 없으면 추가
	@Override
	public int insertVote(VoteVO voteVO) {
		return sqlSession.insert("mappers.RboardDAO-mapper.insertVote",voteVO);

	}
	//투표이력 있으면 변경
	@Override
	public int updateVote(VoteVO voteVO) {
		return sqlSession.update("mappers.RboardDAO-mapper.updateVote",voteVO);
	}
	//투표이력 없으면 추가 있으면 변경
	@Override
	public int mergeVote(VoteVO voteVO) {
		return sqlSession.update("mappers.RboardDAO-mapper.mergeVote",voteVO);
	}
	
	//댓글 총계
	@Override
	public int replyTotalRec(String bnum) {
		return sqlSession.selectOne("mappers.RboardDAO-mapper.replyTotalRec",Long.valueOf(bnum));
	}


}

















