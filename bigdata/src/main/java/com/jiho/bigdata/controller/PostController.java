package com.jiho.bigdata.controller;

import java.util.List;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.jiho.bigdata.dto.post.PostListRespDto;
import com.jiho.bigdata.dto.post.PostSaveDto;
import com.jiho.bigdata.service.PostService;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@RestController
@RequestMapping("/api")
public class PostController {
    
    private final PostService postService;

    @GetMapping("/v1/post")
    public ResponseEntity<List<PostListRespDto>> getAllPost() {
        return ResponseEntity.ok().body(postService.getAllList());
    }

    @PostMapping("/v1/post")
    public ResponseEntity<Long> createPost(PostSaveDto requestDto) {
        return ResponseEntity.ok().body(postService.createPost(requestDto));
    }

    @PostMapping("/v1/post/number")
    public ResponseEntity<Integer> createByNum(@RequestBody int num) {
        return ResponseEntity.ok().body(postService.createByNum(num));
    }
}
