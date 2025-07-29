-- 1. Fraud Detection in Loan Applications
-- Goal: Detect fraudulent loan applications based on duplicate addresses, phone numbers, or unusual loan amounts.
-- Using CTE to find duplicate borrower details (potential fraud)
WITH Fraudulent_Loans AS (
    SELECT 
        address_state, 
        emp_title, 
        COUNT(id) AS Duplicate_Count
    FROM bank_loan_data
    GROUP BY address_state, emp_title
    HAVING COUNT(id) > 5 -- More than 5 applications with the same address and employment title
)
SELECT * FROM Fraudulent_Loans;

-- Creating stored procedures
-- Problem: Detect potential fraudulent loan applications where multiple users share the same address, phone number, or IP address.
-- Stored Procedure to Detect Potential Fraudulent Loan Applications
GO
CREATE PROCEDURE Detect_Fraudulent_Loans
AS
BEGIN
    SELECT 
        address_state, 
        COUNT(DISTINCT id) AS Total_Loans,
        COUNT(DISTINCT emp_title) AS Unique_Employers,
        COUNT(DISTINCT member_id) AS Unique_Customers
    FROM bank_loan_data
    GROUP BY address_state
    HAVING COUNT(DISTINCT member_id) > 5 -- More than 5 loans from the same address
       OR COUNT(DISTINCT emp_title) < COUNT(DISTINCT member_id) / 2 -- Many users with the same employer
END;
GO

EXEC Detect_Fraudulent_Loans;


--2. High-Risk Borrowers Analysis
-- Goal: Identify borrowers with high DTI and interest rates who are likely to default.
-- Using CTE to fetch high-risk borrowers
WITH High_Risk_Borrowers AS (
    SELECT 
        id, 
        loan_status, 
        dti * 100 AS DTI_Percentage, 
        int_rate * 100 AS Interest_Rate, 
        loan_amount, 
        annual_income
    FROM bank_loan_data
    WHERE dti > 0.25  -- High DTI > 40%
    AND int_rate > 0.15 -- Interest Rate > 15%
)
SELECT * FROM High_Risk_Borrowers
ORDER BY DTI_Percentage DESC, Interest_Rate DESC;


-- 3. Customer Retention & Churn Analysis
-- Goal: Identify customers at risk of stopping repayments (potential churn).
-- Identify customers who have missed multiple payments
WITH Churn_Customers AS (
    SELECT 
        id, 
        loan_status, 
        COUNT(*) AS Missed_Payments
    FROM bank_loan_data
    WHERE loan_status = 'Late' OR loan_status = 'Defaulted'
    GROUP BY id, loan_status
    HAVING COUNT(*) > 2 -- More than 2 late payments
)
SELECT * FROM Churn_Customers
ORDER BY Missed_Payments DESC;

-- stored procedure
-- Stored Procedure to Detect Potential Churn Customers
GO
CREATE PROCEDURE Detect_Churn_Customers
AS
BEGIN
    WITH Late_Payments AS (
        SELECT 
            id, 
            loan_status, 
            COUNT(*) AS Late_Payment_Count
        FROM bank_loan_data
        WHERE loan_status = 'Late (31-120 days)' OR loan_status = 'Charged Off'
        GROUP BY id, loan_status
    )
    SELECT 
        lp.id, 
        bl.annual_income, 
        bl.loan_amount, 
        bl.int_rate * 100 AS Interest_Rate, 
        lp.Late_Payment_Count
    FROM Late_Payments lp
    JOIN bank_loan_data bl ON lp.id = bl.id
    WHERE lp.Late_Payment_Count > 3 -- More than 3 late payments
    ORDER BY lp.Late_Payment_Count DESC;
END;
GO

EXEC Detect_Churn_Customers;

 --4. Loan Recovery Strategy Optimization
-- Goal: Identify defaulters with high outstanding balances for prioritizing collections.
-- Using a CTE to calculate outstanding balances
WITH Outstanding_Loans AS (
    SELECT top 10 
        id, 
        loan_status, 
        loan_amount, 
        total_payment, 
        (loan_amount - total_payment) AS Outstanding_Balance
    FROM bank_loan_data
    WHERE loan_status = 'Charged Off'
)
SELECT * FROM Outstanding_Loans
ORDER BY Outstanding_Balance DESC; -- Top 10 high-value defaulters

-- stored procedure
--Problem: Determine how much outstanding loan balance remains and the best recovery strategy.

GO
-- Stored Procedure to Calculate Outstanding Loan Balance for Recovery
CREATE PROCEDURE Loan_Recovery_Strategy
AS
BEGIN
    SELECT 
        id, 
        loan_status, 
        loan_amount - total_payment AS Outstanding_Balance,
        annual_income,
        CASE 
            WHEN loan_amount - total_payment > 5000 THEN 'Legal Action'
            WHEN loan_amount - total_payment BETWEEN 1000 AND 5000 THEN 'Negotiation'
            ELSE 'Small Claims Court'
        END AS Recovery_Strategy
    FROM bank_loan_data
    WHERE loan_status = 'Charged Off';
END;
GO

EXEC Loan_Recorvery_Strategy;

--5. Profitability Analysis for Loans
-- Goal: Identify which loan grades and terms generate the most profit.
-- Using CTE to calculate profits by grade
WITH Loan_Profitability AS (
    SELECT 
        grade, 
        term, 
        SUM(total_payment - loan_amount) AS Total_Profit
    FROM bank_loan_data
    GROUP BY grade, term
)
SELECT * FROM Loan_Profitability
ORDER BY Total_Profit DESC;

-- stored procedures
-- Stored Procedure to Analyze Loan Profitability
GO
CREATE PROCEDURE Loan_Profitability_Analysis
AS
BEGIN
    SELECT 
        grade, 
        term, 
        SUM(loan_amount) AS Total_Loan_Amount,
        SUM(total_payment) AS Total_Amount_Collected,
        (SUM(total_payment) - SUM(loan_amount)) AS Profit,
        (SUM(total_payment) - SUM(loan_amount)) * 100.0 / SUM(loan_amount) AS Profit_Percentage
    FROM bank_loan_data
    GROUP BY grade, term
    ORDER BY Profit_Percentage DESC;
END;
GO

EXEC Loan_Profitability_Analysis;

--  6. Late Payment Trend Analysis
-- Goal: Identify customers frequently making late payments.
-- Finding customers who made more than 3 late payments
WITH Late_Payers AS (
    SELECT 
        id, 
        COUNT(*) AS Late_Payment_Count
    FROM bank_loan_data
    WHERE loan_status = 'Late'
    GROUP BY id
    HAVING COUNT(*) > 3
)
SELECT * FROM Late_Payers;

--7. Customer Segmentation for Personalized Loan Offers
-- Goal: Segment customers based on their income, loan amounts, and interest rates.

-- Using CTE to create customer segments
WITH Customer_Segments AS (
    SELECT 
        id, 
        annual_income, 
        loan_amount, 
        int_rate, 
        CASE 
            WHEN annual_income > 100000 THEN 'Premium'
            WHEN annual_income BETWEEN 50000 AND 100000 THEN 'Standard'
            ELSE 'Basic'
        END AS Customer_Category
    FROM bank_loan_data
)
SELECT * FROM Customer_Segments;

-- Stored Procedure for Customer Segmentation
GO
CREATE PROCEDURE Customer_Segmentation
AS
BEGIN
    SELECT 
        id, 
        annual_income, 
        loan_amount, 
        int_rate * 100 AS Interest_Rate,
        CASE 
            WHEN annual_income > 100000 THEN 'Premium'
            WHEN annual_income BETWEEN 50000 AND 100000 THEN 'Mid-Tier'
            ELSE 'Budget'
        END AS Customer_Segment
    FROM bank_loan_data;
END;
GO

EXEC Customer_Segmentation;

-- 8. Dynamic Loan Default Probability Calculation
-- Goal: Compute risk scores dynamically using past payment behavior.

-- Creating a stored procedure for risk calculation
GO
CREATE PROCEDURE Calculate_Default_Risk
AS
BEGIN
    SELECT 
        id, 
        loan_status, 
        dti * 100 AS DTI_Percentage, 
        int_rate * 100 AS Interest_Rate, 
        loan_amount, 
        CASE 
            WHEN dti > 0.4 AND int_rate > 0.15 THEN 'High Risk'
            WHEN dti BETWEEN 0.2 AND 0.4 AND int_rate BETWEEN 0.1 AND 0.15 THEN 'Medium Risk'
            ELSE 'Low Risk'
        END AS Risk_Category
    FROM bank_loan_data;
END;
GO 

EXEC Calculate_Default_Risk;

-- 9. Optimizing Credit Line Adjustments Based on Spending Patterns
-- Goal: Recommend credit limit increases/decreases based on spending and repayments.

-- Using CTE to analyze spending patterns
WITH Credit_Usage AS (
    SELECT 
        id, 
        annual_income, 
        loan_amount, 
        (loan_amount / annual_income) * 100 AS Credit_Utilization
    FROM bank_loan_data
)
SELECT *, 
       CASE 
           WHEN Credit_Utilization < 20 THEN 'Increase Credit Line'
           WHEN Credit_Utilization BETWEEN 20 AND 50 THEN 'Maintain Credit Line'
           ELSE 'Reduce Credit Line'
       END AS Recommendation
FROM Credit_Usage;

-- 10. Unusual Loan Repayment Pattern Detection for Money Laundering
-- Goal: Identify suspicious repayments (large overpayments, multiple early repayments).

-- Using CTE to detect suspicious repayment patterns
WITH Suspicious_Repayments AS (
    SELECT 
        id, 
        loan_status, 
        total_payment, 
        loan_amount, 
        total_payment - loan_amount AS Excess_Payment
    FROM bank_loan_data
    WHERE total_payment > loan_amount * 1.5 -- Overpayment by 50%
)
SELECT * FROM Suspicious_Repayments
ORDER BY Excess_Payment DESC;

-- 11. Dynamic Risk-Based Loan Pricing Strategy
-- Problem: Assign personalized interest rates based on borrower risk.
-- Trigger to Adjust Interest Rates for Risk-Based Pricing
CREATE TRIGGER Adjust_Loan_Interest
ON bank_loan_data
AFTER INSERT
AS
BEGIN
    UPDATE bank_loan_data
    SET int_rate = 
        CASE 
            WHEN dti > 0.4 OR loan_status = 'Late (31-120 days)' THEN int_rate * 1.2 -- Increase for high-risk borrowers
            WHEN dti < 0.2 AND annual_income > 80000 THEN int_rate * 0.9 -- Discount for low-risk borrowers
            ELSE int_rate
        END
    WHERE id IN (SELECT id FROM inserted);
END;
