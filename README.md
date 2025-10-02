# 🛒 Target Brazil E-commerce Analysis: SQL Business Intelligence Case Study

**End-to-end SQL-driven business intelligence project analyzing 100,000+ e-commerce orders from Target’s Brazilian operations (2016–2018) to uncover growth opportunities, optimize logistics, and enhance customer satisfaction.**

![SQL](https://img.shields.io/badge/SQL-BigQuery-blue)
![Cloud](https://img.shields.io/badge/Google-Cloud-orange?logo=googlecloud)
![Status](https://img.shields.io/badge/Status-Complete-success)
![License](https://img.shields.io/badge/License-MIT-green)
![Analysis](https://img.shields.io/badge/Focus-Business_Intelligence-orange)

---

## 📌 Executive Summary
This project uses **Google BigQuery + advanced SQL** to analyze Target’s e-commerce expansion in Brazil. Covering 1M+ records across 8 interconnected tables, the study evaluates **market growth, operational efficiency, customer behavior, and payment trends**, delivering **strategic recommendations** for revenue growth, logistics optimization, and customer satisfaction improvement.

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
Target expanded its retail presence into Brazil between 2016–2018. The goal of this project is to answer:  
**“How can Target optimize operations in Brazil to increase revenue, improve delivery, and strengthen customer loyalty?”**  

---

## 📊 Dataset Overview
| Table | Records | Description |
|-------|---------|-------------|
| `orders` | 99,441 | Order lifecycle and status |
| `customers` | 99,441 | Customer demographics and location |
| `order_items` | 112,650 | Items, sellers, and pricing |
| `payments` | 103,886 | Payment method and value |
| `products` | 32,951 | Product catalog |
| `sellers` | 3,095 | Seller details |
| `geolocation` | 1,000,163 | Postal codes and coordinates |
| `order_reviews` | 99,224 | Customer reviews and ratings |

**Period:** Sep 2016 – Oct 2018  
**Scope:** 27 Brazilian states | **Volume:** 1M+ records  

---

## 📌 Entity Relationship Diagram
![ERD](Database%20Schema%20Diagram.png)

---

## ❓ Key Business Questions
1. **Market Growth** → How have orders and revenue evolved over time?  
2. **Geographic Reach** → Which states show high vs low penetration?  
3. **Operational Efficiency** → How accurate are deliveries vs estimates?  
4. **Payment Trends** → Which methods drive higher order values?  
5. **Customer Satisfaction** → What factors influence review scores?  

---

## 🔧 Technical Implementation
- **Platform:** Google BigQuery (Standard SQL)  
- **Data Size:** ~1.2 GB across 8 linked tables  
- **SQL Techniques:**  
  - Multi-table joins & nested queries  
  - Window functions (ranking, moving averages)  
  - CTEs for modular queries  
  - Geographic aggregations (state, city-level)  
  - Date/time functions for trend analysis  
  - Percentiles & variance for performance metrics  

---

## 📈 Key Findings
- **Revenue Growth:** 135.6% YoY increase (2017 → 2018).  
- **Market Concentration:** São Paulo contributes 42% of customers.  
- **Operational Performance:** 96.5% orders delivered on time; avg delivery = 12.5 days.  
- **Payment Trends:** 74% use credit cards; 24% adopt installments.  
- **Growth Gap:** 17 states <1% penetration → untapped market.  

---

## 🎯 Business Recommendations
### Immediate (0–3 months)
- Strengthen logistics in bottom 5 states.  
- Expand installment payment options.  
- Stock planning for August demand surge.  

### Strategic (3–12 months)
- Target underpenetrated states with <1% share.  
- Build local fulfillment centers in metro regions.  
- Deploy predictive analytics for demand forecasting.  

**Expected Impact:** +15–20% revenue, +10% delivery satisfaction, -12% logistics costs.  

---

## 📁 Repository Structure
