package com.jiho.bigdata.dto.post;

import com.jiho.bigdata.domain.post.Post;

import lombok.Getter;

@Getter
public class PostListRespDto {
    private Long id;
    private String title;
    private String content;

    public PostListRespDto(Post entity) {
        this.id = entity.getId();
        this.title = entity.getTitle();
        this.content = entity.getContent();
    }
}
