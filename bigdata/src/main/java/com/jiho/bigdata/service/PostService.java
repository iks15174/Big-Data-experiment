package com.jiho.bigdata.service;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;
import java.util.stream.IntStream;

import javax.transaction.Transactional;

import org.springframework.stereotype.Service;

import com.jiho.bigdata.domain.post.Post;
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

    @Transactional
    public int createByNum(int num) {
        String baseTitle = "title";
        String baseContent = "content";
        List<Post> postList = new ArrayList<>();
        IntStream.range(0, num).forEach(n -> {
            postList.add(Post.builder().title(baseTitle + n).content(baseContent + n).build());
        });
        postRepository.saveAll(postList);
        return postList.size();
    }
}
