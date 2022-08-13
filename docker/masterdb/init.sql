-- slave 접속 유저 생성
CREATE USER 'repl'@'%' IDENTIFIED WITH mysql_native_password BY '1234'; 
GRANT REPLICATION SLAVE ON *.* TO 'repl'@'%';