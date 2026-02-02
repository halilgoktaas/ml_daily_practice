# SQL Daily Practice 1 — Marketplace Analytics

**Date:** 2026-01-31  
**Domain:** E-commerce / Marketplace  
**Focus:** Analytical SQL, joins, aggregations, window functions

## Objective
The goal of this practice is to strengthen analytical SQL skills using a realistic marketplace scenario involving orders, shipments, and returns. The focus is on writing production-style queries that answer business-oriented questions.

## Data Model
The dataset represents a simplified marketplace and includes the following entities:
- Customers
- Products
- Orders
- Order Items
- Shipments
- Returns

The schema is designed to support common analytical use cases such as revenue analysis, delivery performance, return behavior, and customer segmentation.

## Topics Covered
- Multi-table joins
- Aggregations and grouping
- Time-based analysis with `DATE_TRUNC`
- Common Table Expressions (CTEs)
- Window functions (`ROW_NUMBER`)
- Conditional logic with `CASE WHEN`
- Ratio and rate calculations
- Basic RFM-style customer segmentation

## Deliverables
- `01_schema.sql`: Database schema definition
- `02_seed.sql`: Sample data for analysis
- `03_queries.sql`: 10 analytical SQL queries with solutions

## Notes
- Cancelled orders are excluded from most analyses.
- Order revenue is calculated from product line items.
- Shipping performance is evaluated using shipment timestamps.
- This practice is part of an ongoing daily SQL and data analysis routine.
