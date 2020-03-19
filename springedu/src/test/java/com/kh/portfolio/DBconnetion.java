package com.kh.portfolio;

import javax.sql.DataSource;

import static org.junit.jupiter.api.Assertions.assertNotNull;

import java.sql.Connection;
import java.sql.SQLException;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mybatis.spring.SqlSessionTemplate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit.jupiter.SpringExtension;

@ExtendWith(SpringExtension.class)//스프링컨텍스트와 junit 통합
@ContextConfiguration(locations={"file:src/main/webapp/WEB-INF/spring/root-context.xml"})
public class DBconnetion {
	private static final Logger logger = LoggerFactory.getLogger(DBconnetion.class);
	
	
	@Inject
	DataSource dataSource;
	@Inject
	JdbcTemplate jdbcTemplate;

	@Test
	@DisplayName("DB 연결 유무")
	void testdb() {
		logger.info("데이터 소스" + dataSource);
		logger.info("jdbcTemplate:" + jdbcTemplate);
		try {
			Connection conn = dataSource.getConnection();
			Assertions.assertNotNull(conn);
			logger.info("DB 연결 성공!!");
		} catch (SQLException e) {
			logger.error("DB 연결 실패!!");
			e.printStackTrace();
		}
	}
	
	
	
}



















