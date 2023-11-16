-- 2a) What are the Top 25 schools (.edu domains)?
SELECT email_domain, COUNT(*) as students
FROM users
GROUP BY email_domain
ORDER BY students DESC
LIMIT 25;

-- 2b) How many .edu learners are located in New York?
SELECT city, COUNT(*) as 'New York Learners'
FROM users
WHERE city = 'New York';

-- 2c) The mobile_app column contains either mobile-user or NULL. 
-- How many of these Codecademy learners are using the mobile app?
SELECT mobile_app, COUNT(*) as 'Mobile App Users'
FROM users
WHERE mobile_app = 'mobile-user';

-- 3) Query for the sign up counts for each hour.
SELECT date_format(sign_up_at, '%H') AS Sign_up_hour, COUNT(*) AS 'Signed up of Learners'
FROM users
GROUP BY Sign_up_hour
ORDER BY Sign_up_hour ASC;

-- 4 Join the two tables using JOIN and then see what you can dig out of the data!
SELECT u.email_domain, p.learn_cpp, p.learn_sql, p.learn_html, p.learn_javascript, p.learn_java 
FROM users u JOIN progress p
ON  u.user_id = p.user_id;

-- Do different schools (.edu domains) prefer different courses?

WITH temporaryTable  AS
    (SELECT u.email_domain, p.learn_cpp, p.learn_sql, p.learn_html, p.learn_javascript, p.learn_java 
FROM users u JOIN progress p
ON  u.user_id = p.user_id)
SELECT email_domain, 
COUNT(CASE 
    WHEN learn_cpp IN ('started', 'completed') THEN 1 END ) AS 'CPP',
    COUNT(CASE 
    WHEN learn_sql IN ('started', 'completed') THEN 1 END) AS 'SQL',
    COUNT(CASE 
    WHEN learn_html IN ('started', 'completed') THEN 1 END) AS 'HTML',
    COUNT(CASE 
    WHEN learn_javascript IN ('started', 'completed') THEN 1 END) AS 'JAVASCRIPT',
    COUNT(CASE 
    WHEN learn_java IN ('started', 'completed') THEN 1 END) AS 'JAVA'
FROM temporaryTable
GROUP BY email_domain;

-- What courses are the New Yorkers students taking?
-- What courses are the Chicago students taking?
WITH temporaryTable  AS
    (SELECT u.city, p.learn_cpp, p.learn_sql, p.learn_html, p.learn_javascript, p.learn_java 
FROM users u JOIN progress p
ON  u.user_id = p.user_id)
SELECT city, 
COUNT(CASE 
    WHEN learn_cpp IN ('started', 'completed') THEN 1 END ) AS 'CPP',
    COUNT(CASE 
    WHEN learn_sql IN ('started', 'completed') THEN 1 END) AS 'SQL',
    COUNT(CASE 
    WHEN learn_html IN ('started', 'completed') THEN 1 END) AS 'HTML',
    COUNT(CASE 
    WHEN learn_javascript IN ('started', 'completed') THEN 1 END) AS 'JAVASCRIPT',
    COUNT(CASE 
    WHEN learn_java IN ('started', 'completed') THEN 1 END) AS 'JAVA'
FROM temporaryTable
WHERE city IN ('New York', 'Chicago')
GROUP BY city;








