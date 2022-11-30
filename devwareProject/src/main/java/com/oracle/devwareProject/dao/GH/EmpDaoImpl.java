package com.oracle.devwareProject.dao.GH;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.oracle.devwareProject.domain.Emp;
import com.oracle.devwareProject.domain.EmpForSearch;
import com.oracle.devwareProject.domain.Page;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class EmpDaoImpl implements EmpDao {
	
	private final SqlSession session;
	
	@Override
	public List<EmpForSearch> getAllUserInfo() {
		List<EmpForSearch> emplist = new ArrayList<EmpForSearch>();
		try {
			emplist = session.selectList("getAllUserInfo_All");
			System.out.println("EmpDaoImpl emplist.size: " + emplist.size());
		} catch (Exception e) {
			System.out.println("Error Occurred " + e.getMessage());
		}
		
		return emplist;
	}
	
	@Override
	public List<EmpForSearch> getAllUserInfo(Page pg) 
	{
		List<EmpForSearch> emplist = new ArrayList<EmpForSearch>();
		try {
			emplist = session.selectList("getAllUserInfo_Paging",pg);
			System.out.println("EmpDaoImpl emplist.size: " + emplist.size());
		} catch (Exception e) {
			System.out.println("Error Occurred " + e.getMessage());
		}
		
		return emplist;
	}

	@Override
	public int updateEmp(Emp emp) {
		int result = 0;
		System.out.println("주소 값:"+emp.getEmp_address());
		try {
			result = session.update("updateEmpInfo",emp);
			System.out.println("Update 결과 값:"+result);
		}catch (Exception e) {
			System.out.println("Error Occurred " + e.getMessage());
		}
		
		return result;
	}
	
	@Override
	public int updateEmpWithAdmin(EmpForSearch emp) {
		int result = 0;
		try {
			result = session.update("updateEmpInfoWithAdmin",emp);
			System.out.println("Update 결과 값:"+result);
		}catch (Exception e) {
			System.out.println("Error Occurred " + e.getMessage());
		}
		
		return result;
	}
	
	@Override
	public List<EmpForSearch> getUserInfo(int deptnum) {
		List<EmpForSearch> emplist = new ArrayList<EmpForSearch>();
		try {
			emplist = session.selectList("getUserInfo_deptnum",deptnum);
			System.out.println("EmpDaoImpl emplist.size: " + emplist.size());
		} catch (Exception e) {
			System.out.println("Error Occurred " + e.getMessage());
		}
		
		return emplist;
	}

	@Override
	public List<EmpForSearch> getUserInfo(Page pg, int deptnum) {
		Map<String, Object> map = new HashMap();
		map.put("start", pg.getStart());
		map.put("end", pg.getEnd());
		map.put("deptnum", deptnum);
		
		List<EmpForSearch> emplist = new ArrayList<EmpForSearch>();
		try {
			emplist = session.selectList("getAllUserInfo_Paging_Deptnum",map);
			System.out.println("EmpDaoImpl emplist.size: " + emplist.size());
		} catch (Exception e) {
			System.out.println("Error Occurred " + e.getMessage());
		}
		
		return emplist;
	}




}
