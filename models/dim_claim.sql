{{ config(materialized='view') }}
with
    clm as (
        select claim_id, submission_date, gross, patientshare, net, vat
        from raw_sc.claim_master
    ),
    diag as (
        select claim_id, count(diagnosis_code) total_diagnosis
        from raw_sc.claim_diagnosis
        group by claim_id
    ),
    act as (
        select
            claim_id,
            count(activity_id) tot_activities,
            sum(act_net_price * act_quantity) gross
        from raw_sc.claim_activity
        group by claim_id
    ),
    claimview as (
        select
            clm.claim_id,
            clm.submission_date,
            clm.gross,
            clm.patientshare,
            clm.net,
            clm.vat,
            diag.total_diagnosis,
            act.tot_activities,
            act.gross actual_gross
        from clm
        left join (diag) using (claim_id)
        left join (act) using (claim_id)
    )
select *
from claimview