# SQL Server Production Performance & Diagnostic Toolkit

A collection of production-safe, non-destructive T-SQL diagnostic scripts designed to audit database server health, isolate query bottlenecks, and identify index page fragmentation.

## 🚀 The Core Problem
This repository provides a clean, read-only framework to safely diagnose SQL Server database degradation in under 60 seconds without installing invasive binary monitoring wrappers.

---

## 🎁 Free Teaser: Page Life Expectancy (PLE) Memory Health Check
Copy and paste this safe, read-only script into SQL Server Management Studio (SSMS) or Azure Data Studio. It tracks how many seconds data pages stay cached in memory before being flushed to the disk.

```sql
SELECT 
    object_name,
    counter_name,
    cntr_value AS [page_life_expectancy_seconds],
    CASE 
        WHEN cntr_value < 300 THEN 'CRITICAL: Severe memory pressure. Up-size RAM or tune heavy queries.'
        WHEN cntr_value BETWEEN 300 AND 1000 THEN 'WARNING: Moderate memory pressure.'
        ELSE 'HEALTHY: Data pages are cached efficiently in RAM.'
    END AS [memory_health_status]
FROM 
    sys.dm_os_performance_counters
WHERE 
    object_name LIKE '%Buffer Manager%'
    AND counter_name = 'Page life expectancy';
```
*Target Result: Modern production environments should maintain a PLE of 1,000+ seconds. Drops below 300 indicate severe memory saturation forcing constant physical disk reads.*

---

## ⚡ Unlock the Full Automation Bundle ($49)
While Page Life Expectancy signals overall buffer pool health, pinpointing *which* exact lines of application code are causing the bottleneck requires the full diagnostic set. 

The complete, production-ready toolkit includes the critical scripts required to fix your performance entirely:

### 📦 What's Included in the Full Premium Kit:
*   **01_sqlserver_missing_and_unused_indexes.sql:** Leverages the internal engine's optimizer to find missing index configurations causing user lag, and flags dead indexes slowing down writes.
*   **03_sqlserver_index_fragmentation.sql:** Pinpoints page splits and fragmentation layout errors to tell you exactly when to execute an index reorganize vs. a full index rebuild.
*   **04_sqlserver_heavy_query_tracker.sql:** Ranks your top 5 heaviest query patterns by cumulative CPU worker time and extracts the XML execution plan for target analysis.
*   **Comprehensive Markdown Guide:** Step-by-step documentation detailing exactly how to safely resolve the critical thresholds flagged by the queries.

👉 [Download the Full Production SQL Server Toolkit on Gumroad for $49](https://leonova027.gumroad.com/l/sqlserver-performance-toolkit)

---
*Maintained by @Leo05434-db. For enterprise database engineering architecture, performance tuning, or scale optimization, contact: leo05434@proton.me.*
