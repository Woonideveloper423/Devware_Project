package com.oracle.devwareProject.dao.GH;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.oracle.devwareProject.domain.Authority;
import com.oracle.devwareProject.domain.Position;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class PosDaoImpl implements PosDao 
{
	private final SqlSession session;
	
	@Override
	public List<Position> getPosInfo() 
	{
		List<Position> poslist = new ArrayList<Position>();
		System.out.println("PosDaoImpl getPosInfo Start");
	
		try {
			poslist = session.selectList("getPosInfo");
			System.out.println("poslist의 사이즈: "+poslist.size());
		} catch (Exception e)
		{
			System.out.println("PosDaoImpl getPosInfo Error:"+e.getMessage());
		}
		
		return poslist;
	}

}
