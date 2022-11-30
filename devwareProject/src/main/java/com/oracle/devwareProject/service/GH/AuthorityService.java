package com.oracle.devwareProject.service.GH;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Service;

import com.oracle.devwareProject.dao.GH.AuthDao;
import com.oracle.devwareProject.dao.GH.DeptDao;
import com.oracle.devwareProject.domain.Authority;
import com.oracle.devwareProject.domain.Dept;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class AuthorityService {
	
	private final AuthDao ad;
	
	public List<Authority> getAuthInfo() 
	{
		System.out.println("DeptService getDeptInfo Start");
		List<Authority> authlist = new ArrayList<Authority>();
		
		try{
			authlist = ad.getAuthInfo();
			System.out.println("AuthorityService의 authlist의 size"+authlist.size());
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return authlist;
	}
	


}
