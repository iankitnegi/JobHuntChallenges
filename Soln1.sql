-- create a table
CREATE TABLE poll_investments (
    user_id VARCHAR(10),
    poll_id VARCHAR(10),
    poll_option_id CHAR(1),
    amount INT,
    created_dt DATE
);

-- insert some values
INSERT INTO poll_investments (user_id, poll_id, poll_option_id, amount, created_dt) VALUES
('id1', 'p1', 'A', 200, '2021-12-01'),
('id2', 'p1', 'C', 250, '2021-12-01'),
('id3', 'p1', 'A', 200, '2021-12-01'),
('id4', 'p1', 'B', 500, '2021-12-01'),
('id5', 'p1', 'C', 50, '2021-12-01'),
('id6', 'p1', 'D', 500, '2021-12-01'),
('id7', 'p1', 'C', 200, '2021-12-01'),
('id8', 'p1', 'A', 100, '2021-12-01');


-- query/read
SELECT * FROM poll_investments;


WITH looser AS(
-- lost_amt=>1500 by A, B, D
SELECT SUM(amount) AS lost_amt 
FROM poll_investments 
WHERE poll_option_id IN ('A', 'B', 'D')), 

winner AS(
-- gain who poll on C*=>user_id: id2, id5, id7
SELECT user_id, amount, amount/ -- finding out the ratios of winners
    (SELECT SUM(amount) FROM poll_investments WHERE poll_option_id='C') AS ratio
FROM poll_investments
WHERE poll_option_id = 'C')

SELECT user_id, ROUND((ratio*lost_amt + amount)) AS Returns
FROM winner, looser