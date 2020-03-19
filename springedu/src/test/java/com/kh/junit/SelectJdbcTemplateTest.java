package com.kh.junit;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.inject.Inject;

import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Disabled;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.PreparedStatementCreator;
import org.springframework.jdbc.core.PreparedStatementSetter;
import org.springframework.jdbc.core.ResultSetExtractor;
import org.springframework.jdbc.core.RowCallbackHandler;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.jdbc.support.rowset.SqlRowSet;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit.jupiter.SpringExtension;
import org.springframework.util.StringUtils;

import com.kh.portfolio.member.dao.MemberDAOImplJDBCTest;

@ExtendWith(SpringExtension.class)
@ContextConfiguration(locations={"file:src/main/webapp/WEB-INF/spring/root-context.xml"})

public class SelectJdbcTemplateTest {
	private static final Logger logger 
	= LoggerFactory.getLogger(InsertJdbcTemplateTest.class);

	static RowMapper<StudentVO> rowMapper = null;
	StringBuffer sql = null;

	@BeforeAll
	static void beforeAll() {
		rowMapper =  new RowMapper<StudentVO>() {
			@Override
			public StudentVO mapRow(ResultSet rs, int rowNum) throws SQLException {
				StudentVO studentVO = new StudentVO();
				studentVO.setId(rs.getString("id"));
				studentVO.setName(rs.getString("name"));
				studentVO.setKor(rs.getInt("kor"));
				studentVO.setEng(rs.getInt("eng"));
				studentVO.setMat(rs.getInt("mat"));
				return studentVO;
			}
		};
	}

	@BeforeEach
	void beforEach() {
		sql = new StringBuffer();
	}
	@Inject
	JdbcTemplate jt;
	@Test
	@Disabled
	void select1() {
		sql.append("select id,name,kor,eng,mat from student");

		List<Map<String,Object>> list =	jt.queryForList(sql.toString());
		for(Map<String,Object> item : list) {
			logger.info(item.toString());
		}
	}
	@Test
	@Disabled

	void select2() {
		sql.append("select kor from student");

		List<StudentVO> list = jt.queryForList(sql.toString(), StudentVO.class);

	}
	@Test
	@Disabled
	void select4() {
		sql.append("select name from student where kor >= ? and mat >= ?");

		List<String> list = jt.queryForList(sql.toString(),String.class,80,80);
		for(String name : list) {
			logger.info(name);
		}
	}
	@Test
	@Disabled

	void select5() {
		sql.append("select name from student where kor >= ? and mat >= ?");

		List<String> list = jt.queryForList(
				sql.toString(),
				new Object[] {80,80},
				String.class);
		for(String name : list) {
			logger.info(name);
		}
	}
	@Test
	@Disabled
	void select6() {
		sql.append("select kor,mat from student where kor >=? and mat >= ?");

		List<Map<String,Object>> list =	jt.queryForList(
				sql.toString(),
				new Object[] {80,80},
				new int[] {Types.INTEGER,Types.INTEGER}
				);
		for(Map<String,Object> item : list) {
			logger.info(item.toString());
		}
	}


	@Disabled
	void select7() {
		sql.append("select name from student where kor >=? and mat >=?");
		List<String> list =	jt.queryForList(
				sql.toString(), 
				new Object[] {80,80}, 
				new int[]{Types.INTEGER, Types.INTEGER}, 
				String.class);
		for(String item : list) {
			logger.info(item);
		}
	}

	@Test
	@Disabled
	void select11() {
		sql.append("select id,name,kor,eng,mat from student where id='id1'");
		Map<String, Object> map = jt.queryForMap(sql.toString());
		Set<String> keyset = map.keySet();

		for(String key : keyset) {
			logger.info("key = " + key);
			logger.info("value = " + map.get(key));
		}
	}

	@Test
	@Disabled
	void select12() {
		sql.append("select id,name,kor,eng,mat from student where kor >=? and mat >=?");
		Map<String, Object> map = jt.queryForMap(sql.toString(),80,80);
		assertNotNull(map);
		assertEquals("id1", (String)map.get("id"));
		logger.info(map.toString());
	}

	@Test
	@Disabled
	void select13() {
		sql.append("select name from student where id=?");
		Map<String, Object> map = jt.queryForMap(
				sql.toString(),
				new Object[] {"id1"},
				new int[] {Types.VARCHAR});
		assertNotNull(map);
		logger.info(map.toString());
	}
	//	@Test
	//	@Disabled
	//	void select14() {
	//		sql.append("select count(*) from student");
	//		jt.queryForObject
	//		Integer cnt = jt.queryForObject(
	//				sql.toString(), 
	//				Integer.class);
	//		assertNotNull(cnt);
	//		assertEquals(3, cnt);
	//		logger.info(cnt.toString());
	//	}

	@Test
	@Disabled
	void select15() {
		sql.append("select * from student where id = 'id1'");
		StudentVO studentVO = jt.queryForObject(sql.toString(), new RowMapper<StudentVO>() {
			@Override
			public StudentVO mapRow(ResultSet rs, int rowNum) throws SQLException {
				StudentVO studentVO = new StudentVO();
				studentVO.setId(rs.getString("id"));
				studentVO.setName(rs.getString("name"));
				studentVO.setKor(rs.getInt("kor"));
				studentVO.setEng(rs.getInt("eng"));
				studentVO.setMat(rs.getInt("mat"));
				return studentVO;
			}
		});
		assertNotNull(studentVO);
		assertEquals("id1", studentVO.getId());
	}

	@Test
	@Disabled
	void test16() {
		sql.append("select count(*) from student where mat >=?");
		Integer cnt = jt.queryForObject(sql.toString(), Integer.class,90);
		assertNotNull(cnt);
		assertEquals(2, cnt);
		logger.info(cnt.toString());
	}

	@Test
	@Disabled
	void test24() {
		sql.append("select count(*) from student where mat >=?");
		Integer cnt = jt.queryForObject(sql.toString(), new Object[] {80},Integer.class);
		assertNotNull(cnt);
		assertEquals(3, cnt);
		logger.info(cnt.toString());
	}
	@Test
	@Disabled
	void test25() {
		sql.append("select * from student where mat >=?");
		jt.queryForObject(sql.toString(), new Object[] {80},Integer.class);
	}
	@Test
	@Disabled
	void test27() {
		sql.append("select name from student where id = ?");
		String name = jt.queryForObject(
				sql.toString(), 
				new Object[] {"id1"}, 
				new int[] {Types.VARCHAR}, 
				String.class);
		assertEquals("ȫ�浿", name);
	}
	@Test
	@Disabled
	void test28() {
		sql.append("select * from student where id = ?");
		StudentVO studentVO = 
				jt.queryForObject(sql.toString(), new Object[] {"id1"}, new int[] {Types.VARCHAR}, rowMapper);
		assertNotNull(studentVO);
		assertEquals("id1", studentVO.getId());
		logger.info(studentVO.getId());
	}

	@Test
	@Disabled
	void test31() {
		sql.append("select * from student");
		SqlRowSet rs = jt.queryForRowSet(sql.toString());
		while(rs.next()) {
			logger.info(rs.getString("name"));
		}
	}

	@Test
	@Disabled
	void select41() {
		sql.append("select * from student where eng >= ? and mat >= ?");
		List<StudentVO> list = jt.query(
				//				new PreparedStatementCreator() {
				//			@Override
				//			public PreparedStatement createPreparedStatement(Connection con) throws SQLException {
				//				PreparedStatement pstmt = con.prepareStatement(sql.toString());
				//				pstmt.setInt(1, 80);
				//				pstmt.setInt(2, 80);
				//				return pstmt;
				//			}
				//		}
				(Connection con) -> {
					PreparedStatement pstmt = con.prepareStatement(sql.toString());
					pstmt.setInt(1, 80);
					pstmt.setInt(2, 80);
					return pstmt;
				}

				,new ResultSetExtractor<List<StudentVO>>() {
					@Override
					public List<StudentVO> extractData(ResultSet rs) throws SQLException, DataAccessException {
						List<StudentVO> list = new ArrayList<>();
						while(rs.next()) {
							StudentVO studentVO = new StudentVO();
							studentVO.setId(rs.getString("id"));
							studentVO.setName(rs.getString("name"));
							studentVO.setKor(rs.getInt("kor"));
							studentVO.setEng(rs.getInt("eng"));
							studentVO.setMat(rs.getInt("mat"));
							list.add(studentVO);
						}
						return list;
					}
				});
		assertNotNull(list);
		for(StudentVO item : list) { 
			logger.info(item.toString());
		}
	}
	@Test
	@Disabled
	void select42() {
		sql.append("select * from student where eng >= ? and mat >= ? ");
		jt.query(new PreparedStatementCreator() {

			@Override
			public PreparedStatement createPreparedStatement(Connection con) throws SQLException {
				PreparedStatement pstmt = con.prepareStatement(sql.toString());
				pstmt.setInt(1, 80);
				pstmt.setInt(2, 80);
				return pstmt;
			}
		}, new RowCallbackHandler() {

			@Override
			public void processRow(ResultSet rs) throws SQLException {
				try (					
						BufferedWriter writer = 
						new BufferedWriter(
								new OutputStreamWriter(
										new FileOutputStream(
												File.createTempFile("student_", ".csv", new File("/"))),"EUC-KR"));
						){

					while(rs.next()) {
						logger.info(rs.getString("id"));
						Object[] array = new Object[] {
								rs.getString("id"),rs.getString("name"),rs.getInt("kor"),rs.getInt("eng"),rs.getInt("mat")
						};
						String reportRow = StringUtils.arrayToCommaDelimitedString(array);
						writer.write(reportRow);
						writer.newLine();		
						writer.flush();
					}
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		});
	}

	@Test
	@Disabled
	void select43() {
		sql.append("select * from student where eng >= ? and mat >= ? ");
		List<StudentVO> list = jt.query((Connection con) -> {
			PreparedStatement pstmt = con.prepareStatement(sql.toString());
			pstmt.setInt(1, 80);
			pstmt.setInt(2, 80);
			return pstmt;
		}, rowMapper);
		assertNotNull(list);
		logger.info(list.toString());
	}

	@Test 
	void select44() {
		sql.append("select * from student where eng >= ? and mat >= ? ");

		jt.query(new PreparedStatementCreator() {

			@Override
			public PreparedStatement createPreparedStatement(Connection con) throws SQLException {
				PreparedStatement pstmt = con.prepareStatement(sql.toString());
				return pstmt;
			}
		}, new PreparedStatementSetter() {
			@Override
			public void setValues(PreparedStatement ps) throws SQLException {
				ps.setInt(1, 80);
				ps.setInt(2, 80);
			}
		}, new ResultSetExtractor<List<StudentVO>>() {
			@Override
			public List<StudentVO> extractData(ResultSet rs) throws SQLException, DataAccessException {
				List<StudentVO> list = new ArrayList<>();
				while(rs.next()) {
					StudentVO studentVO = new StudentVO();
					studentVO.setId(rs.getString("id"));
					studentVO.setName(rs.getString("name"));
					studentVO.setKor(rs.getInt("kor"));
					studentVO.setEng(rs.getInt("eng"));
					studentVO.setMat(rs.getInt("mat"));
					list.add(studentVO);
				}
				logger.info(list.toString());
				return list;
			}
		});
	}

}































