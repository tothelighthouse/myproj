package com.kh.portfolio.member.dao;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;

import java.util.List;

import javax.inject.Inject;

import org.junit.jupiter.api.Disabled;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit.jupiter.SpringExtension;

import com.kh.portfolio.member.vo.MemberVO;

@ExtendWith(SpringExtension.class)
@ContextConfiguration(locations = {"file:src/main/webapp/WEB-INF/spring/root-context.xml"})
public class MemberDAOImplXMLTest {
	private static Logger logger
	= LoggerFactory.getLogger(MemberDAOImplJDBC.class);

	@Inject
	@Qualifier("memberDAOImplXML")
	MemberDAO memberDAO;
	
	
	@Test
	@DisplayName("회원등록")
	@Disabled
	void joinMember() {
		MemberVO memberVO = new MemberVO();
		//		sql.append("insert into member (id,pw,tel,nickname,gender,region,birth, cdate) ");
		//		sql.append("values(?,?,?,?,?,?,?,systimestamp)");

		memberVO.setId("test111@naver.com");
		memberVO.setPw("admin1234");
		memberVO.setTel("010-1234-5678");
		memberVO.setNickname("홍길동");
		memberVO.setGender("남");
		memberVO.setRegion("부산");
		memberVO.setBirth(new java.sql.Date(2000,01,01));
		int cnt = memberDAO.joinMember(memberVO);
		assertEquals(1, cnt);
	}
	@Test
	@Disabled
	void modifyMember() {
		MemberVO memberVO = new MemberVO();
		memberVO.setId("test4@google.com");
		memberVO.setTel("010-1234-5678");
		memberVO.setNickname("홍길동자");
		memberVO.setGender("남");
		memberVO.setRegion("부산");
		memberVO.setBirth(new java.sql.Date(2000,01,01));
		int cnt = memberDAO.modifyMember(memberVO);
		assertEquals(1, cnt);
	}
	@Test
	@Disabled
	void selectAllMember() {
		List<MemberVO> list = memberDAO.selectAllMember();
		assertNotNull(list);
		for(MemberVO memberVO : list) {
			logger.info(memberVO.toString());
		}
	}
	@Test
	@DisplayName("회원 개별 조회")
	@Disabled
	void selectMember() {
		MemberVO memberVO = memberDAO.selectMember("test4@google.com");
		assertNotNull(memberVO);
		assertEquals("test4@google.com", memberVO.getId());
		logger.info(memberVO.toString());
	}
	
	@Test
	@DisplayName("회원 탈퇴")
	@Disabled
	void outMember() {
		int cnt = memberDAO.outMember("test4@google.com", "abcd1234");
		assertEquals(1, cnt);
	}
	
	@Test
	@DisplayName("아이디 찾기")
//	@Disabled
	void findId() {
		//고질적인 오류 원인 : 단순 날짜 변환 오류.아래 메소드 사용할것
		String id = memberDAO.findID("010-1234-5678", java.sql.Date.valueOf("2020-01-15"));
		assertEquals("test3@google.com", id);
		assertNotNull(id);
	}
	
	@Test
	@DisplayName("비밀번호 변경 대상 찾기")
	void findPW() {
		MemberVO memberVO = new MemberVO();
		memberVO.setId("test3@google.com");
		memberVO.setTel("010-1234-5678");
		memberVO.setBirth(java.sql.Date.valueOf("2020-01-15"));
		int cnt = memberDAO.findPW(memberVO);
		assertEquals(1, cnt);
	}
	
	
}






















