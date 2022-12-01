package com.oracle.devwareProject.repository.GH;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.EntityManager;
import javax.transaction.Transactional;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.oracle.devwareProject.domain.Emp;
import com.oracle.devwareProject.domain.EmpList;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
@Transactional
public class EmpRepositoryImpl implements EmpRepository {
	
	private final EntityManager em;

	public int empSave(Emp emp) 
	{
		int result = 0;
		try {
			System.out.println("EmpDaoImpl empSave Start");
			System.out.println("test getEmp_hireDate: " + emp.getEmp_hireDate());
			em.persist(emp);
			result++;
		} catch (Exception e) {
			System.out.println("EmpDaoImpl empSave Error: " + e.getMessage());
		}
		return result;
	}

	@Override
	public EmpList getEmpData(int emp_num) {
		EmpList emplist = new EmpList();
		System.out.println("EmpDaoImpl getEmpData Start");
		
		try {
			emplist = em.find(EmpList.class, emp_num);
		} catch (Exception e) {
			System.out.println("EmpDaoImpl getEmpData 에러 발생");
		}
		return emplist;
	}

	@Override
	public int checkEmpId(String emp_id) {
		System.out.println("EmpDaoImpl getEmpData Start");
		System.out.println("EmpDaoImpl emp_id : " + emp_id);
		
		int result = 0;
		List<Emp> emplist = new ArrayList<Emp>();
		
		try {
			emplist = em.createQuery("SELECT e FROM Emp e where e.emp_id = :emp_id", Emp.class)
									.setParameter("emp_id", emp_id)
									.getResultList();
			result = emplist.size();
			System.out.println("checkEmpId 쿼리문 결과 값: " + result);
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		
		return result;
	}

	@Override
	public int checkSignEmp(int emp_num) {
		// TODO Auto-generated method stub
		System.out.println("EmpDaoImpl checkSignEmp Start");
		System.out.println("EmpDaoImpl emp_num : " + emp_num);
		
		int result = 0;
		List<Emp> emplist = new ArrayList<Emp>();
		
		try {
			emplist = em.createQuery("SELECT e FROM Emp e where e.emp_num = :emp_num", Emp.class)
									.setParameter("emp_num", emp_num)
									.getResultList();
			result = emplist.size();
			System.out.println("checkSignEmp 쿼리문 결과 값: " + result);
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		
		return result;
	}

	@Override
	public Emp login(String emp_id) {
		System.out.println("EmpDaoImpl login Start");
		System.out.println("EmpDaoImpl emp_id : " + emp_id);
		
		Emp emp = new Emp();
		
		try {
			emp = em.createQuery("SELECT e FROM Emp e where e.emp_id = :emp_id", Emp.class)
								.setParameter("emp_id", emp_id)
								.getSingleResult();
			System.out.println("login 쿼리문 결과 값: " + emp.getEmp_id());
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		
		return emp;
	}

	@Override
	public Emp getInfo(int emp_num) {
		System.out.println("EmpDaoImpl getInfo Start");
		
		Emp emp = new Emp();
		try {
			emp = em.find(Emp.class, emp_num);
			// emp NULL --> 못 찾은 경우
			if (emp == null) {
				emp = new Emp();
				emp.setResult(0);
				emp.setMsg("아이디 찾기에 실패하셨습니다.");
			} 
		} catch (Exception e) {
			System.out.println("EmpDaoImpl getInfo 에러 발생");
		}
		System.out.println("결과 값: "+ emp.getEmp_name());
		return emp;
	}

	@Override
	public int changePw(String emp_passwd, int emp_num) {
		int result = 0;
		try { 
			 result = em.createQuery("UPDATE Emp e SET e.emp_passwd = :emp_passwd WHERE e.emp_num = :emp_num")
			.setParameter("emp_passwd", emp_passwd)
			.setParameter("emp_num", emp_num)
			.executeUpdate();
			 
			 em.clear();
		} catch (Exception e) {
			System.out.println("EmpDaoImpl changePw 에러 발생");
		}
		
		return result;
	}

}
