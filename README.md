## Conversion_Analytics

#### Technology Stack:
BigQuery (CTE, data aggregation, function, joins)

#### Project Description:
In this project, I utilized BigQuery to analyze conversion data from a publicly available Google Analytics 4 dataset, specifically data from the Google online store.

I began by crafting a query to generate a comprehensive table containing information about conversions, tracking the entire user journey from session initiation to purchase. The resulting table encompasses the following key fields:
1. event_date: The session's start date derived from the event_timestamp field.
source: The source of the site visit.
medium: The medium of the site visit.
campaign: The name of the site visit campaign.
user_sessions_count: The count of unique sessions for distinct users on each corresponding date and for the respective traffic channel.
visit_to_cart: Conversion from session initiation on the site to adding a product to the cart (on the relevant date and for the corresponding traffic channel).
visit_to_checkout: Conversion from session initiation on the site to attempting to complete an order (on the relevant date and for the corresponding traffic channel).
visit_to_purchase: Conversion from session initiation on the site to making a purchase (on the relevant date and for the corresponding traffic channel).

Notably, I ensured accuracy in counting unique sessions by considering both session IDs and user IDs, accounting for potential duplicate session IDs among different users.

[BigQuery Link](https://console.cloud.google.com/bigquery?sq=916069414937:d96af45f57ad4dd0a4f6b731ceca6ee5)

[Source data from GA 4](https://console.cloud.google.com/bigquery?p=bigquery-public-data&d=ga4_obfuscated_sample_ecommerce&t=events_20210131&page=table&project=hardy-scarab-392910)

#### Skills:
SQL, BigQuery, Google Analytics 4
