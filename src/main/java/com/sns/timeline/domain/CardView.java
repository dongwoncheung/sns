package com.sns.timeline.domain;

import java.util.List;

import com.sns.comment.domain.CommentView;
import com.sns.post.entity.PostEntity;
import com.sns.user.entity.UserEntity;

import lombok.Data;

// View 용 객체 -> 글쓴이의 그림을 뿌리기 위한 과정
// 글 1개와 매핑됨
@Data
public class CardView {
	// 글 1개
	private PostEntity post; // 객체를 통으로 넣는방식
	
	// 글쓴이 정보 -> 글쓴이의 이름이나 사진 
	private UserEntity user; // 글쓴이의 정보를 통으로 넣는 방식
	
	// 댓글들
	private List<CommentView> commentList; // 댓글을 쓴 사람들의 정보을 commentview에 생성후 연결
	
	// 좋아요 개수
	private int likeCount;
	
	// 내가 좋아요를 눌렀는지 여부
	private boolean filledLike; // false -> 빈하트  true -> 하트
}