USE `bank_loan_ analysis`;
SELECT * FROM financial_loan;
/*Rename Columns
ï»¿Address State -> State
Good Loan vs Bad Loan Group -> `Loan Group`
Purpose -> `Loan Purpose`
Term --> `Term(Months)`
*/
ALTER TABLE financial_loan
CHANGE COLUMN `ï»¿Address State` `State` VARCHAR(100);

ALTER TABLE financial_loan
CHANGE COLUMN `Good Loan vs Bad Loan Group` `Loan Group` VARCHAR(200);

ALTER TABLE financial_loan
CHANGE COLUMN Term `Term (Months)` INT;

/*
Deleting redundant columns 
- Good Loan vs Bad Loan Group(Copy)
- Bad Loan Application Per
- Good Loan Application Per
- Total Bad Loans Disbursed
- Total Bad Loans Issued
- Total Bad Loans Repaid
- Total Good Loans Disbursed
- Total Good Loans Issued
- Total Good Loans Repaid
- Total Loan Disbured
- Total Payment
- Dynamic Measure
- Total Applications
- Average Interest Rate
- Average DTI
*/

ALTER TABLE financial_loan
DROP COLUMN `Good Loan vs Bad Loan Group (copy)`,
DROP COLUMN `Bad Loan Application Per`,
DROP COLUMN `Good Loan Application Per`,
DROP COLUMN `Total Bad Loans Disbursed`,
DROP COLUMN `Total Bad Loans Issued`,
DROP COLUMN `Total Bad Loans Repaid`,
DROP COLUMN `Total Good Loans Disbursed`,
DROP COLUMN `Total Good Loans Issued`,
DROP COLUMN `Total Good Loans Repaid`,
DROP COLUMN `Total Loan Disbursed`,
DROP COLUMN `Total Payment`,
DROP COLUMN `Dynamic Measure`;

ALTER TABLE financial_loan
DROP COLUMN `Total Applications`;

ALTER TABLE financial_loan
DROP COLUMN `Avearge DTI`,
DROP COLUMN `Avearge Interest Rate`;

-- Pulling unique values to detect inconsitency
SELECT DISTINCT `Verification Status`
FROM financial_loan;

-- Ensuring consistency by changing source verified to verified
UPDATE financial_loan
SET `Verification Status` = 'Verified'
WHERE `Verification Status` = 'Source Verified';
/*
Fix inconsistent columns in 
-- Terms --> Remove months after number
-- Emp Length --> Remove year(s)
*/
UPDATE financial_loan
SET Term = TRIM(REPLACE(Term, 'months', ''));

/*
Add a column that has Emp Length in range format
*/
ALTER TABLE financial_loan ADD COLUMN `Employment Length (Years)`VARCHAR(100);

UPDATE financial_loan
SET `Employment Length (Years)` = 
	CASE 
		WHEN `Emp Length` IN ('< 1 year', '1 year', '2 years') THEN '0-2'
        WHEN `Emp Length` IN ('3 years', '4 years', '5 years') THEN '3-5'
        WHEN `Emp Length` IN ('6 years', '7 years', '8 years') THEN '6-8'
        WHEN `Emp Length` IN ('9 years', '10+ years') THEN '9-10+'
	END;   

SELECT DISTINCT `Employment Length (Years)`, `Emp Length`
FROM financial_loan; 