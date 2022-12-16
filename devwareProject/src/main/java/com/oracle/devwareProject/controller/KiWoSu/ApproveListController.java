package com.oracle.devwareProject.controller.KiWoSu;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.oracle.devwareProject.domain.Dept;
import com.oracle.devwareProject.domain.Emp;
import com.oracle.devwareProject.domain.EmpForSearch;
import com.oracle.devwareProject.domain.Page;
import com.oracle.devwareProject.service.GH.DeptService;
import com.oracle.devwareProject.service.GH.EmpService;
import com.oracle.devwareProject.service.GH.Paging;
import com.oracle.devwareProject.service.KiWoSu.approveService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;



@Controller
@RequiredArgsConstructor
@Slf4j
public class ApproveListController {
	
	private final approveService as;
	private final EmpService empService;
	private final DeptService deptService;


	@RequestMapping(value="/pikAuthMem")
	public String approval(HttpSession session,Model model) {
		
		List<EmpForSearch> emplist = new ArrayList<EmpForSearch>();
		List<Dept> deptlist = new ArrayList<Dept>();
		
		try {
			//직원 조회 기능 수행
			emplist = as.getUserInfo();
			deptlist = deptService.getDeptInfo();

			
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		
		model.addAttribute("emplist",emplist);
		model.addAttribute("deptlist",deptlist);
		
		
		return "approve/user/approvalList";
	}
	
	
	@ResponseBody
	@RequestMapping(value="/getMemList", method=RequestMethod.POST)
//	@PostMapping(value="/getMemList")
	public List<EmpForSearch> getMemList(Model model) {
		System.out.println("ApproveListController getMemList start...");
		
		
		List<EmpForSearch> memJoinList = new ArrayList<EmpForSearch>();
		try {
			memJoinList = as.getUserInfo();
			}catch(Exception e) {
			System.out.println("searchById e.getMessage()->"+e.getMessage());
		}
		return memJoinList;
		
		
//		JSONArray arr = new JSONArray();
//		for(EmpForSearch memj : memJoinList) {
//			JSONObject jobj = new JSONObject();
//			jobj.put("emp_num", memj.getEmp_num());
//			jobj.put("dept_name", memj.getDept_name());
//			jobj.put("emp_name", memj.getEmp_name());
//			jobj.put("position_name", memj.getPosition_name());
//			System.out.println("position_name->"+memj.getPosition_name());
//			arr.add(jobj);
//		}
//		
//		return arr.toJSONString();
	}
	
	
	@ResponseBody
	@RequestMapping(value="/searchById", method=RequestMethod.POST)
//	@PostMapping(value="/searchById")
	public EmpForSearch searchById(int emp_num, Model model) {

		
		System.out.println("ApproveListController searchById start...");
		System.out.println("ApproveListController searchById emp_num->"+emp_num);
		EmpForSearch memj = null;
		//System.out.println(id);
		try {
			memj = as.getUserInfo(emp_num);
			System.out.println("ApproveListController searchById memj.getEmp_name()->"+memj.getEmp_name());
			System.out.println("ApproveListController searchById memj.getDept_num()->"+memj.getDept_num());
		}catch(Exception e) {
			System.out.println("searchById e.getMessage()->"+e.getMessage());
		}
		
		
		return memj;
		
	}
	
	
	@ResponseBody
	@RequestMapping(value="/searchDept", method=RequestMethod.POST)
	public List<EmpForSearch> searchDept(Dept dept) {
		
		System.out.println("ApproveListController searchDept start...");
		List<EmpForSearch> empDeptList = null;
		try {
			empDeptList = as.getempDeptInfo(dept);
			System.out.println("empDeptList size->"+ empDeptList.size());
		}catch(Exception e) {
			System.out.println("searchDept e.getMessage()->"+e.getMessage());
		}
		
		return empDeptList;
		
//		System.out.println("ApproveListController searchDept start...");
//		List<EmpForSearch> empDeptList;
//		try {
//			empDeptList = as.getempDeptInfo(dept);
//		}catch(Exception e) {
//			return "error";
//		}
//		JSONArray arr = new JSONArray();
//		
//		for(EmpForSearch memj : empDeptList) {
//			JSONObject jobj = new JSONObject();
//			jobj.put("emp_num", memj.getEmp_num());
//			jobj.put("dept_name", memj.getDept_name());
//			jobj.put("emp_name", memj.getEmp_name());
//			jobj.put("position_name", memj.getPosition_name());
//			arr.add(jobj);
//		}
//		
//		return arr.toJSONString();
	}
}
