package com.oracle.devwareProject.domain.jiwoong;

import lombok.Data;

@Data
public class Criteria {
	
	private int pageNum;
	private int amount;
	
	private String searchType;
	private String keyword;
	
	public Criteria(){
		this(1, 10);
	}

	public Criteria(int pageNum, int amount) {
		this.pageNum=pageNum;
		this.amount=amount;
	}
	
	
	
}
