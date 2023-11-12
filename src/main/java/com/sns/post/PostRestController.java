package com.sns.post;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.sns.post.bo.PostBO;

@RequestMapping("/post")
@RestController
public class PostRestController {
	private Logger logger = LoggerFactory.getLogger(this.getClass());
	@Autowired
	private PostBO postBO;
	/**
	 * 글수정
	 * @param content
	 * @param file
	 * @param session
	 * @return
	 */
	@PostMapping("/create")
	public Map<String, Object> create(
			@RequestParam("content") String content,
			@RequestParam("file") MultipartFile file,
			HttpSession session) {
		
		Integer userId = (Integer) session.getAttribute("userId");
		String userLoginId = (String) session.getAttribute("userLoginId");
		
		Map<String, Object> result = new HashMap<>();
		if (userId == null) {
			result.put("code", 500); // 비로그인 상태
			result.put("result", "error");
			result.put("errorMessage", "로그인을 해주세요.");
			return result;
		}
		
		postBO.addPost(userId, userLoginId, content, file);
		
		result.put("code", 200);
		result.put("result", "성공");
		return result;
	}
	/**
	 * 글삭제
	 * @param postId
	 * @param session
	 * @return
	 */
	@DeleteMapping("/delete")
	public Map<String, Object>delete(
			@RequestParam("postId")int postId,
			HttpSession session){
			Map<String, Object>result = new HashMap<>();
			
			Integer userId = (Integer)session.getAttribute("userId");
			
			if(userId == null) {
				result.put("code", 500);
				result.put("errorMessage", "삭제실패");
			} 
			postBO.deletePostByPostIdUserId(postId, userId);
			result.put("code", 200);
			result.put("result", "삭제성공");
			
			return result;
	}
}