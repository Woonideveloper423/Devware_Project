package com.oracle.devwareProject.mapper.jiwoong;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.oracle.devwareProject.dto.jiwoong.File;

@Mapper
public interface FileMapper {
	
	public int insertFile(List<File> fileList); // 파일 저장
	
	public File selectFileDetail(File File);  //   파일 상세 정보 조회
	
	public int deleteFile(File file);		 //    파일삭제
	
	public List<File> selectFileList(File file);  // 특정 게시글 포함 파일 목록 조회
	
	public int selectFileTotalCnt(File file);    //  특정 게시글 포함 파일 개수 total
}
