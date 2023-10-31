package com.sns.user.bo;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sns.user.entity.UserEntity;
import com.sns.user.repository.UserRepository;

@Service
public class UserBO {
	@Autowired
	private UserRepository userRepository;
	//input: loginid
	//output: userentity(null이거나 entity)
	public UserEntity getUserEntityByLoginId(String loginId) {
		return userRepository.findByLoginId(loginId); 
	}
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
