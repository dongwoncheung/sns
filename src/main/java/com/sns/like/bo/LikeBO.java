package com.sns.like.bo;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sns.like.mapper.LikeMapper;

@Service
public class LikeBO {

	@Autowired
	private LikeMapper likeMapper;

	// input: 누가, 어느글에
	// output: X
	public void likeToggle(int postId, int userId) {
		// 셀렉트 => count(*)
		if (likeMapper.selectLikeCountByPostIdOrUserId(postId, userId) > 0) {
			// 삭제
			likeMapper.deleteLikeByPostIdUserId(postId, userId);
		} else {
			// 추가
			likeMapper.insertLike(postId, userId);
		}
	}
	
	// input:글번호     output: 개수(count int)
	public int getLikeCountByPostId(int postId) {
		return likeMapper.selectLikeCountByPostIdOrUserId(postId, null);
	}
	
	// input:글번호, userId(Integer -> (null일 가능성도 있어서))     output:채워진지 여부(boolean)
	public boolean filledLike(int postId, Integer userId) {
		// 비로그인
		if (userId == null) {
			return false;
		}
		
		// 로그인
		// 0보다 큰 경우 있음(채운다 true)   그렇지 않으면 false(빈 하트)
		return likeMapper.selectLikeCountByPostIdOrUserId(postId, userId) > 0;
	}
	public void deleteLikeByPostId(int postId) {
		likeMapper.deleteLikeByPostId(postId);
	}
}
