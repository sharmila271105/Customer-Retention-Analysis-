# Customer Retention & Sales Analytics Dashboard

## Project Overview

This project analyzes e-commerce transaction data to understand customer retention, purchasing behavior, and revenue performance. Using SQL for data cleaning and KPI generation and Excel for visualization, the project demonstrates an end-to-end analytics workflow from raw transactional data to business insights.

## Business Problem

Customer retention is one of the most important drivers of long-term business growth. The objective of this project is to identify:

* How many customers return for repeat purchases
* Customer retention rate
* Revenue contribution by customers and countries
* Revenue trends over time
* High-value customers requiring retention focus

## Dataset

**Dataset:** Online Retail II (Kaggle)

After cleaning:

* Transactions: 22,218
* Customers: 771
* Orders: 1,059

## Tools Used

* SQL (MySQL)
* Microsoft Excel

## Data Cleaning

The following issues were identified and resolved:

* Missing Customer IDs
* Negative quantities (returns)
* Zero quantities
* Invalid prices
* Cancelled invoices
* Duplicate transaction checks

A clean analysis table was created for all KPI calculations.

## KPIs Calculated

* Total Revenue
* Total Customers
* Total Orders
* Average Order Value (AOV)
* Repeat Customer Rate
* Purchase Frequency
* Top Customers by Revenue

## Dashboard Components

### KPI Cards

* Total Revenue
* Total Customers
* Total Orders
* Repeat Customer Rate

### Visualizations

* Customer Return Analysis (Doughnut Chart)
* Revenue by Country (Bar Chart)
* Daily Revenue Trend (Line Chart)
* Top 10 Customers by Revenue (Horizontal Bar Chart)

## Key Insights

* Repeat customer rate was 21.9%, indicating opportunities to improve customer loyalty.
* Most customers made only one purchase.
* Revenue was concentrated among a small group of high-value customers.
* The United Kingdom contributed the majority of total revenue.
* Daily revenue patterns highlighted periods of high customer activity.

## Project Structure

```text
├── SQL Queries
├── Excel Dashboard
├── Project Report
├── Dataset Sample
└── README.md
```


