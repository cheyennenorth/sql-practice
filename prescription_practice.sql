/*1A. Which prescriber had the highest total number of 
claims (totaled over all drugs)? Report the npi and 
total number of claims

A. INNER JOIN prescriber with prescription using npi
this gives us a table with every occurance of precription
with the prescriber information included. From there 
*/
SELECT npi, SUM(total_claim_count) as total_claims
FROM prescriber INNER JOIN prescription USING(npi)
GROUP BY npi
ORDER BY total_claims DESC
LIMIT 1;

/*1B. Report provider name, organization, 
speciality_description, total number of claims. */

SELECT nppes_provider_first_name, 
nppes_provider_last_org_name,
specialty_description, SUM(total_claim_count) as total_claims
FROM prescriber INNER JOIN prescription USING(npi)
GROUP BY nppes_provider_first_name, 
nppes_provider_last_org_name, specialty_description
ORDER BY total_claims DESC;

/*2A. Which specialty had the most total number of claims? */
SELECT specialty_description, SUM(total_claim_count) as total_claims
FROM prescriber INNER JOIN prescription USING(npi)
GROUP BY specialty_description
ORDER BY total_claims DESC;

/*2B. Which specialty had the most total claims for opiods?*/
SELECT specialty_description, SUM(total_claim_count) as total_claim 
FROM prescriber INNER JOIN prescription USING(npi)
LEFT JOIN drug USING(drug_name)
WHERE opioId_drug_flag = 'Y'
GROUP BY specialty_description
ORDER BY total_claim DESC;

/*2C. Challenge Question:
Are there any specialties that appear in the prescriber 
table that have no associated prescriptions in the 
prescription table? */

WITH special_claim as (
	SELECT specialty_description, SUM(total_claim_count) as claims
FROM prescriber LEFT JOIN prescription USING(npi)
GROUP BY specialty_description
)
SELECT *
FROM special_claim 
WHERE claims IS NULL
















