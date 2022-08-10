SELECT @@innodb_buffer_pool_size/1024/1024/1024; #GB 단위로 보여준다.
SELECT @@innodb_buffer_pool_chunk_size/1024/1024/1024; #MB이다
SELECT @@innodb_buffer_pool_instances;
SELECT SUBSTRING_INDEX(event_name,'/',2) AS
       code_area, FORMAT_BYTES(SUM(current_alloc))
       AS current_alloc
       FROM sys.x$memory_global_by_current_bytes
       GROUP BY SUBSTRING_INDEX(event_name,'/',2)
       ORDER BY SUM(current_alloc) DESC;
       
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
       
SELECT * FROM performance_schema.memory_summary_global_by_event_name WHERE EVENT_NAME LIKE 'memory/innodb/buf_buf_pool';
set profiling=1;
SELECT * FROM bigdata.post;
show profiles;
show profile MEMORY for query 2;