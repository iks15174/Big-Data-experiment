package com.jiho.bigdata.domain.firstslave.post;

import org.springframework.data.jpa.repository.JpaRepository;

import com.jiho.bigdata.domain.post.Post;

public interface PostFSRepository extends JpaRepository<Post, Long>{
    
}
