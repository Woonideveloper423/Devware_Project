package com.oracle.devwareProject.controller.jehwan;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.List;

import javax.mail.MessagingException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.oracle.devwareProject.domain.EmpForSearch;
import com.oracle.devwareProject.domain.jehwan.Mail;
import com.oracle.devwareProject.domain.jehwan.MailAccount;
import com.oracle.devwareProject.domain.jehwan.MailAttach;
import com.oracle.devwareProject.domain.jehwan.MailAttachVO;
import com.oracle.devwareProject.domain.jehwan.MailListVO;
import com.oracle.devwareProject.service.jehwan.MailService;
import com.oracle.devwareProject.service.jehwan.Paging;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequiredArgsConstructor
public class MailController {
	
		private final MailService mailservice;
		
		@RequestMapping(value = "/mail/mailWriteForm")
		public String mailWriteForm(String replyMail,String replyName, Model model) {
			log.info("mailWriteForm start..");
			log.info("replyMail is" + replyMail);
			
			model.addAttribute("replyMail", replyMail);
			model.addAttribute("replyName", replyName);
			return "/mail/user/mailWriteForm";
		}
		
		@PostMapping(value = "/mail/writeMail")
		public String mailTest(HttpSession session, Mail mail, Model model) throws UnsupportedEncodingException, MessagingException {
			
			
			log.info("mailTest mailSend Start...");
			int mailSendResult = mailservice.sendEmail(session, mail);
			log.info("mailSendResult -> " + mailSendResult);
			model.addAttribute("mailType",0);
			return "/mail/user/MailList";
		}
		
		@ResponseBody
		@RequestMapping(value = "/mail/mailCreateDone")
		public String mailCreateDone(HttpSession session, int emp_num) {
			log.info("MailController mailCreateDone start.. emp_num->" + emp_num);
			int Createresult = mailservice.mailCreateDone(emp_num);
			if(Createresult != 0) {
				return "success";
			}else {
				return "fail";
			}
		}
		
		@ResponseBody
		@RequestMapping(value = "/mail/countMail")
		public Long countMail(HttpSession session) throws MessagingException, IOException {
			log.info("MailController2 receiveMessage start..");
			Long result =  mailservice.receiveMail(session);
			
			return result;
		}
		
		
//		@GetMapping(value="/mail/receiveMessage")
//		public String receiveMessage(HttpServletRequest request, Model model) throws MessagingException, IOException {
//			log.info("MailController2 receiveMessage start..");
//			Long mailReceiveResult = mailservice.receiveMail(request, null);
//			model.addAttribute("mailType",1);
//			return "/mail/user/MailList";
//		}

		@GetMapping(value = "/mail/MailList")
		public String sendMailList(int listType, Model model) {
			log.info("sendMailList Start listType->"+ listType);
			
			model.addAttribute("mailType",listType);
			return "/mail/user/MailList";
		}
		
//		@GetMapping(value = "/mail/receiveMailList")
//		public String receiveMailList(Model model) {
//			log.info("receiveMailList Start...");
//			model.addAttribute("mailType",1);
//			return "/mail/user/MailList";
//		}
//
//		@GetMapping(value = "/mail/importantMailList")
//		public String importantMailList(Model model) {
//			log.info("importantMailList Start...");
//			model.addAttribute("mailType",2);
//			return "/mail/user/MailList";
//		}
//		
//		@GetMapping(value = "/mail/deletedMailList")
//		public String deletedMailList(Model model) {
//			log.info("deletedMailList Start...");
//			model.addAttribute("mailType",3);
//			return "/mail/user/MailList";
//		}
		
		@ResponseBody
		@RequestMapping("/mail/viewMailList")
		public MailListVO viewMailList(String currentPage, String search, String keyword, int mailType) {
			MailListVO mailListVO = new MailListVO();
			Long totMail = mailservice.countMail("jehwan@devware.shop", mailType, search, keyword);
			
			log.info("totMail->" + totMail);
			Paging page = new Paging(totMail, currentPage);
			log.info("page.getStart()" + page.getStart());
			log.info("page.getStart()" + page.getEnd());
			int start = page.getStart();
			int end = page.getEnd();
			int empno = 1;
			List<Mail> mailList = mailservice.listMail("jehwan@devware.shop",empno , page.getStart(), page.getEnd(), mailType, search, keyword);
			
			log.info("mailList.size()->" + mailList.size());
			
//			List<List<MailAttachVO>> resultMailAttaches = new ArrayList<List<MailAttachVO>>();
//			for(int i = 0 ; i < mailList.size() ; i ++) {
//				List<MailAttachVO> mailAttaches = new ArrayList<MailAttachVO>();
//				for(int j = 0 ; j < mailList.get(i).getMailAttachs().size() ; j++ ) {
//					MailAttachVO mailAttachVO = new MailAttachVO();
//					mailAttachVO.setMail_num(mailList.get(i).getMail_num());
//					mailAttachVO.setMail_attach_num(mailList.get(i).getMailAttachs().get(j).getMail_attach_num());
//					mailAttachVO.setMail_attach_real_name(mailList.get(i).getMailAttachs().get(j).getMail_attach_real_name());
//					mailAttachVO.setMail_attach_save_name(mailList.get(i).getMailAttachs().get(j).getMail_attach_save_name());
//					mailAttachVO.setMail_attach_save_path(mailList.get(i).getMailAttachs().get(j).getMail_attach_save_path());
//					mailAttachVO.setMail_attach_type(mailList.get(i).getMailAttachs().get(j).getMail_attach_type());
//					mailAttaches.add(mailAttachVO);
//				}
//				resultMailAttaches.add(mailAttaches);
//			}
			List<List<MailAttach>> resultMailAttaches = new ArrayList<List<MailAttach>>();
			for(int i = 0 ; i < mailList.size() ; i ++) {
				resultMailAttaches.add(mailList.get(i).getMailAttachs());
			}
			mailListVO.setMailAttaches(resultMailAttaches);
			mailListVO.setMailList(mailList);
			mailListVO.setStart(start);
			mailListVO.setEnd(end);
			mailListVO.setKeyword(keyword);
			mailListVO.setSearch(search);
			mailListVO.setPageNum(currentPage);
			mailListVO.setPaging(page);
			mailListVO.setMailType(mailType);
			return mailListVO;
		}
		
		@PostMapping(value = "/mail/mailDetail")
		public String mailDetail(Mail mail, int mailType,
								String[] mail_attach_save_path,
								String[] mail_attach_save_name,
								String[] mail_attach_real_name,
								Model model) {
			
			mailservice.readMail(mail.getMail_num());
			
			System.out.println("MailController2 mailDetail start..");
			log.info("mail ->" + mail.getMail_content());
			log.info("mail ->" + mail.getMail_title());
			log.info("mail ->" + mail.getReceiver_mail());
			log.info("mail ->" + mail.getSender_mail());
			if(mail_attach_save_path != null) {
				log.info("mail_attach_save_path ->" + mail_attach_save_path.length);
				log.info("mail_attach_save_name ->" + mail_attach_save_name.length);
				log.info("mail_attach_real_name ->" + mail_attach_real_name.length);

				log.info("mailType->" + mailType);
				List<MailAttachVO> mailAttachVOs = new ArrayList<MailAttachVO>();
				for(int i = 0  ; i < mail_attach_save_name.length ; i++) {
					MailAttachVO mailAttachVO = new MailAttachVO();
					mailAttachVO.setMail_attach_real_name(mail_attach_real_name[i]);
					mailAttachVO.setMail_attach_save_name(mail_attach_save_name[i]);
					mailAttachVO.setMail_attach_save_path(mail_attach_save_path[i]);
					log.info(mail_attach_real_name[i]);
					log.info(mail_attach_save_name[i]);
					log.info(mail_attach_save_path[i]);
					mailAttachVOs.add(mailAttachVO);
				}
				model.addAttribute("mailAttaches", mailAttachVOs);
			}
			model.addAttribute("mailType", mailType);
			model.addAttribute("mailDetail", mail);
			
//			Mail mailDetail = mailservice.mailDetail(mail);
//
//			log.info("mail ->" + mailDetail);
//			
//			model.addAttribute("mailDetail", mailDetail);
//			
			return "/mail/user/mailDetail";
		}
		
		@RequestMapping(value = "/mail/deleteNotRead")
		public String deleteNotRead(String currentPage, String search, String keyword, int mailType, Model model) {
			log.info("mailType->" + mailType);
			String mailAccount = "jehwan@devware.shop";
			mailservice.deleteNotRead(mailAccount);
			
			
			model.addAttribute("currentPage", currentPage);
			model.addAttribute("search", search);
			model.addAttribute("keyword", keyword);
			model.addAttribute("mailType", mailType);
			return "forward:/mail/viewMailList";
		}
		
		@RequestMapping(value = "/mail/deleteMail")
		public String deleteMail(@RequestParam(value="deleteArray[]",required = false) List<String>  deleteArray, 
												HttpServletRequest request, 
												String currentPage, 
												String search, 
												String keyword,
												int mailType, 
												Model model) {
			log.info("deleteArray->" + deleteArray.size());
			
			log.info("mailType->" + mailType);
			String uploadFolder = request.getSession().getServletContext().getRealPath("/upload/");
			
			mailservice.deleteMail(deleteArray,uploadFolder, mailType);
			log.info("test-><-");
			model.addAttribute("currentPage", currentPage);
			model.addAttribute("search", search);
			model.addAttribute("keyword", keyword);
			model.addAttribute("mailType", mailType);
			return "forward:/mail/viewMailList";
		}
		
		@RequestMapping(value = "/mail/restore_mail")
		public String restore_mail(@RequestParam(value="deleteArray[]",required = false) List<String>  deleteArray, String currentPage, String search, String keyword,int mailType, Model model) {
			mailservice.restore_mail(deleteArray);
			log.info("test-><-");
			model.addAttribute("currentPage", currentPage);
			model.addAttribute("search", search);
			model.addAttribute("keyword", keyword);
			model.addAttribute("mailType", mailType);
			return "forward:/mail/viewMailList";
		}
		
		@RequestMapping(value = "/mail/mailImportant")
		public String mailImportant(String currentPage, String search, String keyword, String mailNum, String isImportant, int mailType, Model model) {
			log.info("mailImportant mailType->" + mailType);
			int empno = 1;
			log.info("mailImportant mailNum->" + mailNum);
			Long mailNumLong = (long) Integer.parseInt(mailNum);
			mailservice.mailImportant(empno, mailNumLong, isImportant);
			
			
			model.addAttribute("currentPage", currentPage);
			model.addAttribute("search", search);
			model.addAttribute("keyword", keyword);
			model.addAttribute("mailType", mailType);
			return "forward:/mail/viewMailList";
		}
		
//		@ResponseBody
//		@RequestMapping(value = "mailImportant")
//		public String mailImportant(String mailNum, String isImportant) {
//			Long empno = 1L;
//			log.info("mailImportant mailNum->" + mailNum);
//			Long mailNumLong = (long) Integer.parseInt(mailNum);
//			mailservice.mailImportant(empno, mailNumLong, isImportant);
//			
//			
//			return "success";
//		}
		
		@RequestMapping(value = "/mail/deleteDetailMail")
		public String deleteDetailMail(HttpServletRequest request, Long mailNum, int mailType, Model model) {

			String uploadFolder = request.getSession().getServletContext().getRealPath("/upload/");
			
			mailservice.deleteDetailMail(uploadFolder, mailNum, mailType);
			
			model.addAttribute("mailType", mailType);
			return "/mail/user/MailList";
		}
		
		@RequestMapping(value = "/mail/restoreDetailMail")
		public String restoreDetailMail(Long mailNum, Model model) {
			
			String mailAccount = "jehwan@devware.shop";
			mailservice.restoreDetailMail(mailNum);
			
			model.addAttribute("mailType", 3);
			return "/mail/user/MailList";
		}
		

		@RequestMapping(value = "/saveAttach")
		public void saveAttach(HttpServletRequest request, HttpServletResponse response, String saveName, String realName) {
			log.info("saveAttach start...");
			String uploadFolder = request.getSession().getServletContext().getRealPath("/upload/");
			
			mailservice.saveAttach(request,response,saveName,realName,uploadFolder);

		}
		
		
		
	}
	