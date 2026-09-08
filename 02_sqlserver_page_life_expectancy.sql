-- ========================================================================
-- SQL SERVER TOOLKIT: PAGE LIFE EXPECTANCY (PLE)
-- Threshold: Traditional baseline is 300 seconds. For modern high-RAM 
-- servers, a sudden drop below 1000+ seconds signals severe memory pressure.
-- ========================================================================

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
