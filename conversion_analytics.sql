WITH traffic_user_sessions AS (
  SELECT
    DATE(TIMESTAMP_MICROS(event_timestamp)) AS event_date,
    traffic_source.source,
    traffic_source.medium,
    traffic_source.name AS campaign,
    CONCAT(user_pseudo_id, '-', CAST((SELECT value.int_value FROM UNNEST(event_params) WHERE key = 'ga_session_id') AS STRING)) as user_sessions
  FROM
    `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`
),

traffic_session_start AS (
  SELECT
    DATE(TIMESTAMP_MICROS(event_timestamp)) AS event_date,
    traffic_source.source,
    traffic_source.medium,
    traffic_source.name AS campaign,
    CONCAT(user_pseudo_id, '-', CAST((SELECT value.int_value FROM UNNEST(event_params) WHERE key = 'ga_session_id') AS STRING)) AS user_sessions
  FROM
    `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`
  WHERE
    event_name = 'session_start'
),

traffic_add_to_cart AS (
  SELECT
    DATE(TIMESTAMP_MICROS(event_timestamp)) AS event_date,
    traffic_source.source,
    traffic_source.medium,
    traffic_source.name AS campaign,
    CONCAT(user_pseudo_id, '-', CAST((SELECT value.int_value FROM UNNEST(event_params) WHERE key = 'ga_session_id') AS STRING)) AS user_sessions
  FROM
    `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`
  WHERE
    event_name = 'add_to_cart'
),

traffic_begin_checkout AS (
  SELECT
    DATE(TIMESTAMP_MICROS(event_timestamp)) AS event_date,
    traffic_source.source,
    traffic_source.medium,
    traffic_source.name AS campaign,
    CONCAT(user_pseudo_id, '-', CAST((SELECT value.int_value FROM UNNEST(event_params) WHERE key = 'ga_session_id') AS STRING)) AS user_sessions
  FROM
    `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`
  WHERE
    event_name = 'begin_checkout'
),

traffic_purchase AS (
  SELECT
    DATE(TIMESTAMP_MICROS(event_timestamp)) AS event_date,
    traffic_source.source,
    traffic_source.medium,
    traffic_source.name AS campaign,
    CONCAT(user_pseudo_id, '-', CAST((SELECT value.int_value FROM UNNEST(event_params) WHERE key = 'ga_session_id') AS STRING)) AS user_sessions
  FROM
    `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`
  WHERE
    event_name = 'purchase'
)


SELECT
  tus.event_date,
  tus.source,
  tus.medium,
  tus.campaign,
  COUNT(DISTINCT(tus.user_sessions)) AS user_sessions_count,
  CASE
    WHEN COUNT(DISTINCT(tss.user_sessions))!= 0 THEN COUNT(DISTINCT(tac.user_sessions)) / COUNT(DISTINCT(tss.user_sessions))
  END AS visit_to_cart,
  CASE
    WHEN COUNT(DISTINCT(tss.user_sessions))!= 0 THEN COUNT(DISTINCT(tbc.user_sessions)) / COUNT(DISTINCT(tss.user_sessions))
  END AS visit_to_checkout,
  CASE
    WHEN COUNT(DISTINCT(tss.user_sessions))!= 0 THEN COUNT(DISTINCT(tp.user_sessions)) / COUNT(DISTINCT(tss.user_sessions))
  END AS visit_to_purchase
FROM
  traffic_user_sessions AS tus
LEFT JOIN traffic_session_start AS tss USING(user_sessions)
LEFT JOIN traffic_add_to_cart AS tac USING(user_sessions)
LEFT JOIN traffic_begin_checkout AS tbc USING(user_sessions)
LEFT JOIN traffic_purchase AS tp USING(user_sessions)
GROUP BY
  1, 2, 3, 4
ORDER BY
  1, 2, 3, 4