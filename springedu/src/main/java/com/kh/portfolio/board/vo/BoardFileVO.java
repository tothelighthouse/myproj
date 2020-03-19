package com.kh.portfolio.board.vo;

import java.sql.Timestamp;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class BoardFileVO {

	private long fid;  //파일 아이디
	private long bnum; //게시글 번호
	private String fname; //파일명
	private long fsize; // 파일크기
	private String ftype; //파일 타입
	private byte[] fdata; //첨부 파일
	private Timestamp cdate; 
	private Timestamp udate; 
	
	
}
