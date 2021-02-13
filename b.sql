-- Find the names of all the batsmen and 
-- the frequency of their “caught” out in increasing order of the number of “caught”.
-- If a tie occurs, sort names alphabetically.

select t1.cnt as no_of_times, player.player_name from (
    select player_out, count(kind_out) as cnt from wicket_taken
    where kind_out = "caught"
    group by player_out
)as t1
inner join player
where t1.player_out = player.player_id
order by t1.cnt asc, player.player_name asc 
;