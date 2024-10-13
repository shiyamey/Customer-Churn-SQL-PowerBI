USE customer_churn; #using the Schema

# 1.Identify the total number of customers and the churn rate
SELECT COUNT(*) AS total_customers
FROM customer_churn;
	#Total number of customers is 4835
    
SELECT 
    COUNT(`Customer ID`) AS Churned_Customers,
    (COUNT(`Customer ID`) / (SELECT COUNT(`Customer ID`) FROM customer_churn)) * 100 AS Churn_Rate_Percentage
FROM customer_churn
WHERE `Customer Status` = 'Churned';
	# NO OF CHURNED CUSTOMER = 1586, CHURN RATE PERCENTAGE = 32.8025%
    
# 2.Find the average age of churned customers
SELECT AVG(Age) AS Average_Age_Of_Churned_Customers
FROM customer_churn
WHERE `Customer Status` = 'Churned';
	#AVERAGE AGE OF CHURNED CUSTOMER = 50.1658

# 3.Discover the most common contract types among churned customers
SELECT contract, COUNT(*) AS Number_Of_Churned_Customers
FROM customer_churn
WHERE `Customer Status` = 'Churned'
GROUP BY contract
ORDER BY Number_Of_Churned_Customers DESC
limit 1;
	#THE MOST COMMON CONTRACT TYPE AMONG CHURNED CUSTOMERS = Month-to-Month WITH 1403 CHURNED CUSTOMERS

#4.	Analyze the distribution of monthly charges among churned customers
SELECT 
    SUM(`monthly charge`) AS total_monthly_charges_churned,
    AVG(`monthly charge`) AS avg_monthly_charges_churned
FROM customer_churn
WHERE `Customer Status` = 'Churned';
         # THE DISTRIBUTION OF MONTHLY CHARGES AMONG EACH CHURNED CUSTOMERS = 81.10
         
#5.	Create a query to identify the contract types that are most prone to churn
SELECT 
    contract, 
    COUNT(*) AS churned_customers_count
FROM customer_churn
WHERE `Customer Status` = 'Churned'
GROUP BY contract
ORDER BY churned_customers_count DESC;
		# THE CONTRACT TYPE THAT ARE MOST PRONE TO CHURN IS MONTH-TO-MONTH CONTRACT TYPE
        
#6. Identify customers with high total charges who have churned
SELECT `Customer ID`, `total charges`
FROM customer_churn
WHERE `Customer Status` = 'Churned'
ORDER BY `total charges` DESC
LIMIT 10;

#7. Calculate the total charges distribution for churned and non-churned customers
SELECT 
    SUM(`total charges`) AS sum_total_charges_churned,
    AVG(`total charges`) AS avg_total_charges_churned
FROM customer_churn
WHERE `Customer Status` = 'Churned';
		#TOTAL CHARGES FOR CHURNED = 2726469, CHARGES FOR EACH = 1719.085
        
SELECT 
    SUM(`total charges`) AS sum_total_charges_stayed,
    AVG(`total charges`) AS avg_total_charges_stayed
FROM customer_churn
WHERE `Customer Status` != 'Churned';
		#TOTAL CHARGES FOR UNCHURNED = 11300430.84, CHARGES FOR EACH = 3478.12

#8.	Calculate the average monthly charges for different contract types among churned customers
SELECT 
    `contract`, 
    AVG(`monthly charge`) AS avg_monthly_charges
FROM customer_churn
WHERE `Customer Status` = 'Churned'
GROUP BY `contract`;
		# avg monthly charges for Month-to-Month = 79.44, One Year = 92.84 AND Two Year = 97.51
 
#9. Identify customers who have both online security and online backup services and have not churned 
SELECT `Customer ID`, `online security`, `online backup`
FROM customer_churn
WHERE `online security` = 'Yes'
  AND `online backup` = 'Yes'
  AND `Customer Status` != 'Churned';
  
SELECT *
FROM customer_churn
WHERE `online security` = 'Yes'
  AND `online backup` = 'Yes'
  AND `Customer Status` != 'Churned';

#10. Determine the most common combinations of services among churned customers


#11. Identify the average total charges for customers grouped by gender and marital status
SELECT 
    `Gender`, 
    `Married`, 
    AVG(`total charges`) AS avg_total_charges
FROM customer_churn
GROUP BY `Gender`, `Married`;

#12. Calculate the average monthly charges for different age groups among churned customers
SELECT 
    CASE 
        WHEN `Age` < 20 THEN 'Under 20'
        WHEN `Age` BETWEEN 20 AND 29 THEN '20-29'
        WHEN `Age` BETWEEN 30 AND 39 THEN '30-39'
        WHEN `Age` BETWEEN 40 AND 49 THEN '40-49'
        WHEN `Age` BETWEEN 50 AND 59 THEN '50-59'
        WHEN `Age` >= 60 THEN '60 and above'
    END AS age_group,
    AVG(`monthly charge`) AS avg_monthly_charges
FROM customer_churn
WHERE `Customer Status` = 'Churned'
GROUP BY age_group
ORDER BY age_group;

#13. Determine the average age and total charges for customers with multiple lines and online backup
SELECT 
    AVG(`Age`) AS avg_age,
    SUM(`total charges`) AS total_charges
FROM customer_churn
WHERE `Multiple Lines` = 'Yes' 
  AND `online backup` = 'Yes';
		#The average age and total charges for customers with multiple lines and online backup
        # Average age = 48.6115 And Total Charges = 6612503.850
        
#14. Identify the contract types with the highest churn rate among senior citizens (age 65 and over)
SELECT 
    `contract`,
    COUNT(CASE WHEN `Customer Status` = 'Churned' THEN 1 END) AS churned_count,
    COUNT(*) AS total_count,
    (COUNT(CASE WHEN `Customer Status` = 'Churned' THEN 1 END) / COUNT(*)) * 100 AS churn_rate
FROM customer_churn
WHERE `Age` >= 65
GROUP BY `contract`
ORDER BY churn_rate DESC;

#15. Calculate the average monthly charges for customers who have multiple lines and streaming TV
SELECT 
    AVG(`monthly charge`) AS avg_monthly_charges
FROM customer_churn
WHERE `Multiple Lines` = 'Yes' 
  AND `streaming tv` = 'Yes';
		#Average Monthly charges of customer who have multiple line and Streaming TV is 95.634
  
#16.  Identify the customers who have churned and used the most online services
SELECT 
    `Customer ID`,
    COUNT(CASE WHEN `online security` = 'Yes' THEN 1 END) +
    COUNT(CASE WHEN `online backup` = 'Yes' THEN 1 END) +
    COUNT(CASE WHEN `streaming tv` = 'Yes' THEN 1 END) +
    COUNT(CASE WHEN `streaming movies` = 'Yes' THEN 1 END) +
    COUNT(CASE WHEN `device protection plan` = 'Yes' THEN 1 END) +
    COUNT(CASE WHEN `premium tech support` = 'Yes' THEN 1 END) AS online_service_count
FROM customer_churn
WHERE `Customer Status` = 'Churned'
GROUP BY `Customer ID`
ORDER BY online_service_count DESC;

#17. Calculate the average age and total charges for customers with different combinations of streaming services
SELECT 
    CONCAT_WS(', ',
        CASE WHEN `streaming tv` = 'Yes' THEN 'Streaming TV' ELSE NULL END,
        CASE WHEN `streaming movies` = 'Yes' THEN 'Streaming Movies' ELSE NULL END
    ) AS streaming_service_combination,
    AVG(`Age`) AS avg_age,
    SUM(`total charges`) AS total_charges
FROM customer_churn
GROUP BY streaming_service_combination
ORDER BY streaming_service_combination;

#18.  Identify the gender distribution among customers who have churned and are on yearly contracts
SELECT 
    `Gender`, 
    COUNT(*) AS churned_count
FROM customer_churn
WHERE `Customer Status` = 'Churned' 
  AND `contract` = 'Yearly'
GROUP BY `Gender`;

