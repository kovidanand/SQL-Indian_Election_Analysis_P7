# Indian Election Data Analytics 

## 1. Executive Summary

This project delivers a production-ready SQL-based analytical solution for structured election data. It transforms raw relational datasets into strategic intelligence using optimized queries, advanced aggregations, window functions, and performance-driven logic.

The project simulates a real-world Political Analytics / Public Sector Data Intelligence environment, where stakeholders require:

- Performance benchmarking

- Competitive landscape analysis

- Voter engagement insights

- Resource allocation strategy

- Risk and swing region detection

The queries are written following industry SQL best practices, ensuring scalability, maintainability, and analytical clarity.

## 2. Database Architecture Overview

The relational schema is designed with normalization (3NF), referential integrity, and scalable extensibility in mind.

**Core entities include:**

- parties

- candidates

- constituencies

- elections

- votes

- results

**Key design principles:**

- Primary & foreign key constraints

- Indexed foreign keys for faster joins

- Separation of transactional and aggregated logic

- Reusable analytical query blocks (CTEs)


## 3. Analytical SQL Queries (Industry Standard)

Below are structured, production-level queries categorized by business objective.

### A. Total Votes per Candidate


```sql
SELECT 
    c.candidate_id,
    c.candidate_name,
    p.party_name,
    SUM(v.vote_count) AS total_votes
FROM votes v
JOIN candidates c ON v.candidate_id = c.candidate_id
JOIN parties p ON c.party_id = p.party_id
GROUP BY c.candidate_id, c.candidate_name, p.party_name
ORDER BY total_votes DESC;
```

### Business Impact:
Identifies top-performing candidates and enables competitive benchmarking.

























