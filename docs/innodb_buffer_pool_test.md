# innoDB buffer pool 사이즈에 따른 쿼리 성능 확인

## 1. DB 설계
![DB SCHEMA](../imgs/innodb/db.drawio.png)

게시글을 위한 Post 테이블과 댓글을 위한 Comment 테이블이 존재하며, Post와 Comment는 일대다 관계이다.

## 2. 테스트를 하기 전 상황
테스트를 하기 전 Post 테이블에는 2410725 데이터가 들어가 있다. 이 데이터는 아래의 구문을 이용해 자동으로 추가해줬다.
``` bash
DROP procedure IF EXISTS `createPost`;
DELIMITER $$ 
CREATE PROCEDURE createPost()
BEGIN
    DECLARE i INT DEFAULT 1;
    WHILE (i <= 1000000) DO
        INSERT INTO bigdata.post(title, content) VALUES (concat('title', i), concat('content', i));
        SET i = i + 1;
    END WHILE;
END$$
DELIMITER ; 
CALL createPost();
```
위의 구문은 Post 테이블의 데이터를 1000000건 넣어주는 일을 한다. 그러나 이 구문의 속도는 매우 느리기 때문에 bulk insert를 활용할 수 있도록 수정이 필요하다. 그리고 테스트 시작 전 innoDB의 buffer_pool_size는 8MB이다. buffer_pool_size는 innoDB가 캐싱을 하기 위해 사용하는 RAM의 크기이다. 이 크기가 클 수록 더 많은 것을 캐싱하고 캐시 HIT할 확률이 높아져 성능이 더욱 좋아질 것이라고 예상한다.

## 3. 테스트하기
- buffer_pool_size가 8MB일 때
- buffer_pool_size가 1GB일 때
