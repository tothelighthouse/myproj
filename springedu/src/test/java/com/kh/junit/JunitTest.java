package com.kh.junit;

import static org.junit.jupiter.api.Assertions.assertEquals;

import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Disabled;
import org.junit.jupiter.api.Test;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class JunitTest {

	private static final Logger logger
	= LoggerFactory.getLogger(JunitTest.class);
	@BeforeAll
	static void beforeAll() {
		logger.info("Ŭ���� �������� ���������׽�Ʈ �� ����");

	}
	@AfterAll
	static void afterAll() {
		logger.info("Ŭ���� �������� ���������׽�Ʈ  �� ����");
	}

	@BeforeEach
	void beforeEach() {
		logger.info("���������׽�Ʈ �� ����");
	}
	@AfterEach
	void afterEach() {
		logger.info("���������׽�Ʈ �� ����");
	}
	@Test
	void test1() {
		assertEquals(10,5+5);
		logger.info("test1() ����");
	}
	@Test
	@Disabled
	void test2() {
		logger.info("test2() ����");
		assertEquals(101, 10*10);
	}
}





















