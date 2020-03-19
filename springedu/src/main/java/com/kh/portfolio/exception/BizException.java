package com.kh.portfolio.exception;
/*
 * 사용자 정의 예외
 */
public class BizException extends RuntimeException{

	public BizException() {
		super();
	}
	public BizException(String msg) {
		super(msg);
	}
	public BizException(Throwable t) {
		super(t);
	}
	
}
