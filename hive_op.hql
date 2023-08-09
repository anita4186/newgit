use projectdb1;
SET hive.cli.print.header=true;
SET hive.cli.print.current.db=true;

!echo ==================================================================;
!echo CREATING BASE TABLE;
!echo ==================================================================;


DROP TABLE IF EXISTS hbasetab;
create table IF NOT EXISTS hbasetab(c_id bigint,acc_no bigint,name string,acc_bal bigint,address string,adharid bigint)
row format delimited
fields terminated by ','
lines terminated by '\n'
stored as textfile;

!echo ==================================================================;
!echo LOADING DATA INTO BASE TABLE;
!echo ==================================================================;

load data inpath '/project1/part-m-00000' into table hbasetab;

!echo ==================================================================;
!echo FETCHING DATA FROM BASE TABLE;
!echo ==================================================================;

select * from hbasetab;
!echo END OF HIVE TABLE LOAD;
