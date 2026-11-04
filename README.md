Data taken from PoojaGoud07-cdm/clinical-data-management-portfolio:main

# Clinical Trial Operations - Data Analyst Portfolio

## What is this project?
Clinical trial operations portfolio focused on site performance and subject demographics analysis. Using a real clinical trial dataset (500 subjects across multiple sites) to practice Data Analyst workflows that are relevant for healthcare and consulting domains.

This is not a pharma research project - it's Data Analyst role practice using clinical operations data to show I can work with sensitive operational data, site-level reporting, and diversity metrics.

## Dataset
- Subjects table - 500 rows
- Fields: site_id, age, sex, ethnicity, treatment group, weight, height, BMI
- Covers multiple trial sites with enrollment diversity and age distribution

## What I'm doing in this repo
- Analyzing site-wise enrollment - which sites have higher enrollment, age spread per site
- Demographics analysis - gender distribution, ethnicity diversity (% Hispanic per site)
- Treatment group analysis - average BMI per treatment, age gaps between oldest subjects per site
- Operational reporting patterns - Top 2 oldest subjects per site, sites where average age is higher than overall average, sites with highest diversity

All analysis done in DB Browser (SQLite) as real app practice, not just online editor.

## My Plan
- Phase 1 (Done): Basic reporting - counts per site/sex/treatment, average age/BMI
- Phase 2 (Done): Window functions - RANK, LAG/LEAD, PARTITION BY site_id for site-level insights
- Phase 3 (Pending - this week): Interview-level queries - site with highest Hispanic %, treatment with highest avg BMI, oldest/youngest per site with gaps
- Phase 4 (Next): Power BI dashboard for same dataset - site performance visual

## Timeline
- Started Oct 2026, last SQL push Nov 2026

## Tools
SQLite, DB Browser, GitHub, Power BI (upcoming)

Project Structure
```text

01\_Protocol
02\_CRF's
03\_Raw data
04\_Sql
05\_Data quality
06\_Query management
07\_Reconciliation
08\_Documentation
09\_PowerBI
10\_Final dataset
