#!bin/bash


echo =================================================;
echo LOADING DATA INTO HDFS;
echo =================================================;

sqoop import --options-file connection.txt --table basetab_copy -m 1 --target-dir /project1 --delete-target-dir --fields-terminated-by ','

echo =================================================;
echo STARTING HIVE OPERATION;
echo =================================================;

hive -f dailyhive_op.hql

echo =================================================;
echo LOADING DATA INTO HBASE TABLE;
echo =================================================;

hbase org.apache.hadoop.hbase.mapreduce.ImportTsv -Dimporttsv.separator=, -Dimporttsv.columns=HBASE_ROW_KEY,c:acc_no,c:name,c:acc_bal,c:address,c:adharid bankdb hdfs://localhost:8020/user/hive/warehouse/projectdb1.db/hbasetab/000000_0

echo ============END OF HBASE LOAD====================;

