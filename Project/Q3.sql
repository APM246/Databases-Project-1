SELECT monthname(buyDate) AS month, COUNT(*) AS numPurchases
FROM purchase
GROUP BY month(buyDate);