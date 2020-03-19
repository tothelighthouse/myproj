package com.kh.portfolio.board.svc;

import java.util.List;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kh.portfolio.board.dao.RboardDAO;
import com.kh.portfolio.board.vo.RboardVO;
import com.kh.portfolio.board.vo.VoteVO;

@Service
public class RboardSVCImpl implements RboardSVC {
	private static final Logger logger = LoggerFactory.getLogger(RboardSVCImpl.class);
	@Inject
	RboardDAO rboardDAO;
	
	//댓글 등록
	@Override
	public int write(RboardVO rboardVO) {
		return rboardDAO.write(rboardVO);
	}
	//댓글 목록
	@Override
	public List<RboardVO> list(int bnum, int startRec, int endRec) {
		return rboardDAO.list(bnum,startRec,endRec);
	}
	//댓글 수정
	@Override
	public int modify(RboardVO rboardVO) {
		return rboardDAO.modify(rboardVO);
	}
	//댓글 삭제
	@Override
	public int delete(String rnum) {
		return rboardDAO.delete(rnum);
	}
	//대댓글 작성
	@Override
	public int reply(RboardVO rboardVO) {
		//1) 부모글 정보 읽어오기
		RboardVO parentRboardVO = rboardDAO.replyView(rboardVO.getPrnum());
		//2) 이전댓글 step 업데이트
		rboardDAO.updateStep(parentRboardVO.getRgroup(), parentRboardVO.getRstep());
		//3) 대댓글 작성
		rboardVO.setBnum(parentRboardVO.getBnum());
		rboardVO.setRgroup(parentRboardVO.getRgroup());
		rboardVO.setRstep(parentRboardVO.getRstep());
		rboardVO.setRindent(parentRboardVO.getRindent());
		//부모댓글아이디
		rboardVO.setPrid(parentRboardVO.getRid());
		//부모댓글별칭
		rboardVO.setPrnickname(parentRboardVO.getRnickname());
		return rboardDAO.reply(rboardVO);
	}
	//댓글 호감/비호감
	//투표여부 체크
	@Transactional
	@Override
	public int checkVote(VoteVO voteVO) {
		int cnt = 0;
		if(rboardDAO.checkVote(voteVO)==1) {
			//투표이력 있으면
			cnt = rboardDAO.updateVote(voteVO);
		}else {
			//투표이력 없으면
			cnt = rboardDAO.insertVote(voteVO);
		}
		return cnt;
	}
	//투표이력 없으면 추가 있으면 변경
	@Override
	public int mergeVote(VoteVO voteVO) {
		return rboardDAO.mergeVote(voteVO);
	}
	//댓글 총계
	@Override
	public int replyTotalRec(String bnum) {
		return rboardDAO.replyTotalRec(bnum);
	}

}
