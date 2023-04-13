{{ config(materialized='view') }}
with
    clm as (
        select * from {{ref('stg_claims')}}
    ),
    diag as (
        select * from {{ref('stg_diagnosis')}}
    ),
    act as (
        select * from {{ref('stg_activities')}}
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