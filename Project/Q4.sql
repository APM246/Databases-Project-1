SELECT customerID, COUNT(*)
FROM customerpurchases, customer, conesinpurchase
WHERE customerpurchases.customerID = customer.ID 
AND customerpurchases.purchaseID = conesinpurchase.purchaseID
GROUP BY customer.ID
ORDER BY COUNT(*) DESC;