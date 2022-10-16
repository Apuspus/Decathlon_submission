-- Create a local temporary table with all the columns from the Transaction Detail table as well as three
-- additional columns which can be derived from the Customer table
-- 1. Birthdate of the customer.
-- 2. Age of the customer.
-- 3. Age range that the customer belongs to:
	-- a. Teens: Below 20 YO.
	-- b. Young Adults: Below 40 YO.
	-- c. Adults: Below 60 YO.
	-- d. Seniors: 60 YO and above.

CREATE TEMPORARY TABLE cust_age
SELECT *, TIMESTAMPDIFF(YEAR, Birthdate, CURDATE()) AS Age,
CASE WHEN TIMESTAMPDIFF(YEAR, Birthdate, CURDATE()) < 20 THEN "Teens" 
	WHEN TIMESTAMPDIFF(YEAR, Birthdate, CURDATE()) >= 20 AND TIMESTAMPDIFF(YEAR, Birthdate, CURDATE()) < 40 THEN "Young Adults" 
	WHEN TIMESTAMPDIFF(YEAR, Birthdate, CURDATE()) >= 40 AND TIMESTAMPDIFF(YEAR, Birthdate, CURDATE()) < 60 THEN "Adults"
	WHEN TIMESTAMPDIFF(YEAR, Birthdate, CURDATE()) >= 60 THEN "Seniors"
END AS `Age Range`
FROM customer c
WHERE loyalty_card_num IS NOT NULL;

CREATE TEMPORARY TABLE `combined`
SELECT * 
FROM  `transaction` t
LEFT JOIN `cust_age` c 
ON t.ctm_customer_id = c.loyalty_card_num
;






