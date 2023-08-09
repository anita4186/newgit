#! ".......Starting Script................."

#Main table
sqoop import --options-file connection.txt --table basetab -m 1 --target-dir /project1 --delete-target-dir --fields-terminated-by ','

hive -f hive_op.hql

echo load successfull;

echo =======================================================;
echo LOADING TABLE INTO HBASE TABLE;
echo =======================================================;

hbase org.apache.hadoop.hbase.mapreduce.ImportTsv -Dimporttsv.separator=, -Dimporttsv.columns=HBASE_ROW_KEY,c:acc_no,c:name,c:acc_bal,c:address,c:adharid bankdb hdfs:/user/hive/warehouse/projectdb1.db/hbasetab/part-m*

echo hbase load successful;
 
