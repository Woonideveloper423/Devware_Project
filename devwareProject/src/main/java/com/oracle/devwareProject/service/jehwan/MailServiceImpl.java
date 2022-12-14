package com.oracle.devwareProject.service.jehwan;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Properties;
import java.util.UUID;

import javax.activation.DataHandler;
import javax.activation.DataSource;
import javax.activation.FileDataSource;
import javax.mail.Address;
import javax.mail.Authenticator;
import javax.mail.BodyPart;
import javax.mail.Flags;
import javax.mail.Folder;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Multipart;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Store;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;
import javax.mail.internet.MimeUtility;
import javax.mail.util.ByteArrayDataSource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.IOUtils;
import org.hibernate.pretty.MessageHelper;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.multipart.MultipartFile;

import com.oracle.devwareProject.domain.Emp;
import com.oracle.devwareProject.domain.EmpForSearch;
import com.oracle.devwareProject.domain.jehwan.Mail;
import com.oracle.devwareProject.domain.jehwan.MailAccount;
import com.oracle.devwareProject.domain.jehwan.MailAttach;
import com.oracle.devwareProject.repository.jehwan.MailRepository;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Transactional
@Slf4j
public class MailServiceImpl implements MailService {
	
	private final MailRepository mailRepository;

	@Override
	public int sendEmail(HttpSession session, Mail mail) {
		EmpForSearch emp = (EmpForSearch) session.getAttribute("empForSearch");
		mail.setSender_mail(emp.getEmp_id() + "@devware.shop");
		mail.setSender_name(emp.getEmp_name());
		System.out.println("보내는 메일 주소->" + mail.getSender_mail());
		Properties props = new Properties();
		props.put("mail.smtp.starttls.enable", "true");
		props.setProperty("mail.transport.protocol", "smtp");
		props.put("mail.debug", "false");
		props.put("mail.smtp.host", "devware.shop");
		props.put("mail.smtp.port", "25");
		props.put("mail.smtp.connectiontimeout", "5000");
		props.put("mail.smtp.timeout", "5000");  
		props.put("mail.smtp.auth", "true");
		props.put("mail.smtp.ssl.protocols", "TLSv1.2");
		props.put("mail.smtp.ssl.trust", "devware.shop");
		/*
		 * Session msgSession = null; Authenticator auth = new
		 * MyAuthentication("jehwan@devware.shop", "wpghks12"); msgSession =
		 * Session.getInstance(props, auth); msgSession.setDebug(false);
		 */
		String mail_title = mail.getMail_title();
		String mail_content = mail.getMail_content();
		String mail_receiver_address = mail.getReceiver_mail();
		String mail_receiver_name = mail.getReceiver_name();
	    Session mail_session = Session.getInstance(props, new javax.mail.Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(mail.getSender_mail(), "dev2255!");
            }
        });
	    		
	    log.info("sendermail->" + mail.getReceiver_mail());
	    MimeMessage msg = new MimeMessage(mail_session);
	    MimeBodyPart mimeBodyPart = new MimeBodyPart();
	    Multipart multipart = new MimeMultipart();
	    int result = 0;
	    Transport t = null;
		try {
			msg.setFrom(new InternetAddress(mail.getSender_mail(), mail.getSender_name()));
			msg.setRecipient(Message.RecipientType.TO, new InternetAddress(mail_receiver_address, mail_receiver_name));
			msg.setSubject(MimeUtility.encodeText(mail_title, "UTF-8", "B"));
			//msg.setContent(mail_content, "text/html; charset=UTF-8");
			mimeBodyPart.setContent(mail_content, "text/html; charset=UTF-8");
			multipart.addBodyPart(mimeBodyPart);
			//t = msgSession.getTransport("smtp");
			log.info("Upload mail.getUploadFile().length : " + mail.getUploadFile().length);
			
			if(!mail.getUploadFile()[0].isEmpty()) {
				for(MultipartFile multipartFile : mail.getUploadFile()) {
					log.info("---------------------------------");
					log.info("Upload File Name : " + multipartFile.getOriginalFilename());
					log.info("Upload File Size : " + multipartFile.getSize());
					//File saveFile = new File(uploadFolder, multipartFile.getOriginalFilename());
					
					//multipartFile.transferTo(saveFile);
					MimeBodyPart mimeAttachPart = new MimeBodyPart();
					
					//DataSource source = new FileDataSource(uploadFolder + "\\" + multipartFile.getOriginalFilename());
					DataSource source = new ByteArrayDataSource(multipartFile.getBytes(), multipartFile.getContentType());
					
					mimeAttachPart.setDataHandler(new DataHandler(source));
					try {
						mimeAttachPart.setFileName(MimeUtility.encodeText(multipartFile.getOriginalFilename()));
					} catch (Exception e) {
						log.error(e.getMessage());
					}
					multipart.addBodyPart(mimeAttachPart);
				}
			}

			msg.setContent(multipart);
			 log.info("sendermail->" + mail.getSender_mail());
			Transport.send(msg);
//			t.connect();
//			t.sendMessage(msg, msg.getAllRecipients());
			String uploadFolder = session.getServletContext().getRealPath("/upload/");
			mail.setRead_chk(0L);
			mail.setDelete_chk(0L);
			mail.setMail_date(new Date());
			mailRepository.sendEmail(mail);
			Long i = 1L;
			if(!mail.getUploadFile()[0].isEmpty()) {
				for(MultipartFile multipartFile : mail.getUploadFile()) {
					MailAttach mailAttach = new MailAttach();
					mailAttach.setMail_attach_num(i);
					mailAttach.setMail(mail);
					mailAttach.setMail_attach_real_name(multipartFile.getOriginalFilename());
					mailAttach.setMail_attach_save_name(uploadFile(multipartFile.getOriginalFilename(),multipartFile.getBytes(),uploadFolder));
					mailAttach.setMail_attach_save_path(uploadFolder);
					mailRepository.saveAttach(mailAttach);
					i++;
				}
			}
			result = 1;
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}finally {
//			if(t!=null) {
//				try {
//					t.close();
//				} catch (MessagingException e) {
//					// TODO Auto-generated catch block
//					e.printStackTrace();
//				}
//			}
		}
		
		return result;
	}

	@Override
	public Long receiveMail(HttpSession session) throws MessagingException, IOException {
		EmpForSearch emp = (EmpForSearch) session.getAttribute("empForSearch");
		Long result = 0L;
		if(emp.getPermit_status() == 0L) {
			log.info("메일 아직 없음");
			Long permit_check = mailRepository.permitCheck(emp.getEmp_num());
			if(permit_check == 1L) {
				log.info("메일 생성 됐음");
				emp.setPermit_status(permit_check);
			}
		}
		if(emp.getPermit_status() == 1L) {
			String dev_mail_id =emp.getEmp_id()+"@devware.shop";
			String dev_mail_pw =emp.getEmp_passwd();
			log.info("MailController2 receiveMail start..");
			Properties props = new Properties();
			props.put("mail.store.protocol", "pop3");
			props.put("mail.pop3.host", "devware.shop");
			props.put("mail.pop3.port", "110");
	//		props.put("mail.pop3.starttls.enable", "true");
	//		props.put("mail.pop3s.ssl.protocols", "TLSv1.2");
	//		props.put("mail.pop3s.ssl.trust", "devware.shop");
	
			Session mail_session = Session.getDefaultInstance(props);
			
			Store store = mail_session.getStore("pop3");
			store.connect("devware.shop",dev_mail_id,"dev2255!");
			log.info("MailController2 receiveMail connect start..");
			
			Folder mailFolder = store.getFolder("INBOX");
			mailFolder.open(Folder.READ_WRITE);
			
			log.info("MailController2 receiveMail folderOpen start..");
			
			Message[] messages = mailFolder.getMessages();
			ArrayList<Mail> mailList = new ArrayList<Mail>();
			for(int i = 0 ; i < messages.length ; i ++) {
				Mail mail = new Mail();
				Message message = messages[i];
				message.setFlag(Flags.Flag.DELETED, true);
				log.info("mail title" + message.getSubject());
	
				
				readMailHeader(message, mail);
				mail.setRead_chk(0L);
				mail.setDelete_chk(0L);
				mail.setMail_date(new Date(message.getSentDate().getTime()));
				mailRepository.sendEmail(mail);
				
				String uploadFolder = session.getServletContext().getRealPath("/upload/");
				
				
				if(message.getContent() instanceof MimeMultipart) {
					MimeMultipart mimeMultipart = (MimeMultipart) message.getContent();
					System.out.println(mimeMultipart.getCount());
					for(int j = 0 ; j < mimeMultipart.getCount() ; j ++) {
						log.info("contentType->" + mimeMultipart.getBodyPart(j).getContentType());
						log.info("disposition->" + mimeMultipart.getBodyPart(j).getDisposition());
						
						if(mimeMultipart.getBodyPart(j).getDisposition()!=null && mimeMultipart.getBodyPart(j).getDisposition().equals("attachment")==true) {
							log.info("multipart has attachment FileName->" + mimeMultipart.getBodyPart(j).getFileName());
							InputStream inputStream = mimeMultipart.getBodyPart(j).getInputStream();
							MailAttach mailAttach= new MailAttach();
							mailAttach.setMail_attach_num((long)j);
							mailAttach.setMail(mail);
							mailAttach.setMail_attach_real_name(mimeMultipart.getBodyPart(j).getFileName());
							mailAttach.setMail_attach_save_name(uploadFile(mimeMultipart.getBodyPart(j).getFileName(),IOUtils.toByteArray(inputStream), uploadFolder));
							mailAttach.setMail_attach_save_path(uploadFolder);
							//uploadFile(mimeMultipart.getBodyPart(j).getFileName(),inputStream.readAllBytes(), uploadFolder);
							mailRepository.saveAttach(mailAttach);
							if(inputStream != null) {
								inputStream.close();
							}
						}else if(mimeMultipart.getBodyPart(j).getDisposition()!=null && mimeMultipart.getBodyPart(j).getDisposition().equals("inline")==true) {
							log.info("content is multipart");
						}	
						else {
								System.out.println("message is multipart but not have attach");
							if(mimeMultipart.getBodyPart(j).getContent() instanceof Multipart) {
								System.out.println("bodypart instance of multipart");
							}else{
								mail.setMail_content((String) mimeMultipart.getBodyPart(j).getContent());
								System.out.println("content->" + (String) mimeMultipart.getBodyPart(j).getContent());
							}
						}
					}
				}else {
					System.out.println("message is not multipart");
	//				if(message.getContent() instanceof Multipart) {
	//					System.out.println("bodypart instance of multipart");
	//				}else{
					mail.setMail_content((String) message.getContent());
					System.out.println("content->" + (String) message.getContent());
					//}
					
				}
				
				
			}
			mailFolder.close(true);
			store.close();
			result=  mailRepository.countNotReadMail(emp.getEmp_id()+"@devware.shop");
		}
		return result;
	}
	
	
	private void readMailHeader(Message message, Mail mail) throws UnsupportedEncodingException, MessagingException {
			Address[] address;

			// FROM
			if ((address = message.getFrom()) != null) {
				for (int j = 0; j < address.length; j++) {
					String sender = MimeUtility.decodeText(address[j].toString());
					System.out.println("FROM: " + sender);
					
					String[] arr = sender.split("<|>");
					if (arr.length > 1) {
						mail.setSender_mail(arr[1]);
						mail.setSender_name(arr[0]);
					} else {
						mail.setSender_mail(arr[0]);
						mail.setSender_name(arr[0]);
					}
				}
			}

			// TO
			if ((address = message.getRecipients(Message.RecipientType.TO)) != null) {
				for (int j = 0; j < address.length; j++) {
					String receiver = MimeUtility.decodeText(address[j].toString());
					System.out.println("TO: " + receiver);
					String[] arr = receiver.split(" <|>");
					if (arr.length > 1) {
						mail.setReceiver_mail(arr[1]);
						mail.setReceiver_name(arr[0]);
					} else {
						mail.setReceiver_mail(arr[0]);
						mail.setReceiver_name(arr[0]);
					}					
				}
			}

			// SUBJECT
			if (message.getSubject() != null) {
				System.out.println("SUBJECT: " + message.getSubject());
				mail.setMail_title(message.getSubject());
			}
	}
	

	private String uploadFile(String originalName, byte[] fileData, String uploadPath) throws IOException {
		
		// universally unique identifier (UUID) 국제적으로 유일한 구별자
		UUID uid = UUID.randomUUID();
		// requestPath = requestPath + "/resources/image";
		System.out.println("uploadPath->" + uploadPath);
		//Directory 생성
		File fileDirectory = new File(uploadPath);
		if(!fileDirectory.exists()) {
			//신규 폴더(Directory) 생성
			fileDirectory.mkdirs();
			System.out.println("업로드용 폴더 생성 : " + uploadPath);
		}
		
		String savedName = uid.toString() + "_" + originalName;
		log.info("savedName : " + savedName);
		File target = new File(uploadPath, savedName);
		//File target = new File(requestPath, savedName);
		//File Upload ---> uploadPath / UUID+_+originalName
		FileCopyUtils.copy(fileData, target); // org.springframework.util.FileCopyUtils
		log.info("saveSuccess");
		return savedName;
	}

	@Override
	public Long countMail(String MailAccount, int mailType, String search, String keyword) {
		log.info("MailServiceImpl countMail start..");
		Long result = 0L;
		switch (mailType) {
		case 0:
			result = mailRepository.countSendMail(MailAccount, search, keyword);
			break;
		case 1:
			result = mailRepository.countReceiveMail(MailAccount, search, keyword);
			break;
		case 2:
			result = mailRepository.countImportantMail(MailAccount, search, keyword);
			break;
		case 3:
			result = mailRepository.countDeletedMail(MailAccount, search, keyword);
			break;
		}
		return result;
	}

	@Override
	public List<Mail> listMail(String MailAccount, int empno, int start, int end, int mailType, String search, String keyword) {
		log.info("MailServiceImpl listMail start..");
		List<Mail> listMail = null;
		switch (mailType) {
		case 0:
			listMail = mailRepository.listSendMail(MailAccount,empno, start,end, search, keyword);
			break;
		case 1:
			listMail = mailRepository.listReceiveMail(MailAccount,empno, start,end, search, keyword);
			break;
		case 2:
			listMail = mailRepository.listImportantMail(MailAccount,empno, start,end, search, keyword);
			break;
		case 3:
			listMail = mailRepository.listDeletedMail(MailAccount, start,end, search, keyword);
			break;
		}
		return listMail;
	}

//	@Override
//	public Mail mailDetail(Mail mail) {
//		Mail mailDetail = mailRepository.mailDetail(mail);
//		log.info("mail->" + mailDetail);
//		return mailDetail;
//	}

	@Override
	public void readMail(Long mail_num) {
		log.info("readMail start...");
		mailRepository.readMail(mail_num);
	}

	@Override
	public void deleteNotRead(String mailAccount) {
		log.info("deleteNotRead start...");
		mailRepository.deleteNotRead(mailAccount);
	}

	@Override
	public void deleteMail(List<String> deleteArray, String uploadFolder, int mailType) {
		log.info("deleteMail start...");
		try {
			if(mailType==3) {
				List<String> deleteFileNames = mailRepository.premanDelete(deleteArray);
				for(String deleteFileName : deleteFileNames) {
					upFileDelete(uploadFolder + deleteFileName);
				}
			}else {
				mailRepository.deleteMail(deleteArray);
			}
		} catch (Exception e) {
			log.info(e.getMessage());
		}
		log.info("deleteMail after...");
	}

	@Override
	public void restore_mail(List<String> deleteArray) {
		log.info("restore_mail start...");
		mailRepository.restore_mail(deleteArray);
		log.info("restore_mail after...");
	}

	@Override
	public void mailImportant(int empno, Long mailNumLong, String isImportant) {
		log.info("mailImportant start...");
		mailRepository.mailImportant(empno, mailNumLong, isImportant);
		log.info("mailImportant after...");
	}

	@Override
	public void deleteDetailMail(String uploadFolder, Long mailNum, int mailType) {
		log.info("deleteDetailMail start...");
		try {
			if(mailType==3) {
				List<String> deleteFileNames = mailRepository.premanDetailDelete(mailNum);
				for(String deleteFileName : deleteFileNames) {
					upFileDelete(uploadFolder + deleteFileName);
				}
			}else {
				mailRepository.deleteDetailMail(mailNum);
			}
		} catch (Exception e) {
			log.info(e.getMessage());
		}
		log.info("deleteDetailMail after...");
	}

	@Override
	public void restoreDetailMail(Long mailNum) {
		log.info("restoreDetailMail start...");
		mailRepository.restoreDetailMail(mailNum);
		log.info("restoreDetailMail after...");
	}

	
	@Override
	public int mailCreateDone(int emp_num) {
		int result = mailRepository.mailCreateDone(emp_num);
		return result;
	}
	
	@Override
	public Long permitCheck(int emp_num) {
		log.info("permitCheck start..");
		Long permit_check = mailRepository.permitCheck(emp_num);
		return permit_check;
	}
	
	@Override
	public void saveAttach(HttpServletRequest request, HttpServletResponse response, String saveName, String realName,
			String uploadFolder) {
		File file = null;
		InputStream is = null;
		OutputStream os = null;
		
		String mimetype = "application/x-msdownload";
		response.setContentType(mimetype);
		
		try {
			
			setDisposition(realName, request, response);
			   
			System.out.println(uploadFolder + saveName);
			file = new File(uploadFolder + saveName);
			is = new FileInputStream(file);
			os = response.getOutputStream();
			
			byte b[] = new byte[(int)file.length()];
			int length=0;
			
			while((length = is.read(b))>0) {
				os.write(b,0,length);
			}
			is.close();
			os.close();
		} catch (Exception e) {
			log.info(e.getMessage());
		}
	}
	
	void setDisposition(String filename, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
			    String browser = getBrowser(request);
			    String dispositionPrefix = "attachment; filename=";
			    String encodedFilename = null;
			 
			    if (browser.equals("MSIE")) {
			        encodedFilename = URLEncoder.encode(filename, "UTF-8").replaceAll(
			        "\\+", "%20");
			    } else if (browser.equals("Firefox")) {
			        encodedFilename = "\""
			        + new String(filename.getBytes("UTF-8"), "8859_1") + "\"";
			    } else if (browser.equals("Opera")) {
			        encodedFilename = "\""
			        + new String(filename.getBytes("UTF-8"), "8859_1") + "\"";
			    } else if (browser.equals("Chrome")) {
			        StringBuffer sb = new StringBuffer();
			        for (int i = 0; i < filename.length(); i++) {
			        char c = filename.charAt(i);
			        if (c > '~') {
			            sb.append(URLEncoder.encode("" + c, "UTF-8"));
			        } else {
			            sb.append(c);
			        }
			    }
			    encodedFilename = sb.toString();
			    } else {
			        throw new IOException("Not supported browser");
			    }
			 
			    response.setHeader("Content-Disposition", dispositionPrefix
			    + encodedFilename);
			 
			    if ("Opera".equals(browser)) {
			        response.setContentType("application/octet-stream;charset=UTF-8");
			    }
			 
		}
	
		private String getBrowser(HttpServletRequest request) {
	      String header = request.getHeader("User-Agent");
	      if (header.indexOf("MSIE") > -1) {
	           return "MSIE";
	      } else if (header.indexOf("Chrome") > -1) {
	           return "Chrome";
	      } else if (header.indexOf("Opera") > -1) {
	           return "Opera";
	      } else if (header.indexOf("Firefox") > -1) {
	           return "Firefox";
	      } else if (header.indexOf("Mozilla") > -1) {
	           if (header.indexOf("Firefox") > -1) {
	                return "Firefox";
	           }else{
	                return "MSIE";
	           }
	      }
	      return "MSIE";
	 }
	
		
	private void upFileDelete(String deleteFileName) throws Exception{
		log.info("upFileDelete result->" + deleteFileName);
		File file = new File(deleteFileName);
		if(file.exists()) {
			if(file.delete()) {
				System.out.println("파일삭제 성공");
			}else {
				System.out.println("파일삭제 실패");
			}
		}else {
			System.out.println("파일이 존재하지 않습니다");
		}
	}

	

	


}



//class MyAuthentication extends Authenticator {
//
//    PasswordAuthentication pa;
//
//    public MyAuthentication(String mailId, String mailPass) {
//        pa = new PasswordAuthentication(mailId, mailPass);  
//    }
//
//    public PasswordAuthentication getPasswordAuthentication() {
//        return pa;
//    }
//}
