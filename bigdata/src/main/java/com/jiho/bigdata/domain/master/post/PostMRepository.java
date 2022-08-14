package com.jiho.bigdata.domain.master.post;

import org.springframework.data.jpa.repository.JpaRepository;

import com.jiho.bigdata.domain.post.Post;

public interface PostMRepository extends JpaRepository<Post, Long>{
    
}
