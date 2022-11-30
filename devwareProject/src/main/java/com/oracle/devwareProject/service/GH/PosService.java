package com.oracle.devwareProject.service.GH;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Service;

import com.oracle.devwareProject.dao.GH.PosDao;
import com.oracle.devwareProject.domain.Authority;
import com.oracle.devwareProject.domain.Position;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class PosService 
{
	private final PosDao pd;
	public List<Position> getPosInfo() 
	{
		System.out.println("PosService getPosInfo Start");
		List<Position> poslist = new ArrayList<Position>();
		
		try{
			poslist = pd.getPosInfo();
			System.out.println("PosService의 poslist의 size"+poslist.size());
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return poslist;
	}
}
