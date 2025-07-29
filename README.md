# 📊 Bank Loan Financial Analysis

## 🔍 Project Overview  
Bank loans play a pivotal role in financial growth, both for individuals and businesses. However, assessing loan applications, predicting risks, and optimizing lending strategies require **data-driven insights**. This project aims to **analyze bank loan data** using **SQL** and **Tableau**, providing **actionable insights** into lending trends, risk management, fraud detection, and customer segmentation.  

---


## 📈 Dashboards & Visualizations  
🎯 The project uses **Tableau Desktop** to create interactive visualizations for better decision-making.  

### 📊 Visualizations Included  
✔️ **Monthly Trends (Line Chart)** - Tracks total loan applications, funded amounts, and repayments.  
✔️ **Regional Analysis (Filled Map)** - Displays loan distribution across different states.  
✔️ **Loan Term Breakdown (Donut Chart)** - Shows the distribution of loan terms (36 months, 60 months).  
✔️ **Employment Length Analysis (Bar Chart)** - Assesses how borrower employment impacts lending decisions.  
✔️ **Loan Purpose Breakdown (Bar Chart)** - Visualizes why customers apply for loans.  
✔️ **Home Ownership Impact (Tree Map)** - Analyzes the relationship between home ownership and lending.  

---

## 🎯 Objectives  
- ✅ **Loan Portfolio Health Monitoring**: Track key performance indicators (KPIs) such as **total loans**, **funded amount**, and **repayments**.  
- ✅ **Fraud Detection in Loan Applications**: Identify suspicious patterns in loan applications.  
- ✅ **High-Risk Borrower Analysis**: Assess customers with a high probability of default.  
- ✅ **Customer Retention & Churn Analysis**: Analyze factors affecting customer loyalty.  
- ✅ **Late Payment Trend Analysis**: Understand trends in loan repayments and delinquencies.  
- ✅ **Dynamic Risk-Based Loan Pricing Strategy**: Use market data for real-time interest rate adjustments.  

---

## 🏗️ Tech Stack  
- **🗄️ Database**: Microsoft SQL (Advanced queries for data extraction and analysis)  
- **📊 Data Visualization**: Tableau (Interactive dashboards & insights)  
- **📜 Query Language**: SQL (Complex data processing & aggregation)  
- **💡 Business Intelligence**: Data-driven decision-making for risk assessment  
- **🔄 Transaction History Analysis**: Identifying repayment behaviors, anomalies, and fraudulent transactions using **SQL joins, aggregations, and analytical functions**.  

---
## 📊 Key Insights from Summary Statistics  

### 📌 **Annual Income Distribution**  
- **Mean income:** `$69,644`  
- **Wide variation:** Standard deviation of **$64,293** (possible outliers).  
- **Minimum income:** `$4,000`, **Maximum:** extremely high values.  

### 📌 **Debt-to-Income (DTI) Ratio**  
- **Mean:** `13.3%`, indicating a **moderate debt burden**.  
- Some borrowers have **0% DTI** (possible anomalies).  

### 📌 **Interest Rate Analysis**  
- **Mean:** `12.05%`, with a **standard deviation of 3.7%**.  
- **Minimum:** `5.42%`, **Maximum:** over `20%`, indicating **risk-based pricing**.  

### 📌 **Loan Amounts**  
- **Mean loan:** `$11,296`  
- **Minimum loan:** `$500`, **Maximum:** significantly high values exist.  

### 📌 **Installments & Total Payments**  
- **Average installment:** `$326` per month.  
- Some loans have **very small payments**, indicating **short-term loans**.  

---


## 📂 Dataset Overview  
The dataset includes crucial information on **loan applications, borrower details, repayment history, and financial indicators.**  

### 🔑 Key Features in the Dataset  
| Feature | Description |
|---------|------------|
| `loan_id` | Unique identifier for each loan application |
| `loan_amount` | Total loan amount requested by the borrower |
| `int_rate` | Interest rate assigned to the loan |
| `dti` | Debt-to-Income ratio of the borrower |
| `loan_status` | Status of the loan (e.g., Fully Paid, Current, Charged Off) |
| `issue_date` | Date when the loan was issued |
| `total_payment` | Total amount paid by the borrower |
| `home_ownership` | Ownership status of the borrower's residence |
| `emp_length` | Length of employment of the borrower |
| `purpose` | Reason for taking the loan |

---

## 📊 Dashboards & Insights  
### 📌 Key Performance Indicators (KPIs)  
1. **Total Loan Applications** 📈  
   - `SELECT COUNT(id) AS Total_Applications FROM bank_loan_data`  
2. **Total Funded Amount** 💰  
   - `SELECT SUM(loan_amount) AS Total_Funded_Amount FROM bank_loan_data`  
3. **Total Amount Received** 💵  
   - `SELECT SUM(total_payment) AS Total_Amount_Collected FROM bank_loan_data`  
4. **Average Interest Rate** 📊  
   - `SELECT AVG(int_rate)*100 AS Avg_Int_Rate FROM bank_loan_data`  
5. **Average Debt-to-Income Ratio (DTI)** 🏦  
   - `SELECT AVG(dti)*100 AS Avg_DTI FROM bank_loan_data`  

---

## 🚀 Advanced Analytics & Real-World Use Cases  
This project applies **advanced SQL** to solve **real-world banking challenges**, such as:  

- 🔍 **Fraud Detection in Loan Applications** (Detect unusual loan requests)  
- 🚨 **High-Risk Borrowers Analysis** (Identify risky customers with high default rates)  
- 📉 **Customer Retention & Churn Analysis** (Predict customer behavior & reduce attrition)  
- 🔄 **Loan Recovery Strategy Optimization** (Enhance collection strategies)  
- 💰 **Profitability Analysis for Loans** (Assess which loan types generate maximum revenue)  
- 🏦 **Late Payment Trend Analysis** (Detect patterns in delayed repayments)  
- 🎯 **Dynamic Loan Default Probability Calculation (Machine Learning Support)**  
- 📈 **Optimizing Loan Interest Rates Using Market Data**  

---

## 📌 Future Enhancements
- 🛠️ Incorporate Machine Learning for loan default prediction
- 📊 Build more interactive dashboards with real-time data integration
- 🚀 Optimize risk-based pricing models to adjust interest rates dynamically
- 🔄 Improve fraud detection mechanisms with AI-driven anomaly detection

### 🚀 Happy Analyzing! Let’s make better financial decisions with data! 💡📊
