SELECT email, store, COUNT(*) AS numPurchases
FROM customer, customerpurchases, purchase
WHERE customer.id = customerpurchases.customerid
AND customerpurchases.purchaseid = purchase.id
GROUP BY customer.ID, purchase.store
WITH ROLLUP;