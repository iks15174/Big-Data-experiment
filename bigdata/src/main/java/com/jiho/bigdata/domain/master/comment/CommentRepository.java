package com.jiho.bigdata.domain.master.comment;

import org.springframework.data.jpa.repository.JpaRepository;

import com.jiho.bigdata.domain.comment.Comment;

public interface CommentRepository extends JpaRepository<Comment, Long> {
    
}
