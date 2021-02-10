-- Find out the names of all batsmen 
-- who scored more than 100 runs and,
-- their runs scored. Sort names alphabetically.
-- (if multiple entries of the same player, 
-- show the one with highest runs)


drop table if exists t1;
create table t1 as (
    select match_id, over_id, ball_id, innings_no, striker  from ball_by_ball
)
;
-- select * from t1;


drop table if exists t2;
create table t2 as (
    select striker, B.match_id, runs_scored from batsman_scored as B
    inner join t1
    where B.match_id = t1.match_id
    and B.over_id = t1.over_id
    and B.ball_id = t1.ball_id
    and B.innings_no = t1.innings_no
)
; 
-- select * from t2;


drop table if exists t3;
create table t3 as (
    select striker, sum(runs_scored) as runs from t2
    group by striker, match_id
)
;
-- select * from t3;


drop table if exists t4;
create table t4 as (
    select * from t3
    where runs > 99
    
)
;
-- select * from t4;


drop table if exists t5;
create table t5 as (
    select P.player_name, t4.runs from t4
    inner join player as P
    where t4.striker = P.player_id
    order by  P.player_name
)
;
-- select * from t5


select distinct(player_name), max(runs) from t5
group by player_name
;