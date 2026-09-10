# 🚴 Bike E-Commerce Data Lakehouse & Churn Prediction

> An end-to-end **Data Engineering & Machine Learning platform** built with **Databricks Lakehouse Architecture**, transforming raw CRM/ERP data into analytics-ready datasets and customer churn predictions.

---

## 📌 Overview

This project builds a complete data platform for an e-commerce business, from **raw data ingestion** to **business analytics** and **customer churn prediction**.

The platform follows the **Medallion Architecture**:

**CRM & ERP → Bronze → Silver → Gold → Analytics & Machine Learning**

The project focuses on practical Data Engineering and MLOps concepts, including:

* Lakehouse architecture
* ETL/ELT pipelines
* Delta Lake
* Data integration and cleansing
* Star Schema modeling
* RFM customer analysis
* Databricks Workflows
* MLflow model management
* Real-time ML inference with Streamlit

---

## 🏗️ Architecture

```text
                    CRM & ERP
                       │
                       ▼
              ┌─────────────────┐
              │  🥉 BRONZE      │
              │  Raw Delta Data │
              └────────┬────────┘
                       │
                       ▼
              ┌─────────────────┐
              │  🥈 SILVER      │
              │ Cleaned + RFM   │
              │     Features    │
              └────────┬────────┘
                       │
                       ▼
              ┌─────────────────┐
              │  🥇 GOLD        │
              │ Star Schema +   │
              │   ML Features   │
              └───────┬─────────┘
                      / \
                     /   \
                    ▼     ▼
             📊 Analytics   🤖 ML
             Dashboard       │
                             ▼
                         MLflow
                             │
                             ▼
                       Streamlit App
                             │
                             ▼
                    Churn Risk Prediction
```

---

## 🎯 Project Goals

1. Consolidate CRM and ERP data into a centralized Lakehouse.
2. Build scalable Bronze, Silver, and Gold data layers.
3. Clean and transform data using PySpark and Spark SQL.
4. Calculate customer **RFM features** for behavioral analysis.
5. Automate the data pipeline with Databricks Workflows.
6. Build an executive dashboard for commercial analytics.
7. Train a machine learning model to predict customer churn.
8. Manage the ML lifecycle with MLflow and Unity Catalog.
9. Deploy a user-friendly Streamlit application for real-time inference.

---

# ⚙️ Data Engineering

## 🥉 Bronze Layer — Raw Data

The Bronze layer stores raw CRM and ERP data in **Delta Lake**.

### What I built

* Ingested raw e-commerce transaction data into Delta tables.
* Preserved source data structure for traceability and auditability.
* Maintained raw historical records.
* Implemented two ingestion approaches:

  * `bronze_basic`
  * `bronze_improvement`

**Purpose:** Preserve reliable raw data as the foundation of the Lakehouse.

---

## 🥈 Silver Layer — Clean & Transform

The Silver layer integrates CRM and ERP datasets and prepares them for analytics.

### Data transformations

* Missing value handling
* Duplicate removal
* Data type standardization
* Data cleansing
* CRM/ERP integration
* Customer-level aggregation

The Silver pipeline is automated through:

`silver_orchestration`

---

## 🥇 Gold Layer — Business Ready Data

The Gold layer contains curated datasets designed for analytics and machine learning.

### Star Schema

```text
                  dim_customers
                       │
                       │
                       ▼
dim_products ───── fact_sales
```

### Tables

* `gold_dim_customers`
* `gold_dim_products`
* `gold_fact_sales`

The Gold layer provides optimized datasets for:

* Business intelligence
* KPI reporting
* Sales analysis
* Customer analysis
* Machine learning

Gold processing is managed through:

`gold_orchestration`

---

# ⚡ Pipeline Orchestration

The complete data pipeline is automated using **Databricks Workflows**.

### Pipeline

```text
Bronze
   ↓
Silver
   ↓
Gold
   ↓
Analytics / ML
```

### Workflow Features

* Multi-task execution
* Task dependencies
* Sequential processing
* Automated scheduling
* Pipeline monitoring
* Delta Lake optimization

**Job:** `Loading Bike Data Lakehouse`

**Schedule:** Daily at **08:38 PM**

**Typical runtime:** ~4–16 minutes

---

# 📊 Analytics Dashboard

An executive dashboard was developed using **Databricks SQL** to monitor commercial performance.

### Key KPIs

| KPI                 |         Value |
| ------------------- | ------------: |
| Total Revenue       |   **$25.52M** |
| Total Orders        |    **21.29K** |
| Average Order Value | **$1,198.90** |
| Total Profit        |   **$25.52M** |

### Dashboard Analysis

**Sales Performance**

* Monthly revenue trends
* Monthly profit trends
* YoY performance comparison
* 2011–2014 sales analysis

**Geographic Analysis**

* Pacific & Canada
* Europe
* North America

**Product Analysis**

* Top revenue-generating products
* Product category performance
* Bikes
* Accessories
* Clothing

The **Mountain-200** product series was identified as one of the strongest revenue contributors.

---

# 🤖 Machine Learning

## Customer Churn Prediction

A **Random Forest Classifier** was developed to estimate the probability that a customer will churn.

### Features

```text
Recency
Frequency
Monetary
Average Order Value
Country
Gender
```

The model learns from customer purchasing behavior and produces a churn probability for each customer.

---

## 🧪 MLOps with MLflow

The trained model is tracked and managed using **MLflow** and **Databricks Unity Catalog**.

```text
Feature Engineering
        ↓
Model Training
        ↓
Experiment Tracking
        ↓
Model Registry
        ↓
Production Model
        ↓
Real-Time Inference
```

Registered model:

`models:/main.gold.churn_model/Production`

This provides:

* Experiment tracking
* Model versioning
* Model registry
* Model lifecycle management
* Production model access

---

# 🌸 Streamlit Churn Prediction App

A Streamlit web application provides an interactive interface for customer churn prediction.

### User Inputs

Users can enter or adjust:

* Recency
* Frequency
* Monetary
* Country
* Gender

The application sends these features to the registered ML model and returns an estimated churn probability.

### Prediction Flow

```text
Customer Information
        ↓
Feature Preparation
        ↓
MLflow Model
        ↓
Churn Probability
        ↓
Risk Classification
        ↓
Retention Recommendation
```

### Risk Levels

| Risk               | Meaning                               |
| ------------------ | ------------------------------------- |
| 🟢 **Low Risk**    | Customer is unlikely to churn         |
| 🟡 **Medium Risk** | Customer may require attention        |
| 🔴 **High Risk**   | Customer has a high churn probability |

The application uses a custom **Pink & Blue pastel UI** built with Streamlit and CSS.

---

# 📂 Project Structure

```text
Bike_DataLakehouse_BigData_Project/
│
├── Bronze/
│   ├── bronze_basic/
│   └── bronze_improvement/
│
├── Silver/
│   ├── crm/
│   ├── erp/
│   └── silver_orchestration/
│
├── Gold/
│   ├── gold_dim_customers/
│   ├── gold_dim_products/
│   ├── gold_fact_sales/
│   └── gold_orchestration/
│
|── analytics/

|
├── models/
│   ├── 01_feature_engineering/
│   ├── 02_train_customer_churn/
│   ├── 03_model_inference/
│   ├── streamlit_app/
│   └── style.css
│
└── README.md
```

---

# 🛠️ Tech Stack

| Category             | Technologies                        |
| -------------------- | ----------------------------------- |
| **Lakehouse**        | Databricks, Delta Lake              |
| **Data Governance**  | Unity Catalog                       |
| **Data Processing**  | PySpark, Spark SQL                  |
| **Orchestration**    | Databricks Workflows & Jobs         |
| **Data Modeling**    | Star Schema                         |
| **Machine Learning** | Python, Scikit-learn, Random Forest |
| **MLOps**            | MLflow                              |
| **Analytics**        | Databricks SQL                      |
| **Web Application**  | Streamlit, CSS3                     |
| **Version Control**  | Git, GitHub                         |

---

# 🎓 Skills Demonstrated

### Data Engineering

* Lakehouse Architecture
* Medallion Architecture
* ETL / ELT
* Distributed Data Processing
* PySpark
* Spark SQL
* Delta Lake

### Data Modeling

* Star Schema
* Fact & Dimension Tables
* CRM / ERP Data Integration
* Business-ready Data Modeling

### Pipeline Engineering

* Databricks Workflows
* Job Orchestration
* Task Dependencies
* Automated Scheduling
* Pipeline Monitoring

### Analytics

* KPI Development
* Sales Analysis
* Product Analysis
* Geographic Segmentation
* Executive Dashboards
* RFM Analysis

### Machine Learning & MLOps

* Feature Engineering
* Customer Churn Prediction
* Random Forest Classification
* MLflow
* Model Registry
* Model Versioning
* Production Inference

### Application Development

* Streamlit
* Custom CSS
* Interactive ML Application
* Real-Time Model Inference

---

# 🔄 End-to-End Workflow

```text
┌───────────────┐
│   CRM & ERP   │
└───────┬───────┘
        ↓
┌───────────────┐
│    Bronze     │
│  Raw Delta    │
└───────┬───────┘
        ↓
┌───────────────┐
│    Silver     │
│ Clean + RFM   │
└───────┬───────┘
        ↓
┌───────────────┐
│     Gold      │
│ Star Schema   │
└───────┬───────┘
        │
        ├──────────────→ 📊 Dashboard
        │
        ↓
┌───────────────┐
│ ML Features   │
└───────┬───────┘
        ↓
┌───────────────┐
│ Churn Model   │
│ Random Forest │
└───────┬───────┘
        ↓
┌───────────────┐
│    MLflow     │
└───────┬───────┘
        ↓
┌───────────────┐
│   Streamlit   │
│   Web App     │
└───────┬───────┘
        ↓
   Churn Risk
```

---

# 🚀 Project Outcome

This project demonstrates how a modern **Data Lakehouse** can connect Data Engineering, Analytics, and Machine Learning into a single end-to-end platform.

From raw CRM/ERP data to customer churn prediction:

**Ingestion → Transformation → Modeling → Orchestration → Analytics → Machine Learning → MLOps → Application**

The project provides hands-on experience with the technologies and engineering practices used in modern data platforms.
