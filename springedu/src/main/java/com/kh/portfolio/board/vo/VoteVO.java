package com.kh.portfolio.board.vo;

import lombok.Data;

@Data
public class VoteVO {
	private long rnum;	//RNUM	댓글번호
	private long bnum;		//BNUM	게시글번호
	private String rid;		//RID	투표자(회원ID)
	private String vote;	//VOTE	댓글선호도 '1':호감 '2':비호감

}
