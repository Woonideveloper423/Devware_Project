package com.oracle.devwareProject.repository.GH;

import java.util.List;

import com.oracle.devwareProject.domain.Emp;
import com.oracle.devwareProject.domain.EmpList;

public interface EmpRepository 
{

	int empSave(Emp emp);
	
	EmpList getEmpData(int emp_num);

	int checkEmpId(String emp_id);

	int checkSignEmp(int emp_num);

	Emp login(String emp_id);

	Emp getInfo(int emp_num);

	int changePw(String emp_passwd, int emp_num);
}
