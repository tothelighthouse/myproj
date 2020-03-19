package com.kh.portfolio.member.vo;

import java.sql.Date;
import java.sql.Timestamp;

import javax.persistence.Entity;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Pattern;
import javax.validation.constraints.Size;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.Data;
@Entity
@Data
public class MemberVO {
	@NotNull
	@Pattern(regexp = "^\\w+@\\w+\\.\\w+(\\.\\w+)?$", message = "ex)aaa.@bbb.com" )
	private String id;
	@NotNull
	@Size(min = 6, max = 10, message = "비밀번호는 6~10자리로 입력바랍니다.")
	private String pw;
	@NotNull
	@Pattern(regexp = "^\\d{3}-\\d{3,4}-\\d{4}$", message = "ex)010-1234-5678")
	private String tel;
	@NotNull
	@Size(min = 3, max = 10, message = "닉네임은 3~10자리로 입력바랍니다.")
	private String nickname;
	private String gender;
	private String region;
	
//	@NotNull
//	@DateTimeFormat(pattern = "yyyy-MM-dd")
	@JsonFormat(pattern = "yyyy-MM-dd")
	private Date birth;
	private Timestamp cdate;
	private Timestamp udate;
}




















