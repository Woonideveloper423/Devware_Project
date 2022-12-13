package com.oracle.devwareProject.service.jehwan;

import java.io.IOException;
import java.util.List;

import javax.mail.MessagingException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oracle.devwareProject.domain.EmpForSearch;
import com.oracle.devwareProject.domain.jehwan.Mail;
import com.oracle.devwareProject.domain.jehwan.MailAccount;


public interface MailService {

	int sendEmail(HttpSession session, Mail mail);

	Long receiveMail(HttpSession session) throws MessagingException, IOException;

	Long countMail(String MailAccount, int mailType, String search, String keyword);

	List<Mail> listMail(String MailAccount, int empno, int start, int end, int mailType, String search, String keyword);

	//Mail mailDetail(Mail mail);

	void readMail(Long mail_num);

	void deleteNotRead(String mailAccount);

	void deleteMail(List<String> deleteArray, String uploadFolder, int mailType);

	void restore_mail(List<String> deleteArray);

	void mailImportant(int empno, Long mailNumLong, String isImportant);

	void deleteDetailMail(String uploadFolder, Long mailNum, int mailType);

	void restoreDetailMail(Long mailNum);

	void saveAttach(HttpServletRequest request, HttpServletResponse response, String saveName, String realName,
			String uploadFolder);

	int mailCreateDone(int emp_num);

	Long permitCheck(int emp_num);

	
}
