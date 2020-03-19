package com.kh.portfolio.member.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.ArrayList;
import java.sql.Date;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.ResultSetExtractor;
import org.springframework.stereotype.Repository;

import com.kh.portfolio.member.vo.MemberVO;
@Repository
public class MemberDAOImplJDBC implements MemberDAO {

	private static final Logger logger = LoggerFactory.getLogger(MemberDAOImplJDBC.class);

	@Inject
	JdbcTemplate jdbcTemplate; 


	//회원 가입
	@Override
	public int joinMember(MemberVO memberVO) {
		//		logger.info("MemberDAOImpl.insertMember(MemberVO memberVO) ȣ���!");
		//		logger.info(memberVO.toString());
		int cnt = 0;

		//sql 생성
		StringBuffer sql = new StringBuffer();
		sql.append("insert into member (id,pw,tel,nickname,gender,region,birth, cdate) ");
		sql.append("values(?,?,?,?,?,?,?,systimestamp)");
		//sql 실행
		cnt = jdbcTemplate.update(
				sql.toString(),memberVO.getId(),memberVO.getPw(),memberVO.getTel(),
				memberVO.getNickname(), memberVO.getGender(),memberVO.getRegion(),
				memberVO.getBirth());
		return cnt;
	}

	//회원 수정
	@Override
	public int modifyMember(MemberVO memberVO) {
		Integer cnt = 0;

		//sql 작성
		StringBuffer sql = new StringBuffer();
		sql.append("update member  ");
		sql.append(" 	set tel = ?, ");
		sql.append(" 			nickname = ?, ");
		sql.append(" 			gender = ?, ");
		sql.append(" 			region = ?, ");
		sql.append(" 			birth = ?, ");
		sql.append(" 			udate = systimestamp ");
		sql.append(" where id = ?");		


		//sql 실행 
		cnt = jdbcTemplate.update(
				sql.toString(), 
				(PreparedStatement ps)-> {
					ps.setString(1, memberVO.getTel());
					ps.setString(2, memberVO.getNickname());
					ps.setString(3, memberVO.getGender());
					ps.setString(4, memberVO.getRegion());
					ps.setDate(5, new java.sql.Date(memberVO.getBirth().getTime()));
					ps.setString(6, memberVO.getId());
				});
		logger.info(cnt.toString());
		return cnt;
	}

	//전체 회원 조회
	@Override
	public List<MemberVO> selectAllMember() {
		//sql 생성
		StringBuffer sql = new StringBuffer();
		sql.append("SELECT id,  		pw,  		tel,  	nickname,  gender, ");
		sql.append("       region,  birth,  cdate,  udate ");
		sql.append("  FROM member ");

		//sql 실행
		List<MemberVO> list = jdbcTemplate.query(
				(Connection con) -> {
					PreparedStatement pstmt = con.prepareStatement(sql.toString());
					return pstmt;
				}
				, (ResultSet rs) ->{
					List<MemberVO> result = new ArrayList<>();
					MemberVO memberVO = new MemberVO();
					while(rs.next()) {
						memberVO.setId(rs.getString("id"));
						memberVO.setTel(rs.getString("tel"));
						memberVO.setNickname(rs.getString("nickname"));
						memberVO.setGender(rs.getString("gender"));
						memberVO.setRegion(rs.getString("region"));
						memberVO.setBirth(rs.getDate("birth"));
						result.add(memberVO);
					}
					return result;
				});
		return list;
	}

	//회원 개별 조회
	@Override
	public MemberVO selectMember(String id) {
		//sql 생성
		StringBuffer sql = new StringBuffer();
		sql.append("select id,tel,nickname,gender,region,birth ");
		sql.append("  from member ");
		sql.append(" where id = ? ");
		//sql 실행
		MemberVO memberVO = jdbcTemplate.query(
				sql.toString(), 
				new Object[] {"test4@google.com"}, 
				new int[] {Types.VARCHAR}, 
				new ResultSetExtractor<MemberVO>() {
					@Override
					public MemberVO extractData(ResultSet rs) throws SQLException, DataAccessException {
						MemberVO memberVO = new MemberVO();
						if(rs.next()) {
							memberVO.setId(rs.getString("id"));
							memberVO.setTel(rs.getString("tel"));
							memberVO.setNickname(rs.getString("nickname"));
							memberVO.setRegion(rs.getString("region"));
							memberVO.setGender(rs.getString("gender"));
							memberVO.setBirth(rs.getDate("birth"));
						}

						return memberVO;
					}
				});
		//				new RowMapper<MemberVO>() {
		//					@Override
		//					public MemberVO mapRow(ResultSet rs, int rowNum) throws SQLException {
		//						MemberVO memberVO = new MemberVO();
		//						if(rs.next()) {
		//							memberVO.setId(rs.getString("id"));
		//							memberVO.setTel(rs.getString("tel"));
		//							memberVO.setNickname(rs.getString("nickname"));
		//							memberVO.setRegion(rs.getString("region"));
		//							memberVO.setGender(rs.getString("gender"));
		//							memberVO.setBirth(rs.getDate("birth"));
		//						}
		//						
		//						return memberVO;
		//					}
		//				});
		return memberVO;
	}

	//회원 탈퇴
	@Override
	public int outMember(String id, String pw) {
		int cnt = 0;

		StringBuffer sql = new StringBuffer();
		sql.append("delete from member where id = ? and pw = ?");
		cnt = jdbcTemplate.update(sql.toString(),id,pw);
		return cnt;
	}

	//회원 로그인
	@Override
	public MemberVO loginMember(String id, String pw) {
		// TODO Auto-generated method stub
		return null;
	}

	//아이디 찾기
	@Override
	public String findID(String tel, Date birth) {
		logger.info("findID(String tel, Date birth)호출됨");
		String id = null;
		StringBuffer sql = new StringBuffer();
		sql.append("select id from member where tel = ? and birth = ?");

		Map<String,Object> map = jdbcTemplate.queryForMap(sql.toString(), tel,birth);
		logger.info(map.get("id").toString());
		return map.get("id").toString();
	}
	
	//비밀번호 변경 대상 찾기
	@Override
	public int findPW(MemberVO memberVO) {
		logger.info("MemberDAOImplJDBC.findPW(MemberVO memberVO) 호출됨");
		int cnt = 0;
		StringBuffer sql = new StringBuffer();
		sql.append("select count(id) from member ");
		sql.append(" where id = ? and tel = ? and birth = ?");
		
		cnt = jdbcTemplate.queryForObject(sql.toString(), Integer.class,memberVO.getId(),memberVO.getTel(),memberVO.getBirth());
		
		return cnt;
	}
	
	//비밀번호 찾기
	@Override
	public int changePW(String id, String pw) {
		return 0;
	}

}

















