-- create data accel phone

CREATE TABLE dap (
    subId      numeric(10,0),
    actcode     varchar(50),
    timestamp    numeric(16,0),
    x           float,
    y           float,
    z           float
);


copy dap from '/Users/shek21/Documents/Research/datasets/wisdm+smartphone+and+smartwatch+activity+and+biometrics+dataset/new_datasets/data_accel_phone.csv' delimiter ',';

create table data_accel_phone as (
    select subId, actcode,
    case when (actcode IN ('A','B','C','E','M')) then 'nha'
         when (actcode IN ('P','O','F','Q','R','G','S')) then 'hag'
         else 'hae' end as actgroup,
    extract(year from timestamp) as year, extract(month from Timestamp) as month, x, y, z
from (
    SELECT subid, actcode, to_Timestamp(substr(Timestamp::text,7,16)::int8) AS timestamp, x, y, z
    FROM dap
)i);


select count(*) from data_accel_phone;
create table data_accel_phone_00001 as (
    select * from data_accel_phone tablesample bernoulli(0.0003)
);

select count(*) from data_accel_phone_00001;
alter table data_accel_phone_00001 rename to accelphone00001;
select count(*) from accelphone00001;


-- create data accel watch

CREATE TABLE daw (
    subId      numeric(10,0),
    actcode     varchar(50),
    timestamp    numeric(16,0),
    x           float,
    y           float,
    z           float
);


copy daw from '/Users/shek21/Documents/Research/datasets/wisdm+smartphone+and+smartwatch+activity+and+biometrics+dataset/new_datasets/data_accel_watch.csv' delimiter ',';


create table data_accel_watch as (
    select subId, actcode,
    case when (actcode IN ('A','B','C','E','M')) then 'nha'
         when (actcode IN ('P','O','F','Q','R','G','S')) then 'hag'
         else 'hae' end as actgroup,
    extract(year from timestamp) as year, extract(month from Timestamp) as month, x, y, z
from (
    SELECT subid, actcode, to_Timestamp(substr(Timestamp::text,7,16)::int8) AS timestamp, x, y, z
    FROM daw
)i);


select count(*) from data_accel_watch;
create table data_accel_watch_00001 as (
    select * from data_accel_watch tablesample bernoulli(0.00035)
);

select count(*) from data_accel_watch_00001;
alter table data_accel_watch_00001 rename to accelwatch00001;
select count(*) from accelwatch00001;




-- create data gyro phone

CREATE TABLE dgp (
    subId      numeric(10,0),
    actcode     varchar(50),
    timestamp    numeric(16,0),
    x           float,
    y           float,
    z           float
);


copy dgp from '/Users/shek21/Documents/Research/datasets/wisdm+smartphone+and+smartwatch+activity+and+biometrics+dataset/new_datasets/data_gyro_phone.csv' delimiter ',';


create table data_gyro_phone as (
    select subId, actcode,
    case when (actcode IN ('A','B','C','E','M')) then 'nha'
         when (actcode IN ('P','O','F','Q','R','G','S')) then 'hag'
         else 'hae' end as actgroup,
    extract(year from timestamp) as year, extract(month from Timestamp) as month, x, y, z
from (
    SELECT subid, actcode, to_Timestamp(substr(Timestamp::text,7,16)::int8) AS timestamp, x, y, z
    FROM dgp
)i);


select count(*) from data_gyro_phone;

create table data_gyro_phone_00001 as (
    select * from data_gyro_phone tablesample bernoulli(0.00028)
);

select count(*) from data_gyro_phone_00001;
alter table data_gyro_phone_00001 rename to gyrophone00001;
select count(*) from gyrophone00001;



-- create data gyro watch

CREATE TABLE dgw (
    subId      numeric(10,0),
    actcode     varchar(50),
    timestamp    numeric(16,0),
    x           float,
    y           float,
    z           float
);

copy dgw from '/Users/shek21/Documents/Research/datasets/wisdm+smartphone+and+smartwatch+activity+and+biometrics+dataset/new_datasets/data_gyro_watch.csv' delimiter ',';



create table data_gyro_watch as (
    select subId, actcode,
    case when (actcode IN ('A','B','C','E','M')) then 'nha'
         when (actcode IN ('P','O','F','Q','R','G','S')) then 'hag'
         else 'hae' end as actgroup,
    extract(year from timestamp) as year, extract(month from Timestamp) as month, x, y, z
from (
    SELECT subid, actcode, to_Timestamp(substr(Timestamp::text,7,16)::int8) AS timestamp, x, y, z
    FROM dgw
)i);


select count(*) from data_gyro_watch;

create table data_gyro_watch_00001 as (
    select * from data_gyro_watch tablesample bernoulli(0.00035)
);

select count(*) from data_gyro_watch_00001;
alter table data_gyro_watch_00001 rename to gyrowatch00001;
select count(*) from gyrowatch00001;
