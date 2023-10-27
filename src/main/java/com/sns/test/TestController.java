package com.sns.test;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sns.post.mapper.PostMapper;

@Controller
public class TestController {
	@Autowired
	PostMapper postMapper;
	//1 string + response body 로 리턴하는지 -> html
	@ResponseBody
	@GetMapping("/test1")
	public String test1() {
		return"hello";
	}
	//2map + responsebody -> jason
	@ResponseBody
	@GetMapping("/test2")
	public Map<String, Object> test2() {
		Map<String, Object> map = new HashMap<>();
		map.put("a",100);
		return map;
	}
	//3jsp -> html
	@GetMapping("/test3")
	public String test3() {
		return"test/test";
	}
	//4 db연동 responsebody -> jason
	//snsapplication db 설정 안보는 설정 제거
	//databaseconfig 클래스 추가
	@ResponseBody
	@GetMapping("/test4")
	public List<Map<String, Object>> test4() {
		return postMapper.selectPostList();
	}
}
