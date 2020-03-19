package com.kh.portfolio.member.svc;

import java.sql.Date;
import java.util.List;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.kh.portfolio.member.dao.MemberDAO;
import com.kh.portfolio.member.dao.MemberDAOImplXML;
import com.kh.portfolio.member.vo.MemberVO;

@Service
public class MemberSVCImpl implements MemberSVC {
	private static final Logger logger = 
			LoggerFactory.getLogger(MemberDAOImplXML.class);
	
	@Inject
	@Qualifier(value = "mXML")//클래스 이름 앞글자 소문자
	MemberDAO memberDAO;
	
	//회원 등록
	@Override
	public int joinMember(MemberVO memberVO) {
		logger.info("MemberSVCImpl.joinMember(MemberVO memberVO) 호출됨");
		return memberDAO.joinMember(memberVO);
	}
	//회원 수정
	@Override
	public int modifyMember(MemberVO memberVO) {
		logger.info("MemberSVCImpl.modifyMember(MemberVO memberVO) 호출됨");
		return memberDAO.modifyMember(memberVO);
	}
	//회원 전체 조회
	@Override
	public List<MemberVO> selectAllMember() {
		logger.info("MemberSVCImpl.selectAllMember() 호출됨");
		return memberDAO.selectAllMember();
	}
	//회원 개별 조회
	@Override
	public MemberVO selectMember(String id) {
		logger.info("MemberSVCImpl.selectMember(String id) 호출됨");
		return memberDAO.selectMember(id);
	}
	//회원 탈퇴
	@Override
	public int outMember(String id, String pw) {
		logger.info("MemberSVCImpl.outMember(String id, String pw) 호출됨");
		return memberDAO.outMember(id, pw);

	}
	//로그인
	@Override
	public MemberVO loginMember(String id, String pw) {
		logger.info("MemberSVCImpl.loginMember(String id, String pw) 호출됨");
		return memberDAO.loginMember(id, pw);
	}
	//아이디 찾기
	@Override
	public String findID(String tel, Date birth) {
		logger.info("MemberSVCImpl.findID(String tel, Date birth) 호출됨");
		return memberDAO.findID(tel, birth);
	}
	//비밀번호 
	
	//비밀번호 변경 대상 선택
	@Override
	public int findPW(MemberVO memberVO) {
		logger.info("MemberSVCImpl.findPW(MemberVO memberVO) 호출됨");
		return memberDAO.findPW(memberVO);
	}
	
	//비밀번호 변경
	@Override
	public int changPW(String id, String pw) {
		logger.info("MemberSVCImpl.changPW(String id, String pw) 호출됨");
		return memberDAO.changePW(id, pw);
	}
	
	
}















