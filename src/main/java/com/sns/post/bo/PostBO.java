package com.sns.post.bo;

import java.util.List;

import javax.transaction.Transactional;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.sns.comment.bo.CommentBO;
import com.sns.common.FileManagerService;
import com.sns.like.bo.LikeBO;
import com.sns.post.entity.PostEntity;
import com.sns.post.repository.PostRepository;

@Service
public class PostBO {
	
	private Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired
	private PostRepository postRepository;	
	
	@Autowired
	private FileManagerService fileManager;
	
	@Autowired
	private CommentBO commentBO;
	
	@Autowired
	private LikeBO likeBO;
	
	// input: X     output: List<PostEntity>
	public List<PostEntity> getPostList() {
		return postRepository.findAllByOrderByIdDesc();
	}
	
	public PostEntity addPost(int userId, String userLoginId, String content, MultipartFile file) {
		String imagePath = null;

		// 이미지가 있으면 업로드 후 imagePath를 받아옴
		if (file != null) {
			imagePath = fileManager.saveFile(userLoginId, file);
		}

		return postRepository.save(
				PostEntity.builder()
				.userId(userId)
				.content(content)
				.imagePath(imagePath)
				.build());
	}
	//글삭제
	@Transactional
	public void deletePostByPostIdUserId(int postId, int userId) {
		//기존글 가져오기 -> 이미지삭제
		PostEntity post = postRepository.findById(postId).orElse(null);
		if(post == null) {
			logger.error("[delete post] postId:{}, userId:{}, postId, userId");
			return;
		}
		// 이미지 있으면 이미지 삭제
				if (post.getImagePath() != null) {
					fileManager.deleteFile(post.getImagePath());
				}
		//DB글삭제
		postRepository.delete(post);
		
		// DB댓글 삭제
		commentBO.deleteCommentsByPostId(postId);
		
		//DB 좋아요 삭제
		likeBO.deleteLikeByPostId(postId);
	}
}
