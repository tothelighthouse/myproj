package com.kh.portfolio.board;

import static org.junit.jupiter.api.Assertions.assertNotNull;

import java.util.List;

import javax.inject.Inject;

import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit.jupiter.SpringExtension;

import com.kh.portfolio.board.dao.BoardDAO;
import com.kh.portfolio.board.vo.BoardVO;
import com.kh.portfolio.common.RecordCriteria;

@ExtendWith(SpringExtension.class)
@ContextConfiguration(locations = {"file:src/main/webapp/WEB-INF/spring/root-context.xml"})
public class BoardDAOImpleXMLTest {

	private static final Logger logger = LoggerFactory.getLogger(BoardDAOImpleXMLTest.class);

	@Inject
	@Qualifier("boardDAOImplXML")
	BoardDAO boardDAO;
	
	@Inject
	RecordCriteria recordCriteria;
	
	@Test
	@DisplayName("게시글 목록")
	void list3() {
		int reqPage = 1;
		recordCriteria.setReqPage(reqPage); 
		List<BoardVO> list = boardDAO.list(recordCriteria.getStartRec(),
																			 recordCriteria.getEndRec(),
																			 "TC","제목");
		for(BoardVO boardVO : list) {
			logger.info(boardVO .toString());
		}
		assertNotNull(list);
	}
}





















