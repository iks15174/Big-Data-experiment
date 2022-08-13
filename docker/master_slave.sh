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

# slave들에 show database의 결과와 dumpsql을 전달하고 sync 작업을 수행한다.

echo "Unlock Master DB"
docker exec master mysql -u root -ppassword -e "UNLOCK TABLES;"


