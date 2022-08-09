package com.jiho.bigdata.dto.post;

import com.jiho.bigdata.domain.post.Post;

import lombok.Getter;

@Getter
public class PostSaveDto {
    private String title;
    private String content;

    public Post toEntity() {
        return Post.builder().content(content).title(title).build();
    }
}
