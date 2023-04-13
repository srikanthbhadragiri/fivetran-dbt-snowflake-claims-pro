with
clm as (
    select claim_id, submission_date, gross, patientshare, net, vat
    from raw_sc.claim_master
)
select * from clm