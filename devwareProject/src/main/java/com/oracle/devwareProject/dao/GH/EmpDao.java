package com.oracle.devwareProject.dao.GH;

import java.util.List;

import com.oracle.devwareProject.domain.Emp;
import com.oracle.devwareProject.domain.EmpForSearch;
import com.oracle.devwareProject.domain.EmpList;
import com.oracle.devwareProject.domain.Page;

public interface EmpDao {
	public List<EmpForSearch> getAllUserInfo(Page pg);

	public List<EmpForSearch> getAllUserInfo();

	public int updateEmp(Emp emp);

	public List<EmpForSearch> getUserInfo(int deptnum);

	public List<EmpForSearch> getUserInfo(Page pg, int deptnum);

	public int updateEmpWithAdmin(EmpForSearch emp);

	public int emplistSave(EmpList emplist);

	public EmpForSearch adminGetUserInfo(int emp_num);
}
