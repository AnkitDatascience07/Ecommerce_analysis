# 🛒 Target Brazil E-commerce Analysis: SQL Business Intelligence Study

**Comprehensive analysis of 100,000+ Target orders from Brazil to drive operational excellence and business growth**

![SQL](https://img.shields.io/badge/SQL-BigQuery-blue)
![Status](https://img.shields.io/badge/Status-Complete-success)
![License](https://img.shields.io/badge/License-MIT-green)
![Analysis](https://img.shields.io/badge/Analysis-Business_Intelligence-orange)

## 📋 Table of Contents
- [Business Context](#business-context)
- [Dataset Overview](#dataset-overview)
- [Key Business Questions](#key-business-questions)
- [Technical Implementation](#technical-implementation)
- [Key Findings](#key-findings)
- [Business Recommendations](#business-recommendations)
- [Repository Structure](#repository-structure)
- [How to Reproduce](#how-to-reproduce)
- [Technologies Used](#technologies-used)
- [Connect With Me](#connect-with-me)

## 🎯 Business Context

Target, a leading global retailer, expanded operations to Brazil between 2016-2018. This analysis examines their e-commerce performance across multiple dimensions to identify growth opportunities and operational improvements.

**Business Challenge:** How can Target optimize its Brazilian operations to increase revenue, improve customer satisfaction, and enhance delivery performance?

**Analytical Approach:** Comprehensive SQL-driven analysis of order patterns, customer behavior, geographical trends, and operational metrics using Google BigQuery.

## 📊 Dataset Overview

| Table | Records | Description |
|-------|---------|-------------|
| `orders` | 99,441 | Order transactions and status tracking |
| `customers` | 99,441 | Customer demographics and geographic data |
| `order_items` | 112,650 | Product details and pricing per order |
| `payments` | 103,886 | Payment methods and transaction values |
| `products` | 32,951 | Product catalog and specifications |
| `sellers` | 3,095 | Seller information and locations |
| `geolocation` | 1,000,163 | Brazilian postal code coordinates |
| `order_reviews` | 99,224 | Customer satisfaction ratings |

**Analysis Period:** September 2016 - October 2018  
**Geographic Scope:** All 27 Brazilian states  
**Data Volume:** 100,000+ orders, 1M+ location records

## ❓ Key Business Questions Addressed

### 1. **Market Growth & Trends**
- Is there sustained growth in order volume over time?
- What seasonal patterns drive peak demand?
- When do Brazilian customers prefer to shop online?

### 2. **Geographic Performance**
- How are customers distributed across Brazilian states?
- Which regions show the highest growth potential?
- What are month-on-month ordering patterns by location?

### 3. **Economic Impact**
- What was the revenue growth from 2017 to 2018?
- Which states generate the highest order values?
- How do logistics costs vary by region?

### 4. **Operational Efficiency**
- What are average delivery times by state?
- How accurate are delivery estimates vs actual performance?
- Which regions need logistics optimization?

### 5. **Payment Behavior**
- How do payment method preferences evolve over time?
- What is the adoption rate of installment payments?
- Which payment types drive higher order values?

## 🔧 Technical Implementation

### **Platform & Tools**
- **Database:** Google BigQuery
- **Language:** Standard SQL
- **Data Processing:** 1.2GB across 8 interconnected tables
- **Analysis Depth:** 6 comprehensive business phases

### **Advanced SQL Techniques**
- **Complex Multi-table Joins:** 8-table relationship mapping
- **Window Functions:** Growth calculations, ranking, and time-series analysis  
- **Common Table Expressions (CTEs):** Modular query organization
- **Date/Time Functions:** Seasonal trend analysis and delivery performance
- **Geographic Aggregations:** State and city-level business metrics
- **Statistical Analysis:** Percentile calculations and variance analysis

## 📈 Key Findings

### **Business Growth Metrics**
- **Order Volume:** 847% increase from September 2016 to August 2018
- **Revenue Growth:** 135.6% year-over-year increase (2017-2018)
- **Peak Performance:** August shows highest monthly order volume (10,843 orders)
- **Customer Expansion:** Active presence across all 27 Brazilian states

### **Geographic Insights**
- **Market Leadership:** São Paulo (SP) accounts for 41.7% of total customers
- **Market Concentration:** Top 5 states represent 76.8% of all orders
- **Growth Opportunity:** 17 states with less than 1% market penetration
- **Urban Focus:** Metropolitan areas show 3x higher order density

### **Operational Performance**
- **Delivery Accuracy:** 96.5% of orders delivered within estimated timeframe
- **Average Delivery Time:** 12.5 days with significant regional variation
- **Peak Shopping Hours:** 10 AM - 4 PM (Brazilian afternoon preference)
- **Logistics Efficiency:** 15% cost variation between best and worst performing states

### **Financial Patterns**
- **Payment Preferences:** Credit cards dominate (73.9% of transactions)
- **Installment Adoption:** 24% of customers use payment plans
- **Average Order Value:** R$ 137.75 with regional variations
- **Freight Optimization:** Potential 12% cost savings through logistics improvements

## 🎯 Business Recommendations

### **Immediate Actions (0-3 months)**
1. **Inventory Planning:** Increase stock levels for August peak season demand
2. **Payment Expansion:** Enhance installment payment options (currently 24% adoption)
3. **Delivery Focus:** Prioritize logistics improvements in bottom 5 performing states

### **Strategic Initiatives (3-12 months)**
1. **Geographic Expansion:** Target underrepresented states with <1% market share
2. **Regional Partnerships:** Establish local fulfillment centers in high-growth areas
3. **Customer Experience:** Implement state-specific delivery and pricing strategies
4. **Technology Investment:** Deploy predictive analytics for demand forecasting

### **Expected Business Impact**
- **Revenue Growth:** 15-20% increase through geographic expansion
- **Customer Satisfaction:** 10% improvement in delivery performance scores
- **Market Share:** Capture additional 5% in underserved regions
- **Operational Efficiency:** 12% reduction in logistics costs

## 📁 Repository Structure

```
target-brazil-ecommerce-analysis/
├── README.md                              # Project overview and findings
├── sql/
│   └── complete_analysis.sql              # Complete BigQuery analysis
├── docs/
│   ├── business_context.md                # Detailed business background
│   ├── insights_summary.md                # Executive summary of findings
│   └── data_dictionary.md                 # Database schema reference
├── results/
│   └── sample_outputs.md                  # Key query results
└── LICENSE                                # MIT License
```


## 🤝 Connect With Me

- **LinkedIn:** [Your LinkedIn Profile]
- **Email:** [Your Email]
- **Portfolio:** [Your Portfolio Website]
- **GitHub:** [Your GitHub Profile]

---

*This project demonstrates proficiency in business intelligence, advanced SQL analysis, and strategic recommendation development using real-world e-commerce data.*
