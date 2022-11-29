package com.oracle.devwareProject.domain.jehwan;

import java.util.List;

import com.oracle.devwareProject.service.jehwan.Paging;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class MailListVO {
	private String search;	
	private String keyword;
	private String pageNum;
	private int start;		
	private int end;
	private int mailType;
	private Paging paging;
	private List<Mail> mailList;
	//private List<List<MailAttachVO>> mailAttaches;
	private List<List<MailAttach>> mailAttaches;
}
