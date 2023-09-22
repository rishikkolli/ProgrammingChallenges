-- 1. Write a query to get sum of impressions by day.
SELECT sum(impressions) AS 'Sum of Impressions', date as 'Date'
FROM Marketing_data
GROUP BY date;
-- 2. Write a query to get the top three revenue-generating states in order of best to worst. How much revenue did the third best state generate?
SELECT sum(revenue) AS 'Revenue Generated', state AS 'State'
FROM Website_revenue
GROUP BY state
ORDER BY sum(revenue) DESC
LIMIT 3;
-- The third best state generated $37,577 (Ohio).
-- 3. Write a query that shows total cost, impressions, clicks, and revenue of each campaign. Make sure to include the campaign name in the output.
SELECT campaign_info.name AS 'Campaign Name', round(sum(marketing_data.cost), 2) AS 'Total Cost', round(sum(marketing_data.impressions), 2) AS 'Total Impressions', round(sum(marketing_data.clicks), 2) AS 'Total Clicks', round(sum(website_revenue.revenue), 2) AS 'Total Website Revenue'
FROM campaign_info
JOIN marketing_data ON campaign_info.id = marketing_data.campaign_id
JOIN website_revenue ON marketing_data.campaign_id = website_revenue.campaign_id
GROUP BY name;
-- 4. Write a query to get the number of conversions of Campaign 5 by state. Which state generated the most conversions for this campaign?
SELECT sum(marketing_data.conversions) AS 'Total Conversions', website_revenue.state as 'State'
FROM campaign_info
JOIN marketing_data ON campaign_info.id = marketing_data.campaign_id
JOIN website_revenue ON marketing_data.campaign_id = website_revenue.campaign_id
WHERE name IS 'Campaign5'
GROUP BY state
ORDER BY sum(marketing_data.conversions) DESC;
-- Georgia had the most conversions
-- 5. In your opinion, which campaign was the most efficient, and why?
-- The way I would approach this question is by looking at the data and information I gathered from question 3 and looking at scaled standard deviation or looking at normalized metrics to understand how the data performed in general. After making some of these calculations, I would choose campaign 4 as the most effective campaigning strategy with low costs and highest online revenue generated outside of the outlier which was campaign 3. We want to compare our revenues and costs and campaign 4 presented the highest conversion rate percentages as well. From a profitability stand point, I would take campaign 4, but I would implement some conversion rate techniques used in campaign 3 as we can see an almost 30% conversion rate from clicks to final conversions.
-- Here's the code I used again:
SELECT campaign_info.name AS 'Campaign Name', round(sum(marketing_data.cost), 2) AS 'Total Cost', round(sum(marketing_data.impressions), 2) AS 'Total Impressions', round(sum(marketing_data.clicks), 2) AS 'Total Clicks', round(sum(website_revenue.revenue), 2) AS 'Total Website Revenue', round(sum(marketing_data.conversions), 2) AS 'Total Conversions'
FROM campaign_info
JOIN marketing_data ON campaign_info.id = marketing_data.campaign_id
JOIN website_revenue ON marketing_data.campaign_id = website_revenue.campaign_id
GROUP BY name;
/*
- Scaled Standard Deviations for Costs: [-0.3931336782858191, -0.3941076869923827, 2.118875489706018, -0.40313380713854844, -0.39370631728926876]
- Scaled Standard Deviations for Revenue: [-0.7035857074001835, -0.6948489579339497, 2.204273083573822, -0.6516962468684645, -0.1541422713772259]
- Normalized Costs: [0.0, 0.003856950899147842, 1.0, 0.001513230899685688, 0.004036299366110945]
- Normalized Revenue: [0.0, 0.006518683813713951, 1.0, 0.18921253624830404, 0.07866566169809369]
*/
-- 6. Write a query that showcases the best day of the week (e.g., Sunday, Monday, Tuesday, etc.) to run ads.
SELECT DATEPART(dw, date) AS day_of_week, sum(marketing_data.impressions) AS 'Total Impressions', sum(marketing_data.clicks) AS 'Total Clicks', sum(marketing_data.conversions) AS 'Total Conversions'
FROM marketing_data
GROUP BY DATEPART(dw, date)
ORDER BY day_of_week;
