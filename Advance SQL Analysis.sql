-- 1. Identifying High-Risk Borrowers
-- Borrowers with High DTI and High Interest Rate
-- This identifies borrowers who have a high debt burden and are paying high interest rates, making them high-risk.
SELECT 
    id, 
    loan_status, 
    dti * 100 AS DTI_Percentage, 
    int_rate * 100 AS Interest_Rate, 
    loan_amount, 
    annual_income
FROM bank_loan_data
WHERE dti > 0.25  -- Borrowers with DTI above 25%
AND int_rate > 0.15 -- Interest Rate above 15%
ORDER BY dti DESC, int_rate DESC;

-- 2. State-wise Loan Defaults
-- Which states have the highest percentage of charged-off loans?
-- Helps identify states with high default rates, useful for risk mitigation.
SELECT 
    address_state AS State, 
    COUNT(id) AS Total_Loan_Applications,
    SUM(CASE WHEN loan_status = 'Charged Off' THEN 1 ELSE 0 END) AS Charged_Off_Count,
    (SUM(CASE WHEN loan_status = 'Charged Off' THEN 1 ELSE 0 END) * 100.0) / COUNT(id) AS Default_Percentage
FROM bank_loan_data
GROUP BY address_state
ORDER BY Default_Percentage DESC;

--3. Loan Trends Over Time
-- How do loan applications vary by month?
-- Identifies seasonal trends in loan applications and funding.
SELECT 
    YEAR(issue_date) AS Year, 
    MONTH(issue_date) AS Month, 
    COUNT(id) AS Total_Loan_Applications, 
    SUM(loan_amount) AS Total_Funded_Amount
FROM bank_loan_data
GROUP BY YEAR(issue_date), MONTH(issue_date)
ORDER BY Year DESC, Month DESC;

--4. Loan Performance by Employment Length
-- Does employment length impact loan defaults?
--  Shows whether shorter employment history leads to higher default risk.
SELECT 
    emp_length AS Employment_Length, 
    COUNT(id) AS Total_Loan_Applications, 
    SUM(CASE WHEN loan_status = 'Charged Off' THEN 1 ELSE 0 END) AS Charged_Off_Count,
    (SUM(CASE WHEN loan_status = 'Charged Off' THEN 1 ELSE 0 END) * 100.0) / COUNT(id) AS Default_Percentage
FROM bank_loan_data
GROUP BY emp_length
ORDER BY Default_Percentage DESC;

--5. Homeownership Impact on Loan Repayment
-- Does owning a home reduce default risk?
-- Evaluates whether homeowners are more reliable borrowers than renters.
SELECT 
    home_ownership AS Home_Ownership, 
    COUNT(id) AS Total_Loan_Applications, 
    SUM(CASE WHEN loan_status = 'Charged Off' THEN 1 ELSE 0 END) AS Charged_Off_Count,
    (SUM(CASE WHEN loan_status = 'Charged Off' THEN 1 ELSE 0 END) * 100.0) / COUNT(id) AS Default_Percentage
FROM bank_loan_data
GROUP BY home_ownership
ORDER BY Default_Percentage DESC;

--6. Loan Performance by Verification Status
-- Do verified incomes reduce loan defaults?
-- Checks if income verification plays a role in loan repayment success.
SELECT 
    verification_status, 
    COUNT(id) AS Total_Loan_Applications, 
    SUM(CASE WHEN loan_status = 'Charged Off' THEN 1 ELSE 0 END) AS Charged_Off_Count,
    (SUM(CASE WHEN loan_status = 'Charged Off' THEN 1 ELSE 0 END) * 100.0) / COUNT(id) AS Default_Percentage
FROM bank_loan_data
GROUP BY verification_status
ORDER BY Default_Percentage DESC;

--7. Loan Performance by Purpose
-- Which loan purposes have the highest default rates?
-- Identifies which loan purposes (e.g., debt consolidation, credit card, home improvement) have the highest defaults.
SELECT 
    purpose, 
    COUNT(id) AS Total_Loan_Applications, 
    SUM(CASE WHEN loan_status = 'Charged Off' THEN 1 ELSE 0 END) AS Charged_Off_Count,
    (SUM(CASE WHEN loan_status = 'Charged Off' THEN 1 ELSE 0 END) * 100.0) / COUNT(id) AS Default_Percentage
FROM bank_loan_data
GROUP BY purpose
ORDER BY Default_Percentage DESC;

-- 8. High-Risk Borrowers Based on Loan Grades
-- Which loan grades have the highest default rates?
SELECT 
    grade, 
    COUNT(id) AS Total_Loan_Applications, 
    SUM(CASE WHEN loan_status = 'Charged Off' THEN 1 ELSE 0 END) AS Charged_Off_Count,
    (SUM(CASE WHEN loan_status = 'Charged Off' THEN 1 ELSE 0 END) * 100.0) / COUNT(id) AS Default_Percentage
FROM bank_loan_data
GROUP BY grade
ORDER BY Default_Percentage DESC;


-- 9. High-Risk Borrowers Based on Loan Term
-- Do longer-term loans have higher default rates?
-- Longer-term loans (e.g., 60 months) might be riskier than short-term loans (36 months).
SELECT 
    term, 
    COUNT(id) AS Total_Loan_Applications, 
    SUM(CASE WHEN loan_status = 'Charged Off' THEN 1 ELSE 0 END) AS Charged_Off_Count,
    (SUM(CASE WHEN loan_status = 'Charged Off' THEN 1 ELSE 0 END) * 100.0) / COUNT(id) AS Default_Percentage
FROM bank_loan_data
GROUP BY term
ORDER BY Default_Percentage DESC;

-- 10. Identifying Top Defaulters
-- Who are the top 10 borrowers with the highest outstanding balances?
SELECT TOP 10 
    id, 
    annual_income, 
    loan_amount, 
    total_payment, 
    (loan_amount - total_payment) AS Outstanding_Balance
FROM bank_loan_data
WHERE loan_status = 'Charged Off'
ORDER BY Outstanding_Balance DESC;
