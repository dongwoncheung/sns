package com.sns.comment.domain;

import com.sns.user.entity.UserEntity;

import lombok.Data;
//게시글의 한개의 폐이지를 의미한다
// 한 개의 댓글
@Data
public class CommentView {
	// 댓글 내용, 댓글쓴이
	private Comment comment;// 댓글 내용 comment의 db내용이 저장되어있는 내용들을 불러온다
	
	private UserEntity user; // 댓글쓴이 user의 db에 저장되어있는 내용들을 불러온다 
}
