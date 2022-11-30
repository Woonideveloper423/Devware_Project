package com.oracle.devwareProject.dao.GH;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.oracle.devwareProject.domain.Authority;
import com.oracle.devwareProject.domain.Dept;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class AuthDaoImpl implements AuthDao {
	private final SqlSession session;
	
	@Override
	public List<Authority> getAuthInfo() 
	{
		List<Authority> authlist = new ArrayList<Authority>();
		System.out.println("AuthDaoImpl getAuthInfo Start");

		try {
			authlist = session.selectList("getAuthInfo");
			System.out.println("authlist의 사이즈: "+authlist.size());
		} catch (Exception e)
		{
			System.out.println("AuthDaoImpl getAuthInfo Error:"+e.getMessage());
		}
		
		return authlist;
	}
}
