    create table staging.nyc_parking_violations_2023
    (
        summons_number BIGINT
        ,registration_state VARCHAR
        ,plate_type VARCHAR
        ,issue_date DATE
        ,violation_code BIGINT
        ,vehicle_body_type VARCHAR
        ,vehicle_make VARCHAR
        ,issuing_agency VARCHAR
        ,vehicle_expiration_date BIGINT
        ,violation_location BIGINT
        ,violation_precinct BIGINT
        ,issuer_precinct BIGINT
        ,issuer_code BIGINT
        ,issuer_command VARCHAR
        ,issuer_squad VARCHAR
        ,violation_time VARCHAR
        ,time_first_observed VARCHAR
        ,violation_county VARCHAR
        ,violation_in_front_of_or_opposite VARCHAR
        ,date_first_observed BIGINT
        ,law_section BIGINT
        ,sub_division VARCHAR
        ,violation_legal_code BOOLEAN
        ,days_parking_in_effect VARCHAR
        ,from_hours_in_effect VARCHAR
        ,to_hours_in_effect VARCHAR
        ,vehicle_color VARCHAR
        ,unregistered_vehicle BIGINT
        ,vehicle_year BIGINT
        ,meter_number VARCHAR
        ,feet_from_curb BIGINT
        ,no_standing_or_stopping_violation VARCHAR
        ,hydrant_violation VARCHAR
        ,double_parking_violation VARCHAR
    );
		
-- move the csv file to docker container.
-- then run the COPY command.

COPY staging.nyc_parking_violations_2023 from '/home/shri/data/parking_violations_issued_fiscal_year_2023_sample.csv' 
with delimiter as ',' CSV HEADER;
