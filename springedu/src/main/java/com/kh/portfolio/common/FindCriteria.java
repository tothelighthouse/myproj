package com.kh.portfolio.common;

public class FindCriteria extends RecordCriteria{
	
	private String searchType; 		//검색유형
	private String keyword;				//검색어
	
	public FindCriteria(int reqPage) {
		super(reqPage);
	}
	
	public FindCriteria(int reqPage, String searchType, String keyword) {
		this(reqPage);
		this.searchType = searchType;
		this.keyword = keyword;
	}

	public String getSearchType() {
		return searchType;
	}

	public void setSearchType(String searchType) {
		this.searchType = searchType;
	}

	public String getKeyword() {
		return keyword;
	}

	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}
	
}
