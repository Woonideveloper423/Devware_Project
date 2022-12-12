package com.oracle.devwareProject.service.GH;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Service;

import com.oracle.devwareProject.dao.GH.EmpDao;
import com.oracle.devwareProject.domain.Emp;
import com.oracle.devwareProject.domain.EmpForSearch;
import com.oracle.devwareProject.domain.EmpList;
import com.oracle.devwareProject.domain.Page;
import com.oracle.devwareProject.repository.GH.EmpRepository;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class EmpService {
	private final EmpRepository ep;
	private final EmpDao ed;
	
	public int empSave(Emp emp) 
	{
		System.out.println("EmpService empSave Start");
		int result = ep.empSave(emp);
		return result;
	}
	
	public EmpList getEmpData(int emp_num) {
		System.out.println("EmpService getEmpData Start");
		EmpList empList = ep.getEmpData(emp_num);
		return empList;
	}

	public int checkEmpId(String emp_id) {
		System.out.println("EmpService checkEmpId Start");
		int result = ep.checkEmpId(emp_id);
		return result;
	}

	public int checkSignEmp(int emp_num) {
		System.out.println("EmpService checkSignEmp Start");
		int result = ep.checkSignEmp(emp_num);
		return result;
	}

	public Emp login(String emp_id) {
		System.out.println("EmpService login Start");
		Emp emp = new Emp();
		
		try {
			emp = ep.login(emp_id);
		}catch (Exception e) {
			System.out.println(e.getMessage());
		}
		
		return emp;
	}

	public Emp getInfo(int emp_num) {
		System.out.println("EmpService getInfo Start");
		Emp emp = new Emp();
		
		try {
			emp = ep.getInfo(emp_num);
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		
		return emp;
	}

	public int changePw(String emp_passwd, int emp_num) {
		System.out.println("EmpService changePw Start");
		System.out.println("EmpService changePw emp_passwd: "+emp_passwd);
		System.out.println("EmpService changePw emp_num: "+emp_num);
		int result = 0;
		try {
			result = ep.changePw(emp_passwd, emp_num);
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		
		return result;
	}

	public List<EmpForSearch> getAllUserInfo(Page pg) {
		System.out.println("EmpService getAllUserInfo Start");
		List<EmpForSearch> emplist = new ArrayList<EmpForSearch>();
		try {
			emplist = ed.getAllUserInfo(pg);
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return emplist;
	}
	
	

	public int getEmpCount() {
		int count = 0;
		System.out.println("EmpService getEmpCount Start");
		List<EmpForSearch> emplist = new ArrayList<EmpForSearch>();
		try {
			emplist = ed.getAllUserInfo();
			count = emplist.size();
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return count;
	}

	public int updateEmp(Emp emp) {
		System.out.println("EmpService updateEmp Start");
		int result = 0;
		try {
			result = ed.updateEmp(emp);
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		
		return result;
	}
	
	public int updateEmpWithAdmin(EmpForSearch emp) {
		System.out.println("EmpService updateEmpWithAdmin Start");
		int result = 0;
		try {
			result = ed.updateEmpWithAdmin(emp);
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		
		return result;
	}

	public int getEmpCount(int deptnum) {
		int count = 0;
		System.out.println("EmpService getEmpCount Start");
		List<EmpForSearch> emplist = new ArrayList<EmpForSearch>();
		try {
			emplist = ed.getUserInfo(deptnum);
			count = emplist.size();
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return count;
	}
	
	public List<EmpForSearch> getEmpByDeptNum(int deptnum) {
		int count = 0;
		System.out.println("EmpService getEmpCount Start");
		List<EmpForSearch> emplist = new ArrayList<EmpForSearch>();
		try {
			emplist = ed.getUserInfo(deptnum);
			count = emplist.size();
			System.out.println("해당 부서의 직원수 : "+count);
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return emplist;
	}
	
	public List<EmpForSearch> getUserInfo(Page pg, int deptnum) {
		System.out.println("EmpService getUserInfo Start");
		List<EmpForSearch> emplist = new ArrayList<EmpForSearch>();
		try {
			emplist = ed.getUserInfo(pg,deptnum);
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return emplist;
	}

	public int userlistSave(EmpList emplist) {
		System.out.println("EmpService userlistSave Start");
		int result = 0;
		try {
			result = ed.emplistSave(emplist);
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
	
		return result;
	}

	public EmpForSearch adminGetUserInfo(int emp_num) {
		System.out.println("EmpService adminGetUserInfo Start");
		EmpForSearch emp = new EmpForSearch();
		try {
			emp = ed.adminGetUserInfo(emp_num);
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		
		return emp;
	}



}
