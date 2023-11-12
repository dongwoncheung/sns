package com.sns.user.bo;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sns.user.entity.UserEntity;
import com.sns.user.repository.UserRepository;

@Service
public class UserBO {
	@Autowired
	private UserRepository userRepository;
	// timelineBo에 userBo을 가져오는 방식
	public UserEntity getUserEntityById(int userId) {
		return userRepository.findById(userId).orElse(null); //optional = null 가능한것 / pk로 조회 // 모든 user다가져오지 않고 id로만 조회 가능
	}
	//input: loginid
	//output: userentity(null이거나 entity)
	public UserEntity getUserEntityByLoginId(String loginId) {
		return userRepository.findByLoginId(loginId); 
	}
	//로그인을 하는 페이지 
	// in: loginid , hashing password
	// out: userentity(통째로 단건으로) null이거나 entity
	public UserEntity getUserEntityByLoginIdPassword(String loginId, String password) {
		return userRepository.findByLoginIdAndPassword(loginId, password);
	}
	//회원가입을 하는 부분
	// in: 4개의 파라미터들
	// out: id(pk)
	public Integer addUser(String loginId, String password, String name, String email) {
		//UserEntity = save(UserEntity);
		UserEntity userEntity = userRepository.save(
				UserEntity.builder()
				.loginId(loginId)
				.password(password)
				.name(name)
				.email(email)
				.build());//setter 대신 사용하는것이 loombook에서는 builder()
		
		return userEntity == null ? null : userEntity.getId();
	}
}
