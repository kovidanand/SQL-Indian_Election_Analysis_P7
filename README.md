# Indian Election Data Analytics 

![image](https://github.com/kovidanand/SQL-Indian_Election_Analysis_P7/blob/main/Election_png.png)

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

### Governance Impact:
Identifies top-performing candidates and enables competitive benchmarking.

### B. Winning Candidate per Constituency

```sql
WITH ranked_results AS (
    SELECT 
        c.constituency_id,
        c.candidate_id,
        SUM(v.vote_count) AS total_votes,
        RANK() OVER (
            PARTITION BY c.constituency_id 
            ORDER BY SUM(v.vote_count) DESC
        ) AS rank_position
    FROM votes v
    JOIN candidates c ON v.candidate_id = c.candidate_id
    GROUP BY c.constituency_id, c.candidate_id
)
SELECT *
FROM ranked_results
WHERE rank_position = 1;
```

### Governance Impact:
Determines constituency winners and highlights regional dominance.


### C. Vote Share Percentage per Candidate

```sql
WITH constituency_totals AS (
    SELECT 
        c.constituency_id,
        SUM(v.vote_count) AS total_constituency_votes
    FROM votes v
    JOIN candidates c ON v.candidate_id = c.candidate_id
    GROUP BY c.constituency_id
)
SELECT 
    c.candidate_name,
    con.constituency_name,
    SUM(v.vote_count) AS candidate_votes,
    ROUND(
        (SUM(v.vote_count) * 100.0 / ct.total_constituency_votes), 2
    ) AS vote_share_percentage
FROM votes v
JOIN candidates c ON v.candidate_id = c.candidate_id
JOIN constituencies con ON c.constituency_id = con.constituency_id
JOIN constituency_totals ct ON c.constituency_id = ct.constituency_id
GROUP BY c.candidate_name, con.constituency_name, ct.total_constituency_votes
ORDER BY vote_share_percentage DESC;
```

### Governance Impact:
Measures real influence beyond raw vote count and helps identify strongholds.

### D. Close Margin Constituencies (Swing Seats)

```sql
WITH ranked_votes AS (
    SELECT 
        c.constituency_id,
        c.candidate_id,
        SUM(v.vote_count) AS total_votes,
        DENSE_RANK() OVER (
            PARTITION BY c.constituency_id 
            ORDER BY SUM(v.vote_count) DESC
        ) AS vote_rank
    FROM votes v
    JOIN candidates c ON v.candidate_id = c.candidate_id
    GROUP BY c.constituency_id, c.candidate_id
)
SELECT 
    r1.constituency_id,
    ABS(r1.total_votes - r2.total_votes) AS winning_margin
FROM ranked_votes r1
JOIN ranked_votes r2 
    ON r1.constituency_id = r2.constituency_id
WHERE r1.vote_rank = 1 
AND r2.vote_rank = 2
ORDER BY winning_margin ASC;
```

### Governance Impact:
Identifies swing constituencies requiring strategic intervention and campaign focus.


### E. Party-Wise Seat Count

```sql
WITH winners AS (
    SELECT 
        c.constituency_id,
        c.party_id,
        RANK() OVER (
            PARTITION BY c.constituency_id 
            ORDER BY SUM(v.vote_count) DESC
        ) AS rank_position
    FROM votes v
    JOIN candidates c ON v.candidate_id = c.candidate_id
    GROUP BY c.constituency_id, c.party_id
)
SELECT 
    p.party_name,
    COUNT(*) AS seats_won
FROM winners w
JOIN parties p ON w.party_id = p.party_id
WHERE w.rank_position = 1
GROUP BY p.party_name
ORDER BY seats_won DESC;
```

### Governance Impact:
Determines governing majority and macro-level political positioning.


### F. Voter Turnout Analysis

```sql
SELECT 
    con.constituency_name,
    SUM(v.vote_count) AS total_votes_cast,
    con.total_registered_voters,
    ROUND(
        (SUM(v.vote_count) * 100.0 / con.total_registered_voters), 2
    ) AS turnout_percentage
FROM votes v
JOIN candidates c ON v.candidate_id = c.candidate_id
JOIN constituencies con ON c.constituency_id = con.constituency_id
GROUP BY con.constituency_name, con.total_registered_voters
ORDER BY turnout_percentage DESC;
```

### Governance Impact:
Measures civic engagement and identifies low-engagement regions for policy awareness drives.


### G. Party Performance Across Regions

```sql
SELECT 
    p.party_name,
    con.state_name,
    SUM(v.vote_count) AS total_votes
FROM votes v
JOIN candidates c ON v.candidate_id = c.candidate_id
JOIN parties p ON c.party_id = p.party_id
JOIN constituencies con ON c.constituency_id = con.constituency_id
GROUP BY p.party_name, con.state_name
ORDER BY total_votes DESC;
```

### Governance Impact:
Enables regional expansion strategy and state-level dominance mapping.



## 4. Performance Optimization Techniques Used

- Indexed foreign keys for faster joins

- CTEs for logical query separation

- Window functions for ranking and margin calculation

- Aggregation at lowest granularity before final grouping

- Avoidance of correlated subqueries where possible

These techniques align with enterprise-level SQL development standards.

## 5. Strategic Business Impact

This project simulates a Political Intelligence Dashboard backend. The insights support:

- ### Resource Allocation
Target high-risk constituencies with narrow margins.

- ### Campaign ROI Optimization
Invest more in swing regions rather than strongholds.

- ### Performance Benchmarking
Compare candidate and party effectiveness across states.

- ### Risk Identification
Detect declining turnout or shrinking vote share.

- ### Governance Planning
Use turnout trends to improve civic engagement programs.

- ### Longitudinal Analysis
Schema allows extension for multi-election comparison.


## 6. Skills Demonstrated

- Advanced SQL (CTEs, Window Functions, Ranking)

- Data Modeling & Normalization

- Analytical Thinking

- Business Intelligence Translation

- Performance Optimization

- Strategic Insight Communication

## 7. Industry Relevance

**This project aligns with roles such as:**

- Data Analyst

- Business Intelligence Analyst

- Political Data Consultant

- Public Policy Analyst

- SQL Developer

- Analytics Engineer

It demonstrates not just query writing, but decision-support analytics.


## 8. Conclusion

This Election Data Analytics project is built to industry standards with scalable architecture, optimized SQL logic, and strong business interpretation.

It bridges technical SQL expertise with strategic intelligence generation that exactly what modern data-driven organizations require.
