package com.oracle.devwareProject.repository.jehwan;

import java.util.List;

import com.oracle.devwareProject.domain.jehwan.Mail;
import com.oracle.devwareProject.domain.jehwan.MailAccount;
import com.oracle.devwareProject.domain.jehwan.MailAttach;


public interface MailRepository {

	int sendEmail(Mail mail);

	void saveAttach(MailAttach mailAttach);

	Long countImportantMail(String mailAccount, String search, String keyword);

	Long countDeletedMail(String mailAccount, String search, String keyword);

	Long countSendMail(String mailAccount, String search, String keyword);

	Long countReceiveMail(String mailAccount, String search, String keyword);

	List<Mail> listSendMail(String mailAccount, int empno, int start, int end, String search, String keyword);

	List<Mail> listReceiveMail(String mailAccount, int empno, int start, int end, String search, String keyword);

	List<Mail> listImportantMail(String mailAccount, int empno, int start, int end, String search, String keyword);

	List<Mail> listDeletedMail(String mailAccount, int start, int end, String search, String keyword);


	//Mail mailDetail(Mail mail);

	void readMail(Long mail_num);

	void deleteNotRead(String mailAccount);

	List<String> premanDelete(List<String> deleteArray);

	
	void deleteMail(List<String> deleteArray);
	
	void restore_mail(List<String> deleteArray);

	void mailImportant(int empno, Long mailNumLong, String isImportant);

	List<String> premanDetailDelete(Long mailNum);
	
	void deleteDetailMail(Long mailNum);

	void restoreDetailMail(Long mailNum);

	int mailCreateDone(int emp_num);

	Long permitCheck(int emp_num);

	Long countNotReadMail(String mailAccount);

	
	

}
