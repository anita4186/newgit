

use projectdb1;
set hive.cli.print.current.db=true;
set hive.cli.print.header=true;
!echo ========================================================;
!echo LOAD DATA INTO NEW HIVE TABLE;
!echo ========================================================;

drop table if exists hbasetab_new;

create table hbasetab_new like hbasetab;

load data inpath '/project1/part-m-00000' overwrite into table hbasetab_new;

!echo ==================================================================;
!echo CREATING TABLE FOR UPDATED RECORDS;
!echo ==================================================================;

drop table if exists updated_rec;
create table updated_rec as select hbasetab_new.* from hbasetab inner join hbasetab_new on hbasetab.acc_no=hbasetab_new.acc_no;
select * from updated_rec;
!echo ==================================================================;
!echo CREATING TABLE FOR OLD RECORDS;
!echo ==================================================================;

drop table if exists old_rec;
create table old_rec as select hbasetab.* from hbasetab left join hbasetab_new on hbasetab.acc_no=hbasetab_new.acc_no where hbasetab_new.acc_no is null;
select * from old_rec;
!echo ==================================================================;
!echo CREATING TABLE FOR NEW INSERTED RECORDS;
!echo ==================================================================;

drop table if exists new_rec;
create table new_rec as select hbasetab_new.* from hbasetab right join hbasetab_new on hbasetab.acc_no=hbasetab_new.acc_no where hbasetab.acc_no is null;
select * from new_rec;
!echo ==================================================================;
!echo COMBINING ALL RECORDS;
!echo ==================================================================;

drop table if exists final;
create table final like hbasetab;
insert overwrite table final
select * from updated_rec union select * from old_rec union select * from new_rec;

insert overwrite table hbasetab
select * from final;
select * from hbasetab;
!echo END OF HIVE DAILY OPERATION;
 
