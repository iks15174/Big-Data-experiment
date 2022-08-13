SET GLOBAL innodb_buffer_pool_size=1073741824;
SET GLOBAL innodb_buffer_pool_chunk_size=536870912;
show engine innodb status;

SELECT
  TABLE_NAME AS `Table`,
  ROUND((DATA_LENGTH + INDEX_LENGTH) / 1024 / 1024) AS `Size (MB)`,
  TABLE_ROWS AS `lenght`
FROM
  information_schema.TABLES
WHERE
  TABLE_SCHEMA = "bigdata"
ORDER BY
  (DATA_LENGTH + INDEX_LENGTH)
DESC; # shema의 table들의 size를 구하는 script이다.

SHOW GLOBAL STATUS LIKE 'innodb_buffer_pool_pages_dirty%';
SHOW GLOBAL VARIABLES LIKE 'innodb_io%';
SHOW GLOBAL STATUS LIKE 'Innodb_buffer_pool%'; #innodb buffer pool hit ratio = Innodb_buffer_pool_read_requests / (Innodb_buffer_pool_read_requests + Innodb_buffer_pool_reads)