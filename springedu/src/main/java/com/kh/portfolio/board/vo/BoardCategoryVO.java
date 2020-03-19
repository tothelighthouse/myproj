package com.kh.portfolio.board.vo;

import javax.persistence.Entity;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Pattern;
import javax.validation.constraints.Positive;

import lombok.Data;
@Entity
@Data
public class BoardCategoryVO {
	@Positive(message = "분류를 선택해 주세요")
	private long cid;//	CID   NOT NULL NUMBER(10)   
	private String cname;//	CNAME NOT NULL VARCHAR2(60) 

}
