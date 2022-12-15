package com.oracle.devwareProject.util.jiwoong;

import java.io.IOException;
import java.nio.file.Paths;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.UUID;

import org.apache.commons.io.FilenameUtils;
import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

import com.oracle.devwareProject.Exception.AttachFileException;
import com.oracle.devwareProject.dto.jiwoong.File;

@Component
public class FileUtils {
	
	/* 오늘 날짜 */
	private final String today = LocalDate.now().format(DateTimeFormatter.ofPattern("yyMMDD"));
	
	/* 업로드 경로 */
	private final String uploadPath = Paths.get("C:","develop","upload",today).toString();
	
	/* 서버에 생성할 파일명을 처리할 랜덤 문자열 반환 */
	private final String getRandomString() {
		return UUID.randomUUID().toString().replaceAll("-","");
	}
	
	/* 서버에 첨부 파일 생성하고 업로드 파일 목록 반환 */
	public List<File> uploadFiles(MultipartFile[] files,int emp_num,int brd_type,int brd_num){
		
		/* 파일이 비어있으면 비어있는 리스트 반환 */
		if(files[0].getSize()<1) {
			return Collections.emptyList();
		}
		
		/* 업로드 파일 정보를 담을 비어있는 리스트 */
		List<File> attachList= new ArrayList<>();
		
		/* uploadPath에 해당하는 디렉터리가 없는 경우 부모 디렉터리를 포함한 모든 디렉터리를 생성 */
		java.io.File dir=new java.io.File(uploadPath);
		if(dir.exists()==false) {
			dir.mkdirs();
		}
		
		/* 파일 개수만큼 foreach 실행 */
		for(MultipartFile file : files) {
			try {
				/* 파일 확장자 */
				final String extension = FilenameUtils.getExtension(file.getOriginalFilename());
				/* 서버에 저장할 파일명(랜덤 문자열+확장자) */
				final String saveName=getRandomString()+"."+extension;
				/* 업로드 경로에 saveName과 동일한 이름을 가진 파일 생성 */
				java.io.File target=new java.io.File(uploadPath,saveName);
				file.transferTo(target);
				
				/*파일 정보 저장*/
				File attach=new File();
				attach.setBrd_num(brd_num);
				attach.setBrd_type(brd_type);
				attach.setEmp_num(emp_num);
				attach.setFile_original_name(file.getOriginalFilename());
				attach.setFile_save_name(saveName);
				attach.setFile_size(file.getSize());
				
				/* 파일정보 추가 */
				attachList.add(attach);
				
			} catch (IOException e) {
				throw new AttachFileException("[" + file.getOriginalFilename() + "] failed to save file...");

			}catch(Exception e) {
			throw new AttachFileException("[" + file.getOriginalFilename() + "] failed to save file...");
		}
			}
			return attachList;
		}
	}
