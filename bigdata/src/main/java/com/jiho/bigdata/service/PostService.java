package com.jiho.bigdata.service;

import java.util.List;
import java.util.stream.Collectors;

import javax.transaction.Transactional;

import org.springframework.stereotype.Service;

import com.jiho.bigdata.domain.post.PostRepository;
import com.jiho.bigdata.dto.post.PostListRespDto;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Service
public class PostService {
    private final PostRepository postRepository;

    @Transactional
    public List<PostListRespDto> getAllList() {
        return postRepository.findAll().stream().map(en -> new PostListRespDto(en)).collect(Collectors.toList());
    }
}
