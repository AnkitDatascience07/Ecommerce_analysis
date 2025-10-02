# 🛒 Target Brazil E-commerce Analysis: SQL Business Intelligence Case Study

**End-to-end SQL-driven business intelligence project analyzing 100,000+ e-commerce orders from Target’s Brazilian operations (2016–2018).**  

![SQL](https://img.shields.io/badge/SQL-BigQuery-blue)  
![Cloud](https://img.shields.io/badge/Google-Cloud-orange?logo=googlecloud)  
![Status](https://img.shields.io/badge/Status-Complete-success)  
![License](https://img.shields.io/badge/License-MIT-green)  
![Analysis](https://img.shields.io/badge/Focus-Business_Intelligence-orange)

---

## 📌 Executive Summary  
This project uses **Google BigQuery + advanced SQL** to analyze Target’s e-commerce expansion in Brazil. Covering 1M+ records across 8 related tables, it provides insights on **market growth, logistics, payment behavior**, and delivers **strategic recommendations**.

---

## 📋 Table of Contents  
- [Business Context](#business-context)  
- [Dataset Overview](#dataset-overview)  
- [Entity Relationship Diagram](#entity-relationship-diagram)  
- [Key Business Questions](#key-business-questions)  
- [Technical Implementation](#technical-implementation)  
- [Key Findings](#key-findings)  
- [Business Recommendations](#business-recommendations)  
- [Repository Structure](#repository-structure)  
- [How to Reproduce](#how-to-reproduce)  
- [Technologies Used](#technologies-used)  
- [Limitations & Next Steps](#limitations--next-steps)  
- [Connect With Me](#connect-with-me)

---

## 🎯 Business Context  
Target expanded into Brazil between 2016–2018. The goal is to analyze how operations can be optimized to increase revenue, improve delivery, and boost customer loyalty.

---

## 📊 Dataset Overview  
| Table | Records | Description |
|---|---|---|
| `orders` | 99,441 | Order lifecycle data |
| `customers` | 99,441 | Customer demographics & location |
| `order_items` | 112,650 | Items per order, seller, price |
| `payments` | 103,886 | Payment methods and values |
| `products` | 32,951 | Product catalog |
| `sellers` | 3,095 | Seller metadata |
| `geolocation` | 1,000,163 | Postal codes with lat/long |
| `order_reviews` | 99,224 | Customer feedback and ratings |

**Period:** Sep 2016 – Oct 2018  
**Scope:** 27 Brazilian states | **Size:** 1M+ records total  

---

## 📌 Entity Relationship Diagram  
![ERD](Database%20Schema%20Diagram.png)  

---

## ❓ Key Business Questions  
1. Market Growth → How have orders & revenue trended over time?  
2. Geographic Reach → Which states are underpenetrated or saturated?  
3. Delivery Efficiency → Are deliveries meeting estimated timelines?  
4. Payment Patterns → Which payment methods correlate with higher values?  
5. Customer Satisfaction → What factors drive high review scores?  

---

## 🔧 Technical Implementation  
- **Platform:** Google BigQuery (Standard SQL)  
- **Data Size:** ~1.2 GB across 8 tables  
- **SQL Techniques:**  
  - Multi-table joins & nested queries  
  - Window functions (rank, moving averages)  
  - CTEs for modular logic  
  - Geographic aggregations (state, city)  
  - Date/time functions & trend analysis  
  - Percentile & variance calculations  

---

## 📈 Key Findings  
- Revenue grew **135.6% YoY** between 2017 & 2018  
- São Paulo holds ~42% of customer base  
- 96.5% of orders delivered on time; avg delivery = 12.5 days  
- 74% of payments via credit cards; 24% used installments  
- 17 states <1% penetration → large growth potential  

---

## 🎯 Business Recommendations  
### Short-term (0–3 months)  
- Improve logistics in low-performing states  
- Broaden installment payment options  
- Prepare inventory for August peak  

### Mid-term (3–12 months)  
- Launch campaigns in underpenetrated states  
- Build micro-fulfillment centers in high-potential zones  
- Implement predictive analytics for demand forecasting  

**Expected Impact:** +15–20% revenue, +10% delivery satisfaction, –12% logistic costs  

---

## 📁 Repository Structure  
