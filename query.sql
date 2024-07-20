-- 1.Retrieve the names of all players.
SELECT 
player_name
FROM players;

-- 2.Find all players who belong to team "SL"
SELECT *
FROM players
WHERE team = 'SL';

-- 3.List the batting and bowling statistics for all players.
SELECT *
FROM batting_status ba LEFT JOIN bowling_status bo
ON ba.player = bo.player
UNION
SELECT *
FROM batting_status ba RIGHT JOIN bowling_status bo
ON ba.player = bo.player;

-- 4.Find the average runs scored by players in descending order.
SELECT 
player,
AVG(runs) AS average_runs
FROM batting_status
GROUP BY player
ORDER BY average_runs DESC;

-- 5.Group players by team and count the number of players in each team.
SELECT 
team,
COUNT(player_name) AS total_players
FROM players
GROUP BY team;

-- 6.Find teams with more than 13 players.
SELECT 
team,
COUNT(player_name) AS total_players
FROM players
GROUP BY team
HAVING total_players > 13;

-- 7.Retrieve the names of players and order them by their highest score in descending order.
SELECT 
p.player_name,
ba.highest_score
FROM players p INNER JOIN batting_status ba
ON p.player_name = ba.player
ORDER BY ba.highest_score DESC;

-- 8.Find the players with the highest batting average.
SELECT 
player,
average
FROM batting_status
ORDER BY average DESC
LIMIT 1;

-- 9.Update the team name of a player.
UPDATE players
SET player_name = 'PW Hasaranga'
WHERE player_name = 'W Hasaranga';

-- 10.Remove a player from the "players" table.
DELETE FROM players
WHERE player_name = 'V Kohli';

-- 11.Add a new player to the "players" table.
INSERT INTO players (player_name, team)
VALUES ('D Gunathilaka', 'SL');

-- 12.List players along with their batting and bowling statistics.
SELECT
p.player_name, p.team,
ba.matches AS batted_matches, ba.innings AS batted_innings, ba.not_outs, ba.runs AS scored_runs,
ba.highest_score, ba.average AS batting_average, ba.strike_rate, ba.centuries, ba.half_centuries, ba.duck_outs,
bo.matches AS bowled_matches, bo.innings AS bowled_innings, bo.balls, bo.maiden_overs, bo.runs, bo.wickets,
bo.average AS bowling_average, bo.bowling_economy, bo.strike_rate, bo.five_wickets, bo.ten_wickets, bo.catches
FROM players p LEFT JOIN batting_status ba
ON p.player_name = ba.player
LEFT JOIN bowling_status bo
ON p.player_name = bo.player;

-- 13.Find the matches Sri Lanka won.
SELECT *
FROM match_results
WHERE winner = 'Sri Lanka';

-- 14.Find the top 3 players with the highest average batting score, 
   -- along with their team names and the number of matches played.
SELECT 
player,
team,
matches,
average
FROM batting_status
ORDER BY average DESC
LIMIT 3;

-- 15.List all players who have more than 15 wickets in their bowling career.
SELECT
player
FROM bowling_status
WHERE wickets > 15;

-- 16.Find the team with the highest number of total wickets taken in all matches.
SELECT
team,
SUM(wickets) AS total_wickets
FROM bowling_status
GROUP BY team
ORDER BY total_wickets DESC
LIMIT 1;

-- 17.List the players who have the highest strike rate in each team.
SELECT 
player,
team,
strike_rate
FROM batting_status
WHERE (team, strike_rate) IN (SELECT 
							                team, 
                              MAX(strike_rate)
							                FROM batting_status
							                GROUP BY team);
                              
-- 18.Find pairs of players from the same team who have both scored more than 500 runs.
SELECT 
a.player AS player1, 
b.player AS player2, 
a.team
FROM batting_status a JOIN batting_status b 
ON a.team = b.team AND a.player <> b.player
WHERE a.runs > 100 AND b.runs > 100;

-- 19.For each player, show their total runs, total wickets, and average bowling economy.
SELECT 
p.player_name,
ba.runs,
bo.wickets,
bo.bowling_economy
FROM players p LEFT JOIN batting_status ba
ON p.player_name = ba.player
LEFT JOIN bowling_status bo
ON bo.player = ba.player;

-- 20.List the players who have the highest strike rate in each team.
SELECT 
player,
team,
strike_rate
FROM batting_status
WHERE (team, strike_rate) IN (SELECT 
                              team, 
							                MAX(strike_rate)
                              FROM batting_status
                              GROUP BY team);
