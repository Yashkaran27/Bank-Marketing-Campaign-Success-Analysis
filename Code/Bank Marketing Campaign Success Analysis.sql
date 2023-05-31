#Data Exploration
SELECT * 
FROM 
  `my-project-1-362812.bank_data.bank_marketing`


----COMMAND------------

#Counting the number of missing values in the data
SELECT 
  COUNT(*) AS total_rows,
  COUNT(*) - COUNT(age) AS missing_age,
  COUNT(*) - COUNT(job) AS missing_job,
  COUNT(*) - COUNT(marital) AS missing_marital,
  COUNT(*) - COUNT(education) AS missing_education,
  COUNT(*) - COUNT(balance) AS missing_balance,
  COUNT(*) - COUNT(contact) AS missing_contact,
  COUNT(*) - COUNT(day) AS missing_day,
  COUNT(*) - COUNT(month) AS missing_month,
  COUNT(*) - COUNT(duration) AS missing_duration,
  COUNT(*) - COUNT(campaign) AS missing_campaign,
  COUNT(*) - COUNT(pdays) AS missing_pdays,
  COUNT(*) - COUNT(previous) AS missing_previous,
  COUNT(*) - COUNT(poutcome) AS missing_poutcome
FROM 
  `my-project-1-362812.bank_data.bank_marketing`


SELECT y, COUNT (*)
FROM 
  `my-project-1-362812.bank_data.bank_marketing`
GROUP BY y


----COMMAND------------


#Counting unique values for categorial columns
SELECT 
  COUNT(DISTINCT job) AS unique_jobs,
  COUNT(DISTINCT marital) AS unique_marital_statuses,
  COUNT(DISTINCT education) AS unique_education_levels,
  COUNT(DISTINCT contact) AS unique_contact_types,
  COUNT(DISTINCT month) AS unique_months,
  COUNT(DISTINCT poutcome) AS unique_poutcomes
FROM 
  `my-project-1-362812.bank_data.bank_marketing`


----COMMAND------------


#Overall Success rate of the Campaign
SELECT COUNT(*) AS total_clients,
  SUM(CASE WHEN y = TRUE THEN 1 ELSE 0 END) AS successful_clients,
  SUM(CASE WHEN y = TRUE THEN 1 ELSE 0 END) * 100.0 / COUNT(*) AS success_rate
FROM 
  `my-project-1-362812.bank_data.bank_marketing`


----COMMAND------------


#Success rate by job
SELECT job,
  COUNT(*) AS total_clients,
  SUM(CASE WHEN y = TRUE THEN 1 ELSE 0 END) AS successful_clients,
  SUM(CASE WHEN y = TRUE THEN 1 ELSE 0 END) * 100.0 / COUNT(*) AS success_rate
FROM 
  `my-project-1-362812.bank_data.bank_marketing`
GROUP BY job
ORDER BY success_rate DESC


----COMMAND------------


#Success rate by marital status
SELECT marital,
  COUNT(*) AS total_clients,
  SUM(CASE WHEN y = TRUE THEN 1 ELSE 0 END) AS successful_clients,
  SUM(CASE WHEN y = TRUE THEN 1 ELSE 0 END) * 100.0 / COUNT(*) AS success_rate
FROM
  `my-project-1-362812.bank_data.bank_marketing`
GROUP BY marital
ORDER BY success_rate DESC


----COMMAND------------


#Success rate by education
SELECT education,
  COUNT(*) AS total_clients,
  SUM(CASE WHEN y = TRUE THEN 1 ELSE 0 END) AS successful_clients,
  SUM(CASE WHEN y = TRUE THEN 1 ELSE 0 END) * 100.0 / COUNT(*) AS success_rate
FROM
  `my-project-1-362812.bank_data.bank_marketing`
GROUP BY education
ORDER BY success_rate DESC


----COMMAND------------


#Impact on having a housing loan on success rate
SELECT housing,
  COUNT(*) AS total_clients,
  SUM(CASE WHEN y = TRUE THEN 1 ELSE 0 END) AS successful_clients,
  SUM(CASE WHEN y = TRUE THEN 1 ELSE 0 END) * 100.0 / COUNT(*) AS success_rate
FROM
  `my-project-1-362812.bank_data.bank_marketing`
GROUP BY housing
ORDER BY success_rate DESC


----COMMAND------------


#Impact of having a personal loan on success rate
SELECT loan,
  COUNT(*) AS total_clients,
  SUM(CASE WHEN y = TRUE THEN 1 ELSE 0 END) AS successful_clients,
  SUM(CASE WHEN y = TRUE THEN 1 ELSE 0 END) * 100.0 / COUNT(*) AS success_rate
FROM
  `my-project-1-362812.bank_data.bank_marketing`
GROUP BY loan
ORDER BY success_rate DESC


----COMMAND------------


#Months that have highest number of contacts and success rate
SELECT month,
  COUNT(*) AS total_clients,
  SUM(CASE WHEN y = TRUE THEN 1 ELSE 0 END) AS successful_clients,
  SUM(CASE WHEN y = TRUE THEN 1 ELSE 0 END) * 100.0 / COUNT(*) AS success_rate
FROM 
  `my-project-1-362812.bank_data.bank_marketing`
GROUP BY month
ORDER BY success_rate DESC, total_clients DESC


----COMMAND------------


#Checking if number of contacts per clients affect the campaign's success rate
SELECT campaign,
    COUNT(*) AS total_clients,
    SUM(CASE WHEN y = TRUE THEN 1 ELSE 0 END) AS successful_clients,
    SUM(CASE WHEN y = TRUE THEN 1 ELSE 0 END) * 100.0 / COUNT(*) AS success_rate
FROM
  `my-project-1-362812.bank_data.bank_marketing`
GROUP BY campaign
ORDER BY success_rate DESC


----COMMAND------------


#Checking the relationship between client's account balance and campaign's success rate
WITH balance_ranges AS (
  SELECT *,
    CASE
      WHEN balance < 0 THEN 'Negative balance'
      WHEN balance BETWEEN 0 AND 1000 THEN '0-1000'
      WHEN balance BETWEEN 1001 AND 5000 THEN '1001-5000'
      WHEN balance BETWEEN 5001 AND 10000 THEN '5001-10000'
      ELSE 'Above 10000'
    END AS balance_range
  FROM
    `my-project-1-362812.bank_data.bank_marketing`
)

SELECT balance_range,
  COUNT(*) AS total_clients,
  SUM(CASE WHEN y = TRUE THEN 1 ELSE 0 END) AS successful_clients,
  SUM(CASE WHEN y = TRUE THEN 1 ELSE 0 END) * 100.0 / COUNT(*) AS success_rate
FROM
  balance_ranges
GROUP BY balance_range
ORDER BY success_rate DESC, total_clients DESC

----END-------------
