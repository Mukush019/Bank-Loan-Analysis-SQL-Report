SELECT * FROM Bank_loan_data;
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Total loan applications 
SELECT 
	COUNT(B.id) AS Total_loan_applications
FROM Bank_loan_data B;

-- MTD Total loan Applications
SELECT 
	COUNT(B.id) AS MTD_Total_loan_applications
FROM Bank_loan_data B
WHERE MONTH(B.issue_date) = 12;

-- PMTD Total loan applications
SELECT 
	COUNT(B.id) AS PMTD_Total_loan_applications
FROM Bank_loan_data B
WHERE MONTH(B.issue_date) = 11;

-- Total Loan Disbursed 
SELECT 
	SUM(B.loan_amount) AS Total_Loan_Disbursed 
FROM Bank_loan_data B;
 -- MTD Total loan Disbursed
 SELECT 
	SUM(B.loan_amount) AS MTD_Total_Loan_Disbursed 
FROM Bank_loan_data B
WHERE MONTH(B.issue_date) = 12;

-- PMTD Total Loan Disbursed 
SELECT 
	SUM(B.loan_amount) AS PMTD_Total_Loan_Disbursed 
FROM Bank_loan_data B
WHERE MONTH(B.issue_date) = 11;

-- Total Loan Amount Repaid
SELECT 
	SUM(B.total_payment) AS Total_Loan_Repaid 
FROM Bank_loan_data B;

-- MTD Total Loan Amount Repaid
SELECT 
	SUM(B.total_payment) AS MTD_Total_Loan_Repaid 
FROM Bank_loan_data B
WHERE MONTH(B.issue_date) = 12;

-- PMTD Total Loan Amount Repaid
SELECT 
	SUM(B.total_payment) AS PMTD_Total_Loan_Repaid 
FROM Bank_loan_data B
WHERE MONTH(B.issue_date) = 11;

-- Average interest rate 
SELECT 
	ROUND(AVG(B.int_rate),4)*100 AS "Average Interest Rate"
FROM Bank_loan_data B;

-- MTD Average interest rate 
SELECT 
	ROUND(AVG(B.int_rate),4)*100 AS "MTD Average Interest Rate"
FROM Bank_loan_data B
WHERE MONTH(B.issue_date) = 12;

-- PMTD Average interest rate 
SELECT 
	ROUND(AVG(B.int_rate),4)*100 AS "PMTD Average Interest Rate"
FROM Bank_loan_data B
WHERE MONTH(B.issue_date) = 11;

-- Average DTI 
SELECT 
	ROUND(AVG(B.dti),4)*100 AS "Average DTI"
FROM Bank_loan_data B;

-- MTD Average DTI 
SELECT 
	ROUND(AVG(B.dti),4)*100 AS "MTD Average DTI"
FROM Bank_loan_data B
WHERE MONTH(B.issue_date) = 12;

-- PMTD Average DTI 
SELECT 
	ROUND(AVG(B.dti),4)*100 AS "PMTD Average DTI"
FROM Bank_loan_data B
WHERE MONTH(B.issue_date) = 11;

-- Good Loan Percent
SELECT 
	COUNT(	
		CASE 
			WHEN 
				(B.loan_status = 'Fully Paid'
				 OR
				B.loan_status = 'Current')
			THEN B.id END)*100
			/
	COUNT(
		B.id
		 ) AS "Good Loan Percent"
FROM Bank_loan_data B

--Total Good Loan Applications
SELECT 
	COUNT(	
		CASE 
			WHEN 
				(B.loan_status = 'Fully Paid'
				 OR
				B.loan_status = 'Current')
			THEN B.id END)
	 AS "Good Loan Applications"
FROM Bank_loan_data B;

-- Amount of Good Loan Disbursed 
SELECT 
	SUM(B.loan_amount) AS "Total Good Loan Disbursed" 
FROM Bank_loan_data B
WHERE B.loan_status = 'Fully Paid'
	OR
	  B.loan_status = 'Current';

-- Good Loan paid
SELECT 
	SUM(B.total_payment) AS "Total Good Loan Repaid" 
FROM Bank_loan_data B
WHERE B.loan_status = 'Fully Paid'
	OR
	  B.loan_status = 'Current';

-- Bad Loan Percent
SELECT 
	COUNT(	
		CASE 
			WHEN 
				(B.loan_status = 'Charged Off'
				)
			THEN B.id END)*100
			/
	COUNT(
		B.id
		 ) AS "Bad Loan Percent"
FROM Bank_loan_data B;

--Total Bad Loan Applications
SELECT 
	COUNT(	
		CASE 
			WHEN 
				(B.loan_status = 'Charged Off'
				 )
			THEN B.id END)
	 AS "Bad Loan Applications"
FROM Bank_loan_data B;

-- Amount of Bad Loan Disbursed 
SELECT 
	SUM(B.loan_amount) AS "Total Bad Loan Disbursed" 
FROM Bank_loan_data B
WHERE B.loan_status = 'Charged Off';

-- Bad Loan paid
SELECT 
	SUM(B.total_payment) AS "Total Bad Loan Repaid" 
FROM Bank_loan_data B
WHERE B.loan_status = 'Charged Off';

-- Loan status grid view
SELECT 
	B.loan_status,
	COUNT(B.id) AS "Total loan Application",
	SUM (B.loan_amount) AS "Total Loan Disbursed",
	ROUND(AVG(B.int_rate*100),4) AS "Average Interest Rate",
	ROUND(AVG(B.dti*100),4) AS "Average dti"
FROM Bank_loan_data B
GROUP BY B.loan_status;

-- MTD Loan status grid view
SELECT 
	B.loan_status,
	COUNT(B.id) AS "MTD Total loan Application",
	SUM (B.loan_amount) AS "MTD Total Loan Disbursed",
	ROUND(AVG(B.int_rate*100),4) AS "MTD Average Interest Rate",
	ROUND(AVG(B.dti*100),4) AS "MTD Average dti"
FROM Bank_loan_data B
WHERE MONTH(B.issue_date) = 12
GROUP BY B.loan_status;

-- PMTD Loan status grid view
SELECT 
	B.loan_status,
	COUNT(B.id) AS "PMTD Total loan Application",
	SUM (B.loan_amount) AS "PMTD Total Loan Disbursed",
	ROUND(AVG(B.int_rate*100),4) AS "PMTD Average Interest Rate",
	ROUND(AVG(B.dti*100),4) AS "PMTD Average dti"
FROM Bank_loan_data B
WHERE MONTH(B.issue_date) = 11
GROUP BY B.loan_status;

-- Monthly loan issued 
SELECT 
	MONTH(B.issue_date) "Month Number",
	DATENAME(MONTH, B.issue_date) AS "Month of Loan issue",
	COUNT(B.id) AS "Total loan Application",
	SUM (B.loan_amount) AS "Total Loan Disbursed"
FROM Bank_loan_data B
GROUP BY MONTH(B.issue_date), DATENAME(MONTH, B.issue_date)
ORDER BY MONTH(B.issue_date);

-- Regional Analysis by state
SELECT 
	B.address_state,
	COUNT(B.id) AS "Total loan Application",
	SUM (B.loan_amount) AS "Total Loan Disbursed"
FROM Bank_loan_data B
GROUP BY B.address_state
ORDER BY SUM (B.loan_amount) DESC;

-- Total Applications by Term
SELECT 
	B.term,
	COUNT(B.id) AS "Total loan Application",
	SUM (B.loan_amount) AS "Total Loan Disbursed"
FROM Bank_loan_data B
GROUP BY B.term
ORDER BY SUM (B.loan_amount) DESC;

-- Total Applications by employee length
SELECT 
	B.emp_length,
	COUNT(B.id) AS "Total loan Application",
	SUM (B.loan_amount) AS "Total Loan Disbursed"
FROM Bank_loan_data B
GROUP BY B.emp_length
ORDER BY SUM (B.loan_amount) DESC;

-- Total Applications by Purpose
SELECT 
	B.purpose,
	COUNT(B.id) AS "Total loan Application",
	SUM (B.loan_amount) AS "Total Loan Disbursed"
FROM Bank_loan_data B
GROUP BY B.purpose
ORDER BY SUM (B.loan_amount) DESC;

-- Total Applications by home ownership
SELECT 
	B.home_ownership,
	COUNT(B.id) AS "Total loan Application",
	SUM (B.loan_amount) AS "Total Loan Disbursed"
FROM Bank_loan_data B
GROUP BY B.home_ownership
ORDER BY SUM (B.loan_amount) DESC;