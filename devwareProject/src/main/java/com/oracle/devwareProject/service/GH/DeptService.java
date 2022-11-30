package com.oracle.devwareProject.service.GH;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Service;

import com.oracle.devwareProject.dao.GH.DeptDao;
import com.oracle.devwareProject.domain.Dept;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class DeptService {
	
	private final DeptDao dd;

	public List<Dept> getDeptInfo() 
	{
		System.out.println("DeptService getDeptInfo Start");
		List<Dept> deptlist = new ArrayList<Dept>();
		
		try{
			deptlist = dd.getDeptInfo();
			System.out.println("DeptService의 deptlist의 size"+deptlist.size());
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return deptlist;
	}
	


}
