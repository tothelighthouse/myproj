package com.kh.portfolio.board.vo;

import java.sql.Timestamp;
import java.util.List;

import javax.persistence.Entity;
import javax.validation.Valid;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Pattern;
import javax.validation.constraints.Size;

import org.springframework.web.multipart.MultipartFile;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.Data;

@Entity
@Data
public class BoardVO {
	private long bnum;				//BNUM NOT NULL NUMBER(10)    
//	private int bcategory;		//BCATEGORY NOT NULL NUMBER(3)
	@Valid
	private BoardCategoryVO boardCategoryVO;
	@NotNull
	@Size(min = 4, max = 50, message = "제목은 4~50자 까지 입력 가능합니다!")
	private String btitle;		//BTITLE NOT NULL VARCHAR2(150)
	private String bid;				//BID NOT NULL VARCHAR2(40)
//	@Size(min = 3, max = 10, message = "제목은 3~10자 까지 입력 가능합니다!")
	private String bnickname;	//	BNICKNAME NOT NULL VARCHAR2(30)  
	
	@JsonFormat(pattern = "yyyy-MM-dd")
	private Timestamp bcdate;	//	BCDATE    NOT NULL TIMESTAMP(6)  
	private Timestamp budate;	//	BUDATE TIMESTAMP(6)  
	private int bhit;					//	BHIT      NOT NULL NUMBER(5)
	
	@NotNull(message = "내용을 입력바랍니다!!")
	@Size(min = 4, message = "내용은 최소4자 이상 입력 바랍니다.!")
	private String bcontent;	//	BCONTENT  NOT NULL CLOB
	private int bgroup;				//	BGROUP    NOT NULL NUMBER(5)     
	private int bstep;				//	BSTEP     NOT NULL NUMBER(5)     
	private int bindent;			//	BINDENT   NOT NULL NUMBER(5)     
	
	//첨부파일
	private List<MultipartFile> files;

}






