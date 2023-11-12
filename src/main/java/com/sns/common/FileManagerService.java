package com.sns.common;
import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;


import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

@Component // 일반적인 spring bean
public class FileManagerService {
	// 실제 업로드가 된 이미지가 저장될 경로(서버)
	public static final String FILE_UPLOAD_PATH = "C:\\JAVAclass\\5_springproject\\sns\\workspace\\images/";

	// input: userLoginId, file(이미지) output: web imagePath
	public String saveFile(String loginId, MultipartFile file) {
		// 폴더 생성
		// 예: aaaa_178945646/sun.png
		String directoryName = loginId + "_" + System.currentTimeMillis();
		String filePath = FILE_UPLOAD_PATH + directoryName; // C:\JAVAclass\5_springproject\sns\workspace\images/aaaa_178945646

		File directory = new File(filePath);
		if (directory.mkdir() == false) {
			// 폴더 생성 실패 시 이미지 경로 null로 리턴
			return null;
		}

		// 파일 업로드: byte 단위로 업로드
		try {
			byte[] bytes = file.getBytes();
			// ★★★★★★ 한글 이름 이미지는 올릴 수 없으므로 나중에 영문자로 바꿔서 올리기
			Path path = Paths.get(filePath + "/" + file.getOriginalFilename()); // 디렉토리 경로 + 사용자가 올린 파일명
			Files.write(path, bytes); // 파일 업로드
		} catch (IOException e) {
			e.printStackTrace();
			return null; // 이미지 업로드 실패 시 null 리턴
		}

		// 파일 업로드가 성공했으면 웹 이미지 url path를 리턴
		// 주소는 이렇게 될 것이다.(예언)
		// /images/aaaa_178945646/sun.png
		return "/images/" + directoryName + "/" + file.getOriginalFilename();
	}
	//파일 삭제 매소드
	//input: imagepath
	//output: void
	public void deleteFile(String imagePath) {// 이미지를 업로드 했던 파일을 삭제한다
		
		// 주소에 겹치는 /images/ 를 제거한다.
		Path path = Paths.get(FILE_UPLOAD_PATH + imagePath.replace("/images/", ""));
		if (Files.exists(path)) { // 이미지가 존재하는가?
			// 이미지 삭제
			try {
				Files.delete(path);
			} catch (IOException e) {
				logger.info("###[FileManagerService 이미지 삭제 실패] imagePath:{}", imagePath);
			}

			// 디렉토리(폴더) 삭제
			path = path.getParent();
			if (Files.exists(path)) {
				try {
					Files.delete(path);
				} catch (IOException e) {
					logger.info("###[FileManagerService 이미지 폴더 삭제 실패] imagePath:{}", imagePath);
				}
			}
		}
	}
}
