with
act as (
    select
        claim_id,
        count(activity_id) tot_activities,
        sum(act_net_price * act_quantity) gross
    from raw_sc.claim_activity
    group by claim_id
)
select * from act