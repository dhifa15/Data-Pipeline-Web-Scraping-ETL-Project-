# Online Booking Platform Data Pipeline (Web Scraping ETL Project)
---
## Overview
This project demonstrates an end-to-end data pipeline that extracts travel-related data from an online platform using web scraping techniques. The pipeline covers data extraction, cleaning, transformation, and loading processed data into a PostgreSQL database for structured storage and future analysis.
The project is designed to showcase practical skills in data engineering fundamentals, including ETL workflow design, data quality validation, and relational database integration.

## Data Source
The dataset was obtained through web scraping from a travel booking platform and contains hotel booking information in Bali for travel dates between January 1–4, 2026.
Collected attributes include pricing information, ratings, locations, and availability details.

## Project Workflow
### 1. Extract
- Collected travel-related data using web scraping techniques
- Implemented scraping logic in a Jupyter Notebook
- Extracted more than 50 records with multiple attributes per listing

### 2. Transform
- Performed basic exploratory data analysis (EDA)
- Validated and corrected data types to ensure numeric consistency
- Cleaned price, rating, and quantity-related fields
- Handled missing and inconsistent values
- Exported the cleaned dataset into CSV format

### 3. Load
- Designed a PostgreSQL database schema based on the processed dataset
- Created tables with appropriate data types
- Loaded the CSV data into PostgreSQL using SQL scripts
- Verified successful data insertion through validation queries

---

## Technologies Used
- Python  
- Pandas  
- BeautifulSoup  
- Requests  
- PostgreSQL  
- SQL  

---

### Author
**Hazna Dhifa Putri Ardeva**
[GitHub](https://github.com/dhifa15) | [LinkedIn](https://www.linkedin.com/in/haznadhifa)
