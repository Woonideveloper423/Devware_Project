package com.oracle.devwareProject.repository.jehwan;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.EntityManager;

import org.springframework.stereotype.Repository;
import org.springframework.web.multipart.MultipartFile;

import com.oracle.devwareProject.domain.jehwan.Mail;
import com.oracle.devwareProject.domain.jehwan.MailAccount;
import com.oracle.devwareProject.domain.jehwan.MailAttach;
import com.oracle.devwareProject.domain.jehwan.MailImportant;
import com.oracle.devwareProject.domain.jehwan.MailImportantID;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class MailRepositoryImpl implements MailRepository {
	private final EntityManager em;

	@Override
	public int sendEmail(Mail mail) {
		System.out.println("MailRepositoryImpl sendEmail start..");
		
		em.persist(mail);
//		Long i = 1L;
//		if(!mail.getUploadFile()[0].isEmpty()) {
//			for(MultipartFile multipartFile : mail.getUploadFile()) {
//				MailAttach mailAttach = new MailAttach();
//				mailAttach.setMail_attach_num(i);
//				mailAttach.setMail(mail);
//				mailAttach.setMail_attach_save_name(multipartFile.getName());
//				mailAttach.setMail_attach_real_name(multipartFile.getOriginalFilename());
//				mailAttach.setMail_attach_type(multipartFile.getContentType());
//				em.persist(mailAttach);
//				i++;
//			}
//		}
		
		
		return 0;
	}

	@Override
	public void saveAttach(MailAttach mailAttach) {
		em.persist(mailAttach);
	}
	
	@Override
	public Long countSendMail(String mailAccount, String search, String keyword) {
		Long result = 0L;
		if(keyword==null || keyword == "") {
			result = (Long) em.createQuery("SELECT COUNT(m) From Mail m where SENDER_MAIL = :SENDER_MAIL and DELETE_CHK = 0").setParameter("SENDER_MAIL", mailAccount).getSingleResult();
		}else {
			if(search.equals("s_title")) {
				result = (Long) em.createQuery("SELECT COUNT(m) From Mail m where SENDER_MAIL = :SENDER_MAIL and MAIL_TITLE like concat('%',:MAIL_TITLE,'%') and DELETE_CHK = 0").setParameter("SENDER_MAIL", mailAccount).setParameter("MAIL_TITLE", keyword).getSingleResult();
			}else if(search.equals("s_content")) {
				result = (Long) em.createQuery("SELECT COUNT(m) From Mail m where SENDER_MAIL = :SENDER_MAIL and MAIL_CONTENT like concat('%',:MAIL_CONTENT,'%') and DELETE_CHK = 0").setParameter("SENDER_MAIL", mailAccount).setParameter("MAIL_CONTENT", keyword).getSingleResult();
			}else {
				result = (Long) em.createQuery("SELECT COUNT(m) From Mail m where SENDER_MAIL = :SENDER_MAIL and RECEIVER_MAIL like concat('%',:RECEIVER_MAIL,'%') and DELETE_CHK = 0").setParameter("SENDER_MAIL", mailAccount).setParameter("RECEIVER_MAIL", keyword).getSingleResult();
			}
		}
		return result;
	}
	
	@Override
	public Long countReceiveMail(String mailAccount, String search, String keyword) {
		Long result = 0L;
		if(keyword==null || keyword == "") {
			result = (Long) em.createQuery("SELECT COUNT(m) From Mail m where RECEIVER_MAIL = :RECEIVER_MAIL and DELETE_CHK = 0").setParameter("RECEIVER_MAIL", mailAccount).getSingleResult();
		}else {
			if(search.equals("s_title")) {
				result = (Long) em.createQuery("SELECT COUNT(m) From Mail m where RECEIVER_MAIL = :RECEIVER_MAIL and MAIL_TITLE like concat('%',:MAIL_TITLE,'%') and DELETE_CHK = 0").setParameter("RECEIVER_MAIL", mailAccount).setParameter("MAIL_TITLE", keyword).getSingleResult();
			}else if(search.equals("s_content")) {
				result = (Long) em.createQuery("SELECT COUNT(m) From Mail m where RECEIVER_MAIL = :RECEIVER_MAIL and MAIL_CONTENT like concat('%',:MAIL_CONTENT,'%') and DELETE_CHK = 0").setParameter("RECEIVER_MAIL", mailAccount).setParameter("MAIL_CONTENT", keyword).getSingleResult();
			}else {
				result = (Long) em.createQuery("SELECT COUNT(m) From Mail m where RECEIVER_MAIL = :RECEIVER_MAIL and RECEIVER_MAIL like concat('%',:RECEIVER_MAIL,'%') and DELETE_CHK = 0").setParameter("RECEIVER_MAIL", mailAccount).setParameter("RECEIVER_MAIL", keyword).getSingleResult();
			}
		}
		return result;
	}
	
	@Override
	public Long countImportantMail(String mailAccount, String search, String keyword) {
		Long result = 0L;
		
		result = (Long) em.createQuery("SELECT COUNT(m) From Mail m where RECEIVER_MAIL = :RECEIVER_MAIL").setParameter("RECEIVER_MAIL", mailAccount).getSingleResult();
		
		return result;
	}

	@Override
	public Long countDeletedMail(String mailAccount, String search, String keyword) {
		Long result = 0L;
		if(keyword==null || keyword == "") {
			result = (Long) em.createQuery("SELECT COUNT(m) From Mail m where SENDER_MAIL = :SENDER_MAIL OR RECEIVER_MAIL = :RECEIVER_MAIL AND DELETE_CHK = 1").setParameter("SENDER_MAIL", mailAccount).setParameter("RECEIVER_MAIL", mailAccount).getSingleResult();
		}else {
			if(search.equals("s_title")) {
				result = (Long) em.createQuery("SELECT COUNT(m) From Mail m where (SENDER_MAIL = :SENDER_MAIL OR RECEIVER_MAIL = :RECEIVER_MAIL) and MAIL_TITLE like concat('%',:MAIL_TITLE,'%') AND DELETE_CHK = 1").setParameter("SENDER_MAIL", mailAccount).setParameter("RECEIVER_MAIL", mailAccount).setParameter("MAIL_TITLE", keyword).getSingleResult();
			}else if(search.equals("s_content")) {
				result = (Long) em.createQuery("SELECT COUNT(m) From Mail m where (SENDER_MAIL = :SENDER_MAIL OR RECEIVER_MAIL = :RECEIVER_MAIL) and MAIL_CONTENT like concat('%',:MAIL_CONTENT,'%') AND DELETE_CHK = 1").setParameter("SENDER_MAIL", mailAccount).setParameter("RECEIVER_MAIL", mailAccount).setParameter("MAIL_CONTENT", keyword).getSingleResult();
			}else {
				result = (Long) em.createQuery("SELECT COUNT(m) From Mail m where (SENDER_MAIL = :SENDER_MAIL OR RECEIVER_MAIL = :RECEIVER_MAIL) and RECEIVER_MAIL like concat('%',:RECEIVER_MAIL,'%') AND DELETE_CHK = 1").setParameter("SENDER_MAIL", mailAccount).setParameter("RECEIVER_MAIL", mailAccount).setParameter("RECEIVER_MAIL", keyword).getSingleResult();
			}
		}
		return result;
	}
	
	@Override
	public List<Mail> listSendMail(String mailAccount,int empno, int start, int end, String search, String keyword) {
		System.out.println("MailRepositoryImpl listMail start...");
		System.out.println("MailRepositoryImpl listMail search->" + search);
		
		List<Mail> mailList = new ArrayList<Mail>();
		if(keyword==null || keyword == "") {
			System.out.println("MailRepositoryImpl listMail no searchOption");
			mailList = em.createQuery("SELECT m FROM Mail m WHERE SENDER_MAIL = :SENDER_MAIL and DELETE_CHK = 0", Mail.class).setParameter("SENDER_MAIL", mailAccount).setFirstResult(start-1).setMaxResults(10).getResultList();
		}else {
			if(search.equals("s_title")) {
				mailList = em.createQuery("SELECT m FROM Mail m WHERE SENDER_MAIL = :SENDER_MAIL and MAIL_TITLE like concat('%',:MAIL_TITLE,'%') and DELETE_CHK = 0", Mail.class).setParameter("SENDER_MAIL", mailAccount).setParameter("MAIL_TITLE", keyword).setFirstResult(start-1).setMaxResults(10).getResultList();
			}else if(search.equals("s_content")) {
				mailList = em.createQuery("SELECT m FROM Mail m WHERE SENDER_MAIL = :SENDER_MAIL and MAIL_CONTENT like concat('%',:MAIL_CONTENT,'%') and DELETE_CHK = 0", Mail.class).setParameter("SENDER_MAIL", mailAccount).setParameter("MAIL_CONTENT", keyword).setFirstResult(start-1).setMaxResults(10).getResultList();
			}else {
				mailList = em.createQuery("SELECT m FROM Mail m WHERE SENDER_MAIL = :SENDER_MAIL and RECEIVER_MAIL like concat('%',:RECEIVER_MAIL,'%') and DELETE_CHK = 0", Mail.class).setParameter("SENDER_MAIL", mailAccount).setParameter("RECEIVER_MAIL", keyword).setFirstResult(start-1).setMaxResults(10).getResultList();
			}
		}
		for(Mail mail : mailList) {
			
			MailImportantID mailImportantID = new MailImportantID(mail.getMail_num(),empno);
			MailImportant mailImportant = em.find(MailImportant.class, mailImportantID);
			if(mailImportant !=null) {
				mail.setIsImportant(1L);
			}else {
				mail.setIsImportant(0L);
			}
		}
		return mailList;
	}

	@Override
	public List<Mail> listReceiveMail(String mailAccount,int empno, int start, int end, String search, String keyword) {
		System.out.println("MailRepositoryImpl listMail start...");
		List<Mail> mailList = new ArrayList<Mail>();
		if(keyword==null || keyword == "") {
			mailList = em.createQuery("SELECT m FROM Mail m WHERE RECEIVER_MAIL = :RECEIVER_MAIL and DELETE_CHK = 0", Mail.class).setParameter("RECEIVER_MAIL", mailAccount).setFirstResult(start-1).setMaxResults(10).getResultList();
		}else {
			if(search.equals("s_title")) {
				mailList = em.createQuery("SELECT m FROM Mail m WHERE RECEIVER_MAIL = :RECEIVER_MAIL and MAIL_TITLE like concat('%',:MAIL_TITLE,'%') and DELETE_CHK = 0", Mail.class).setParameter("RECEIVER_MAIL", mailAccount).setParameter("MAIL_TITLE", keyword).setFirstResult(start-1).setMaxResults(10).getResultList();
			}else if(search.equals("s_content")) {
				mailList = em.createQuery("SELECT m FROM Mail m WHERE RECEIVER_MAIL = :RECEIVER_MAIL and MAIL_CONTENT like concat('%',:MAIL_CONTENT,'%') and DELETE_CHK = 0", Mail.class).setParameter("RECEIVER_MAIL", mailAccount).setParameter("MAIL_CONTENT", keyword).setFirstResult(start-1).setMaxResults(10).getResultList();
			}else {
				mailList = em.createQuery("SELECT m FROM Mail m WHERE RECEIVER_MAIL = :RECEIVER_MAIL and RECEIVER_MAIL like concat('%',:RECEIVER_MAIL,'%') and DELETE_CHK = 0", Mail.class).setParameter("RECEIVER_MAIL", mailAccount).setParameter("RECEIVER_MAIL", keyword).setFirstResult(start-1).setMaxResults(10).getResultList();
			}
		}
		for(Mail mail : mailList) {
			
			MailImportantID mailImportantID = new MailImportantID(mail.getMail_num(),empno);
			MailImportant mailImportant = em.find(MailImportant.class, mailImportantID);
			if(mailImportant !=null) {
				mail.setIsImportant(1L);
			}else {
				mail.setIsImportant(0L);
			}
		}
		return mailList;
	}

	@Override
	public List<Mail> listImportantMail(String mailAccount,int empno, int start, int end, String search, String keyword) {
		System.out.println("MailRepositoryImpl listMail start...");
		List<MailImportant> mailImportants = em.createQuery("SELECT mi FROM MailImportant mi where EMP_NUM = :EMP_NUM").setParameter("EMP_NUM", empno).getResultList();
		List<Mail> mailList = new ArrayList<Mail>();
		if(keyword==null || keyword == "") {
			for(MailImportant mailImportant : mailImportants) {
				mailImportant.getMail().setIsImportant(1L);
				mailList.add(mailImportant.getMail());
			}
		}else {
			if(search.equals("s_title")) {
				for(MailImportant mailImportant : mailImportants) {
					if(mailImportant.getMail().getMail_title().contains(keyword)) {
						mailImportant.getMail().setIsImportant(1L);
						mailList.add(mailImportant.getMail());
					}
				}
			}else if(search.equals("s_content")) {
				for(MailImportant mailImportant : mailImportants) {
					if(mailImportant.getMail().getMail_content().contains(keyword)) {
						mailImportant.getMail().setIsImportant(1L);
						mailList.add(mailImportant.getMail());
					}
				}
			}else {
				for(MailImportant mailImportant : mailImportants) {
					if((mailImportant.getMail().getReceiver_mail().contains(keyword))||(mailImportant.getMail().getSender_mail().contains(keyword))) {
						mailImportant.getMail().setIsImportant(1L);
						mailList.add(mailImportant.getMail());
					}
				}
			}
		}
		return mailList;
	}

	@Override
	public List<Mail> listDeletedMail(String mailAccount, int start, int end, String search, String keyword) {
		System.out.println("MailRepositoryImpl listMail start...");
		List<Mail> mailList = new ArrayList<Mail>();
		if(keyword==null || keyword == "") {
			mailList = em.createQuery("SELECT m FROM Mail m WHERE (RECEIVER_MAIL = :RECEIVER_MAIL OR SENDER_MAIL = :SENDER_MAIL) AND DELETE_CHK = 1", Mail.class).setParameter("RECEIVER_MAIL", mailAccount).setParameter("SENDER_MAIL", mailAccount).setFirstResult(start-1).setMaxResults(10).getResultList();
		}else {
			if(search.equals("s_title")) {
				mailList = em.createQuery("SELECT m FROM Mail m WHERE (RECEIVER_MAIL = :RECEIVER_MAIL OR SENDER_MAIL = :SENDER_MAIL) and MAIL_TITLE like concat('%',:MAIL_TITLE,'%') and DELETE_CHK = 1", Mail.class).setParameter("RECEIVER_MAIL", mailAccount).setParameter("SENDER_MAIL", mailAccount).setParameter("MAIL_TITLE", keyword).setFirstResult(start-1).setMaxResults(10).getResultList();
			}else if(search.equals("s_content")) {
				mailList = em.createQuery("SELECT m FROM Mail m WHERE (RECEIVER_MAIL = :RECEIVER_MAIL OR SENDER_MAIL = :SENDER_MAIL) and MAIL_CONTENT like concat('%',:MAIL_CONTENT,'%') and DELETE_CHK = 1", Mail.class).setParameter("RECEIVER_MAIL", mailAccount).setParameter("SENDER_MAIL", mailAccount).setParameter("MAIL_CONTENT", keyword).setFirstResult(start-1).setMaxResults(10).getResultList();
			}else {
				mailList = em.createQuery("SELECT m FROM Mail m WHERE (RECEIVER_MAIL = :RECEIVER_MAIL OR SENDER_MAIL = :SENDER_MAIL) and RECEIVER_MAIL like concat('%',:RECEIVER_MAIL,'%') and DELETE_CHK = 1", Mail.class).setParameter("RECEIVER_MAIL", mailAccount).setParameter("SENDER_MAIL", mailAccount).setParameter("RECEIVER_MAIL", keyword).setFirstResult(start-1).setMaxResults(10).getResultList();
			}
		}
		
		return mailList;
	}



//	@Override
//	public Mail mailDetail(Mail mail) {
//		Mail MailDetail = em.find(Mail.class, mail.getMail_num());
//		List<MailAttach> mailAttach = em.createQuery("select ma from MailAttach ma WHERE MAIL_NUM = :MAIL_NUM", MailAttach.class).setParameter("MAIL_NUM", mail.getMail_num()).getResultList();
//		System.out.println("mailAttach ->" +  mailAttach);
//		System.out.println("mail ->" +  MailDetail);
//		//MailDetail.setMailAttach(mailAttach);
//		return MailDetail;
//	}

	@Override
	public void readMail(Long mail_num) {
		System.out.println("MailRepositoryImpl readMail start...");
		Mail mail = em.find(Mail.class, mail_num);
		mail.setRead_chk(1L);
		em.persist(mail);
	}

	@Override
	public void deleteNotRead(String mailAccount) {
		System.out.println("MailRepositoryImpl deleteNotRead start...");
		List<Mail> mailList = em.createQuery("select m from Mail m where RECEIVER_MAIL = :RECEIVER_MAIL and READ_CHK = 0").setParameter("RECEIVER_MAIL", mailAccount).getResultList();
		System.out.println("mailList.size->" + mailList.size());
		for(Mail mail : mailList) {
			mail.setDelete_chk(1L);
			em.persist(mail);
		}
		
	}

	@Override
	public void deleteMail(List<String> deleteArray) {
		System.out.println("MailRepositoryImpl deleteMail start...");
			List<Mail> mailList = new ArrayList<Mail>();
			for(String mailNumStr : deleteArray) {
				Long mailNum = (long) Integer.parseInt(mailNumStr);
				Mail mail = new Mail();
				mail = em.find(Mail.class, mailNum);
				mailList.add(mail);
			}
			System.out.println("mailList.size->" + mailList.size());
			for(Mail mail : mailList) {
				mail.setDelete_chk(1L);
				em.persist(mail);
			}
		System.out.println("MailRepositoryImpl deleteMail after...");
	}

	@Override
	public void restore_mail(List<String> deleteArray) {
		System.out.println("MailRepositoryImpl restore_mail start...");
		List<Mail> mailList = new ArrayList<Mail>();
		for(String mailNumStr : deleteArray) {
			Long mailNum = (long) Integer.parseInt(mailNumStr);
			Mail mail = new Mail();
			mail = em.find(Mail.class, mailNum);
			mailList.add(mail);
		}
		System.out.println("mailList.size->" + mailList.size());
		for(Mail mail : mailList) {
				mail.setDelete_chk(0L);
				em.persist(mail);
		}
	System.out.println("MailRepositoryImpl restore_mail after...");
	}

	@Override
	public void mailImportant(int empno, Long mailNumLong, String isImportant) {
		System.out.println("MailRepositoryImpl mailImportant start...");
		System.out.println("MailRepositoryImpl mailImportant isImportant->" + isImportant);
		
		if(isImportant.equals("important")) {
			MailImportantID mailImportantID = new MailImportantID(mailNumLong,empno);
			MailImportant mailImportant = em.find(MailImportant.class, mailImportantID);
			em.remove(mailImportant);
		}else {
			MailImportant mailImportant = new MailImportant();
			Mail mail = em.find(Mail.class, mailNumLong);
			MailAccount mailAccount = em.find(MailAccount.class, empno);
			mailImportant.setMail(mail);
			mailImportant.setMailAccount(mailAccount);
			em.persist(mailImportant);
		}
	}

	@Override
	public void deleteDetailMail(Long mailNum) {
		System.out.println("MailRepositoryImpl deleteDetailMail start...");
		Mail mail = em.find(Mail.class, mailNum);
		mail.setDelete_chk(1L);
		em.persist(mail);
	}

	@Override
	public void restoreDetailMail(Long mailNum) {
		Mail mail = em.find(Mail.class, mailNum);
		mail.setDelete_chk(0L);
		em.persist(mail);
	}

	@Override
	public List<String> premanDelete(List<String> deleteArray) {
		System.out.println("MailRepositoryImpl deleteMail start...");
		List<Mail> mailList = new ArrayList<Mail>();
		List<String> deleteFileName = new ArrayList<String>();
		for(String mailNumStr : deleteArray) {
			Long mailNum = (long) Integer.parseInt(mailNumStr);
			Mail mail = new Mail();
			mail = em.find(Mail.class, mailNum);
			mailList.add(mail);
		}
		System.out.println("mailList.size->" + mailList.size());
		for(Mail mail : mailList) {
			for(MailAttach mailAttach : mail.getMailAttachs()) {
				deleteFileName.add(mailAttach.getMail_attach_save_name());
			}
			em.remove(mail);
		}
		System.out.println("MailRepositoryImpl deleteMail after...");
		return deleteFileName;
	}

	@Override
	public List<String> premanDetailDelete(Long mailNum) {
		System.out.println("MailRepositoryImpl deleteDetailMail start...");
		Mail mail = em.find(Mail.class, mailNum);
		List<String> deleteFileName = new ArrayList<String>();
		for(MailAttach mailAttach : mail.getMailAttachs()) {
			deleteFileName.add(mailAttach.getMail_attach_save_name());
		}
		em.remove(mail);
		return deleteFileName;
	}

//	@Override
//	public List<MailAttach> mailDetail(Long mail_num) {
//		List<MailAttach> mailAttach = em.createQuery("select ma from MailAttach ma WHERE MAIL_NUM = :MAIL_NUM", MailAttach.class).setParameter("MAIL_NUM", mail_num).getResultList();
//		System.out.println("MailRepositoryImpl mailDetail -> " + mailAttach);
//		return mailAttach;
//	}

	

	
	
}
