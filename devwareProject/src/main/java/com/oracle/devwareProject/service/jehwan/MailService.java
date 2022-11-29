package com.oracle.devwareProject.service.jehwan;

import java.io.IOException;
import java.util.List;

import javax.mail.MessagingException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oracle.devwareProject.domain.jehwan.Mail;


public interface MailService {

	int sendEmail(HttpServletRequest request, Mail mail);

	int receiveMail(HttpServletRequest request) throws MessagingException, IOException;

	Long countMail(String MailAccount, int mailType, String search, String keyword);

	List<Mail> listMail(String MailAccount, Long empno, int start, int end, int mailType, String search, String keyword);

	//Mail mailDetail(Mail mail);

	void readMail(Long mail_num);

	void deleteNotRead(String mailAccount);

	void deleteMail(List<String> deleteArray, String uploadFolder, int mailType);

	void restore_mail(List<String> deleteArray);

	void mailImportant(Long empno, Long mailNumLong, String isImportant);

	void deleteDetailMail(String uploadFolder, Long mailNum, int mailType);

	void restoreDetailMail(Long mailNum);

	void saveAttach(HttpServletRequest request, HttpServletResponse response, String saveName, String realName,
			String uploadFolder);

}
