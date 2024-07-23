
create table staging.nyc_parking_violation_codes
(
code BIGINT
,definition VARCHAR
,manhattan_96th_st_below BIGINT
,all_other_areas BIGINT
);

-- move the csv file to docker container.
-- then run the COPY command.

COPY staging.nyc_parking_violation_codes from '/home/shri/data/dof_parking_violation_codes.csv' 
with delimiter as ',' CSV HEADER;