package com.oracle.devwareProject.controller.KiWoSu;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Optional;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.oracle.devwareProject.dto.KiWoSu.Commute;
import com.oracle.devwareProject.service.KiWoSu.ComService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;



@Controller
@RequiredArgsConstructor
@Slf4j
public class CommuteController {
	//JPA 로 만들어보기
	
	private final ComService cs;
	
	
	
	//현재 시간 맵핑
	@RequestMapping("/current_time1")
	public ModelAndView current_time1 () {
		ModelAndView mav = new ModelAndView("json/singleValueString");		
		Calendar cal = Calendar.getInstance();
		SimpleDateFormat sdf = new SimpleDateFormat("HH : mm : ss");
		String time = sdf.format(cal.getTime());
		mav.addObject("value", time);		
		return mav;
	}
	
	//리스트 맵핑
	@RequestMapping("/commute")
	public String listCommute(Model model, Commute commute) {
		List<Commute> listCommute = cs.ListCommute(commute);
		System.out.println("CommuteController listCommute start....");
		model.addAttribute("listCommute", listCommute);
		return "/commute/user/commute";
		
	}
	
	
	@PostMapping("/startTime")
	public String startTime(Commute commute, String msg, String com_start, String com_end, Date com_date, int emp_num ) {
		
		System.out.println("CommuteController startTime Start");
		System.out.println("msg -> " + msg);
		System.out.println("com_start -> " + com_start);
		System.out.println("commute -> " + commute.getCom_start());
		System.out.println("com_end -> " + com_end);
		System.out.println("commute -> " + commute.getCom_end());
		System.out.println("com_date -> " + com_date);
		System.out.println("commute -> " + commute.getCom_date());
		System.out.println("emp_num -> " + emp_num);
		System.out.println("commute -> " + commute.getEmp_num());
		cs.saveTime(commute); 
		
		
		return "/commute/user/redirect:commute";
	}
	
//	@ResponseBody
//	@PostMapping("/findTime")
//	public String findTime(String com_num , Model model, String com_end) {
//		System.out.println("CommuteController findTime Start");
//		System.out.println("com_num -> " + com_num);
//		Commute commute = cs.findTime(com_num);
//		commute.setCom_end(com_end);
//		commute = cs.updateTime(commute);
//		model.addAttribute("commute", commute);
//
//		return com_end;
//	}
	// KTG
	@ResponseBody
	@PostMapping("/findTime")
	public Commute findTime(String com_num , Model model, String com_end, Commute commute) {
		System.out.println("CommuteController findTime Start");
		System.out.println("com_num -> " + com_num);
		commute.setCom_num(com_num);
		commute.setCom_end(com_end);
		commute = cs.updateTime(commute);
		// 전제 -> COM_NUM 유일하다는 전제
		// 출근 / 퇴근 / 근무 Setting
		commute = cs.selectTime(commute.getCom_num());
		
		model.addAttribute("commute", commute);
		System.out.println("테스트 결과->"+commute);
		return commute;
	}
	
	
	
	
	
	//실시간 시간
	@RequestMapping("/current_time")
	public ModelAndView current_time () {
		System.out.println("current_time start");
		ModelAndView mav = new ModelAndView("json/singleValueString");		
		Calendar cal = Calendar.getInstance();
		SimpleDateFormat sdf = new SimpleDateFormat("HH : mm : ss");
		String time = sdf.format(cal.getTime());
		mav.addObject("value", time);		
		return mav;
	}
	
	
	
	////////////////////////////////////테스트 컨트롤 
	//시작시 view 표기
	@ResponseBody
	@RequestMapping(value="/commuting/view", method=RequestMethod.POST, produces = "application/text; charset=utf8")
	public String view (@RequestParam(value="year") int year, @RequestParam(value="month") int month, @RequestParam(value="member_id", required=false) String member_id,  HttpServletRequest req) {
		System.out.println("ModelAndView a view");
		System.out.println("year"+year);
		System.out.println("month"+month);
		HttpSession session = req.getSession();
//		Member m = (Member) session.getAttribute("member");

		String date1 = null, date2 = null;
		if(month < 10) {
		    date1 = year + "-0" +    month   + "-01";
			date2 = year + "-0" + (month+1)  + "-01";
			if(month == 9){
				date2 = year + "-" + (month+1)  + "-01";
			}
		}else if(month < 12) {
			date1 = year +"-"+ month+"-01";
			date2 = year +"-"+ (month+1) +"-01";
		}else if(month >= 12) {
			date1 = year +"-"+ month+"-01";
			date2 = (year+1) + "-01-01";
		}
		
		
//		System.out.println("!!!!!!!!!!!!!!!!!!!!!Member_id : "+member_id);
		HashMap<String, Object> map = new HashMap<String, Object>();
//		if(member_id != null) {
//			map.put("member_id",member_id);
//		}else {
//			map.put("member_id",m.getMember_id());
//		}
		map.put("date1",date1);
		map.put("date2",date2);
		
		System.out.println(map.get("member_id"));
		
		
		SimpleDateFormat sdf = new SimpleDateFormat("ddHH:mm:ss");
		System.out.println("befpre===============================================");
//		ArrayList<Commute> list = cs.getValue(map);
		System.out.println("after===============================================");
//		System.out.println(list);
		System.out.println("===============================================");
		JSONArray arr = new JSONArray();
//		for(Commute comm : list) {
//			JSONObject obj = new JSONObject();
//			obj.put("commuting_id", comm.getCom_num());
//			obj.put("commuting_member_id", comm.getEmp_num());
//			try {
//				obj.put("commuting_arrive", sdf.format(comm.getCom_start()));
//			} catch (Exception e) {
//				obj.put("commuting_arrive", null);
//			}
//			try {
//				obj.put("commuting_leave", sdf.format(comm.getCom_end()));
//			} catch (Exception e) {
//				obj.put("commuting_leave", null);
//			}
//			obj.put("commuting_comment", comm.getCommuting_comment());
//			obj.put("commuting_status", comm.getCommuting_status());
//			try {
//				obj.put("commuting_status_date", sdf.format(comm.getCommuting_status_date()));
//			}catch(Exception e) {
//				obj.put("commuting_status_date", null);
//			}
//			arr.add(obj);
//			System.out.println(obj);
//		}
		System.out.println("===============================================");
		System.out.println(arr);
		return arr.toJSONString();
	}
	
	
	// 캘린더 기능 위한 함수
	public ModelAndView getCalendar(ModelAndView mav, String yearS, String monthS) {
		System.out.println("ModelAndView a getCalendar");
		//=====================================
		Calendar cal = Calendar.getInstance();
		
		int year = 0;
		try {
			year = Integer.parseInt(yearS);
		}catch(Exception e) {
			year = cal.get(Calendar.YEAR);
		}
		
		int month = 0;
		try {
			
			month = Integer.parseInt(monthS);
			month = month%12;
		}catch(Exception e) {
			month = cal.get(Calendar.MONTH);
		}

		cal.set(Calendar.YEAR, year);
		cal.set(Calendar.MONTH, month);
		cal.set(Calendar.DATE, 1);
		
		
		String[] calHead = {"일","월","화","수","목","금","토"};
		
		int startDay = cal.get(Calendar.DAY_OF_WEEK); // 월 시작 요일
		int lastDay = cal.getActualMaximum(Calendar.DATE); // 월 마지막 날짜
		
		ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();
		for(int i = 1 ; i <= lastDay ; i++, startDay++) {
			
			HashMap<String, Object> map = new HashMap<String, Object>();
			
			map.put("days", calHead[(startDay-1) % 7]);
			map.put("day", i);
			list.add(map);
			
		}// for end
		
		//=====================================
		
		mav.addObject("calendar", list);
		mav.addObject("year", year);
		mav.addObject("month", month+1);
		
		return mav;
	}
	
	
	//근태 jsp 모델 앤 뷰
	@RequestMapping("/commuting")
	public ModelAndView a (@RequestParam(value="year", required=false) String yearS, @RequestParam(value="month", required=false) String monthS, @RequestParam(value="day", required=false) String dayS, @RequestParam(value="dPick", required=false) String dPick) {
		System.out.println("ModelAndView a start");
		ModelAndView mav = new ModelAndView("/commuting");
		
		SimpleDateFormat sdf = new SimpleDateFormat("d");
		
		
		mav.addObject("now",sdf.format(new Date()));

		
		mav = getCalendar(mav, yearS, monthS);

		if(dayS != null) {
			mav.addObject("day",Integer.parseInt(dayS));
			mav.addObject("month",Integer.parseInt(monthS));
			mav.addObject("dPick",dPick);
		}
		
		
		
		return mav;
	}

}
