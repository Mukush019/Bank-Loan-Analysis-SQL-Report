# Loan Analysis Report
---

## Project Overview

This project analyzes a 2021 financial loan dataset to derive key performance indicators (KPIs) and trends, enabling data-driven lending decisions. Using MySQL, it calculates total loan applications, disbursed amounts, repayment rates, interest rates, and debt-to-income (DTI) ratios, with segmentations by month, region, loan term, employment length, purpose, and home ownership. Designed for financial institutions and data analysts, the analysis distinguishes between good and bad loans to highlight risk factors. By identifying high-demand regions and seasonal patterns, the project supports optimized lending strategies and improved risk management. Custom SQL queries ensure efficient processing of large-scale financial data.

## Data Sources

**Dataset**: The dataset is stored in a MySQL database under the schema `bank_loan_analysis`, in a table named `financial_loan`. [View Here](https://drive.google.com/file/d/1NOl-nRWsnT0l0uitDXp8yKLTpYz45P-1/view?usp=sharing)

**Key Columns**:
  - `Id`: Unique identifier for each loan application.
  - `Issue Date`: Date the loan was issued (converted from text to DATE format).
  - `Loan Amount`: Amount disbursed for the loan.
  - `Total Payment`: Amount repaid by the borrower.
  - `Int Rate`: Interest rate of the loan.
  - `DTI`: Debt-to-income ratio of the borrower.
  - `Loan Status`: Status of the loan (e.g., Fully Paid, Current, Charged Off).
  - `Address State`: State of the borrower's address.
  - `Term`: Loan term (e.g., short-term or long-term).
  - `Emp Length`: Employment length of the borrower.
  - `Purpose`: Purpose of the loan (e.g., debt consolidation, home improvement).
  - `Home Ownership`: Borrower's home ownership status (e.g., Rent, Own, Mortgage).

## Tools

- **MySQL**: Used for data storage, querying, and analysis.
- **GitHub**: This is for version control and project documentation.

## Data Cleaning

 - **Date Conversion**: The `Issue Date` column was converted from text format (`%d/%m/%Y`) to MySQL DATE format using:
  ```sql
  UPDATE financial_loan
  SET `Issue Date` = STR_TO_DATE(`Issue Date`, '%d/%m/%Y');
 ```
 This ensured accurate date-based filtering for month-to-date (MTD) and prior month-to-date (PMTD) calculations.
 
- **Data Integrity**: The dataset was assumed to be clean, with no additional steps for handling missing values or duplicates explicitly mentioned in the script.

## Data Analysis









## Results and Findings

- **Loan Volume**: The dataset contains a significant number of loan applications in 2021, with specific counts for December (MTD) and November (PMTD), indicating seasonal trends in loan demand.

- **Disbursement and Repayment**: Total disbursed amounts and repayments provide insights into lending scale and recovery rates. Good loans (Fully Paid or Current) dominate, but bad loans (Charged Off) represent a notable portion, highlighting risk exposure.

- **Interest Rates and DTI**: Average interest rates and DTI ratios vary by month and loan status, with potential implications for borrower affordability and risk.

### *Segmented Insights*:
---
- **Regional**: Certain states have higher loan volumes and disbursed amounts, suggesting geographic concentration of demand or risk.

- **Term and Purpose**: Short-term loans and specific purposes (e.g., debt consolidation) may dominate disbursements, indicating borrower preferences.

- **Employment and Ownership**: Longer employment durations and specific home ownership statuses (e.g., Mortgage) correlate with higher loan volumes.

## Recommendation

- **Risk Management**:
  - Focus on reducing the percentage of bad loans by tightening credit assessment for high-risk states or borrower segments with high DTI ratios.
  - Monitor interest rate trends to ensure competitive yet sustainable pricing.

- **Targeted Lending**:
  - Increase marketing efforts in high-demand states identified in the regional analysis.
  - Tailor loan products to popular purposes (e.g., debt consolidation) and terms to attract more qualified borrowers.

- **Seasonal Strategies**:
  - Leverage monthly trends to anticipate peak loan demand periods (e.g., December) and allocate resources accordingly.

- **Data Enhancement**:
  - Incorporate additional data cleaning steps to handle potential missing or inconsistent data (e.g., null values in `Loan Status` or `Issue Date`).
  - Include more granular borrower demographics (e.g., credit score, income) for deeper risk analysis.

- **Visualization**:
  - Use visualization tools (e.g., Tableau, Power BI) to create dashboards for stakeholders, highlighting KPIs like good/bad loan percentages and regional trends.


