package com.jiho.bigdata.domain.firstslave.comment;

import org.springframework.data.jpa.repository.JpaRepository;

import com.jiho.bigdata.domain.comment.Comment;

public interface CommentFSRepository extends JpaRepository<Comment, Long> {
    
}
