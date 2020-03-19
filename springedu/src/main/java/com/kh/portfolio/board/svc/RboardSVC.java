package com.kh.portfolio.board.svc;

import java.util.List;

import com.kh.portfolio.board.vo.RboardVO;
import com.kh.portfolio.board.vo.VoteVO;

public interface RboardSVC {
	//댓글 등록
	int write(RboardVO rboardVO);
	
	//댓글 등록
	List<RboardVO> list(int bnum,int startRec, int endRec);
	
	//댓글 수정
	int modify(RboardVO rboardVO);
	
	//댓글 삭제
	int delete(String rnum);
	
	//대댓글 작성
	int reply(RboardVO rboardVO);
	
	//댓글 호감/비호감
	//투표여부 체크
	int checkVote(VoteVO voteVO);
	
	//투표이력 없으면 추가 있으면 변경
	int mergeVote(VoteVO voteVO);
	
	//댓글 총계
	int replyTotalRec(String bnum);

}
