-- 1. Annual Income Distribution
-- Find Mean, Standard Deviation, Minimum, and Maximum Annual Income

SELECT 
    ROUND(AVG(annual_income),2) AS Mean_Annual_Income, 
    ROUND(STDEV(annual_income),2) AS Std_Dev_Annual_Income, 
    MIN(annual_income) AS Min_Annual_Income, 
    MAX(annual_income) AS Max_Annual_Income
FROM bank_loan_data;

-- 2. Debt-to-Income (DTI) Ratio
-- Find Mean DTI and Count of Borrowers with 0% DTI
SELECT 
    ROUND(AVG(dti) * 100,2) AS Mean_DTI_Percentage, 
    COUNT(*) AS Total_Borrowers,
    SUM(CASE WHEN dti = 0 THEN 1 ELSE 0 END) AS Zero_DTI_Borrowers
FROM bank_loan_data;

--3. Interest Rate Analysis
-- Find Mean, Standard Deviation, Minimum, and Maximum Interest Rate

SELECT 
    ROUND(AVG(int_rate) * 100,2) AS Mean_Interest_Rate, 
    ROUND(STDEV(int_rate) * 100,2) AS Std_Dev_Interest_Rate, 
    ROUND(MIN(int_rate) * 100,2) AS Min_Interest_Rate, 
    ROUND(MAX(int_rate) * 100,2) AS Max_Interest_Rate
FROM bank_loan_data;

-- 4. Loan Amount Analysis
-- Find Mean, Minimum, and Maximum Loan Amount
SELECT 
    AVG(loan_amount) AS Mean_Loan_Amount, 
    MIN(loan_amount) AS Min_Loan_Amount, 
    MAX(loan_amount) AS Max_Loan_Amount
FROM bank_loan_data;

--5. Installments & Total Payments
-- Find Average Monthly Installment
SELECT 
    AVG(installment) AS Avg_Installment, 
    MIN(installment) AS Min_Installment, 
    MAX(installment) AS Max_Installment
FROM bank_loan_data;

--Find Total and Average Loan Payments
SELECT 
    AVG(total_payment) AS Avg_Total_Payment, 
    SUM(total_payment) AS Total_Amount_Received
FROM bank_loan_data;
