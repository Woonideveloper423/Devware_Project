package com.oracle.devwareProject.controller.jehwan;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.oracle.devwareProject.dto.jehwan.ChatMessageProc;
import com.oracle.devwareProject.dto.jehwan.ChatRoomDto;
import com.oracle.devwareProject.dto.jehwan.EmpDtoVO;
import com.oracle.devwareProject.service.jehwan.ChatService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequiredArgsConstructor
@Controller
public class ChatController {
	
private final ChatService chatService;
	
	@RequestMapping(value = "/chat/chatRoomList")
	public String chatRoomList(HttpServletRequest request, int empno, String empName, Model model) {
		log.info("chatRoomList start..");
		log.info("empno->" + empno);
		log.info("empName->" + empName);
		HttpSession session = request.getSession();
		session.setAttribute("empno", empno);
		session.setAttribute("empName", empName);
		model.addAttribute("mailType", 0);
		return "/mail/MailList";
	}
	
	@ResponseBody
	@RequestMapping(value = "/chat/getMsgCnt")
	public int getMsgCnt(HttpServletRequest request) {
		HttpSession session = request.getSession();
		String empno =  session.getAttribute("empno").toString();
		System.out.println("empno->" + empno);
		int msgCnt = chatService.getMsgCnt(empno);
		
		return msgCnt;
	}
	
	@RequestMapping(value = "/chat/getRoomList")
	@ResponseBody
	public List<ChatRoomDto> getRoomList(HttpServletRequest request){
		HttpSession session = request.getSession();
		String empno =  session.getAttribute("empno").toString();
		log.info("getRoomList start empno ->" + empno);
		List<ChatRoomDto> chatRoomDtos = chatService.getRoomList(empno);
		return chatRoomDtos;
	}
	
	@RequestMapping(value = "/chat/roomDetail")
	public String roomDetail(String roomId,String roomName, Model model) {
		log.info("roomDetail start roomId ->" + roomId);
		model.addAttribute("roomName", roomName);
		model.addAttribute("roomId", roomId);
		return "/chat/roomDetail";
	}
	
	@ResponseBody
	@RequestMapping(value = "/chat/detailRoom")
	public ChatMessageProc detailRoom(HttpServletRequest request, ChatMessageProc chatMessageProc) {
		HttpSession session = request.getSession();
		chatMessageProc.setP_emp_num(Integer.parseInt(session.getAttribute("empno").toString()));
		log.info("detailRoom start chatMessageDto.emp_num ->" + chatMessageProc.getP_emp_num());
		log.info("detailRoom start chatMessageDto.room_num ->" + chatMessageProc.getP_room_num());
		chatService.detailRoom(chatMessageProc);
		log.info("detailRoom start chatMessageDto.size" + chatMessageProc.getReadMsg().size());
		return chatMessageProc;
	}
	
	@ResponseBody
	@RequestMapping(value = "/chat/showEmpList")
	public EmpDtoVO showEmpList(HttpServletRequest request, EmpDtoVO empDtoVo) {
		HttpSession session = request.getSession();
		empDtoVo.setEmp_num(Integer.parseInt(session.getAttribute("empno").toString()));
		log.info("detailRoom start empno ->" + empDtoVo.getEmp_num());
		log.info("detailRoom start roomId ->" + empDtoVo.getRoom_num());
		log.info("detailRoom start type ->" + empDtoVo.getType());
		chatService.getEmpList(empDtoVo);
		
		return empDtoVo;
	}
	
	@ResponseBody
	@RequestMapping(value = "/chat/leaveRoomLook")
	public String leaveRoomLook(HttpServletRequest request, String roomId) {
		HttpSession session = request.getSession();
		String empno = session.getAttribute("empno").toString();
		log.info("leaveRoomLook start... empno->" + empno);
		log.info("leaveRoomLook start... roomId->" + roomId);
		chatService.leaveRoomLook(empno, roomId);
		return "나감";
	}
	
	@ResponseBody
	@RequestMapping(value = "/chat/uploadFile")
	public String uploadFile(HttpServletRequest request ,MultipartFile upLoadFile) {
		String uploadPath = request.getSession().getServletContext().getRealPath("/upload/");
		
		
		System.out.println("uploadForm POST Start");
		log.info("originalName: " + upLoadFile.getOriginalFilename());
	    log.info("size: " + upLoadFile.getSize());
	    log.info("contentType: " + upLoadFile.getContentType());
	    log.info("uploadPath: " + uploadPath);
	    String savedName = "";
		try {
			savedName = uploadFile(upLoadFile.getOriginalFilename(), upLoadFile.getBytes(), uploadPath);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
        // Service --> DB CRUD
	    
	    log.info("Return savedName: " + savedName);
		
		return savedName;
	}
	
	 private String uploadFile(String originalName, byte[] fileData , String uploadPath) 
			  throws Exception {
		  // universally unique identifier (UUID).
	     UUID uid = UUID.randomUUID();
	   // requestPath = requestPath + "/resources/image";
	    System.out.println("uploadPath->"+uploadPath);
	    // Directory 생성 
		File fileDirectory = new File(uploadPath);
		if (!fileDirectory.exists()) {
			// 신규 폴더(Directory) 생성 
			fileDirectory.mkdirs();
			System.out.println("업로드용 폴더 생성 : " + uploadPath);
		}

	    String savedName = uid.toString() + "_" + originalName;
	    log.info("savedName: " + savedName);
	    File target = new File(uploadPath, savedName);
//	    File target = new File(requestPath, savedName);
	    // File UpLoad   --->  uploadPath / UUID+_+originalName
	    FileCopyUtils.copy(fileData, target);   // org.springframework.util.FileCopyUtils
	    
	    return savedName;
	  }	
	
	@RequestMapping(value = "/chat/createRoom")
	public String createRoom(String[] chatMember,String roomName, Model model) {

		log.info("chatMember.length->" + chatMember.length);
		
		model.addAttribute("chatMember", chatMember);
		model.addAttribute("roomName", roomName);
		return "/chat/roomDetail";
		
	}
	
	
	
}
