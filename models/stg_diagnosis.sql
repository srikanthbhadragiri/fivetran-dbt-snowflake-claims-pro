with
diag as (
    select claim_id, count(diagnosis_code) total_diagnosis
    from raw_sc.claim_diagnosis
    group by claim_id
)
select * from diag