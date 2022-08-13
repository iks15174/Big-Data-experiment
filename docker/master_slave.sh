echo "Reset Master DB"
docker exec master mysql -u root -ppassword -e "RESET MASTER;"

echo "Flush and lock Master DB"
docker exec master mysql -u root -ppassword -e "FLUSH TABLES WITH READ LOCK;"

MASTER_STATUS=$(docker exec master mysql -u root -ppassword -e "SHOW MASTER STATUS;")
MS_ARR=($MASTER_STATUS)
echo ${MASTER_STATUS}

echo "Get current Master DB binary file status"
FILE=${MS_ARR[5]}
echo "${FILE}"

echo "Get current Master DB binary position status"
POSITION=${MS_ARR[6]}
echo "${POSITION}"

echo "Save Master DB binary status"
echo "${FILE} ${POSITION}" > ./share/masterdb_status.txt

echo "Dump Master DB"
docker exec master mysqldump -u root -ppassword --all-databases > ./share/cur.sql

echo "Stop Slave"
docker exec slave1 mysql -u root -ppassword -e "stop slave;"

echo "Dump Master DB to Slave DB"
docker exec slave1 mysql -u root -ppassword < ./share/cur.sql

echo "Synchronize Slave DB to Master DB"
docker exec slave1 mysql -u root -ppassword -e "CHANGE MASTER TO MASTER_HOST='master', MASTER_USER='repl', MASTER_PASSWORD='1234', MASTER_LOG_FILE='${FILE}', MASTER_LOG_POS=${POSITION};"

echo "Start Slave"
docker exec slave1 mysql -u root -ppassword -e "start slave;"

echo "Unlock Master DB"
docker exec master mysql -u root -ppassword -e "UNLOCK TABLES;"


