package com.oracle.devwareProject.dao.GH;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.oracle.devwareProject.domain.Dept;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class DeptDaoImpl implements DeptDao 
{
	private final SqlSession session;

	@Override
	public List<Dept> getDeptInfo() {
		List<Dept> deptlist = new ArrayList<Dept>();
		System.out.println("DeptDaoImpl GetDeptInfo Start");
		
		try {
			deptlist = session.selectList("getDeptInfo");
			System.out.println("deptlist의 사이즈: "+deptlist.size());
		} catch (Exception e)
		{
			System.out.println("DeptDaoImpl GetDeptInfo Error:"+e.getMessage());
		}
		
		return deptlist;
	}
}
