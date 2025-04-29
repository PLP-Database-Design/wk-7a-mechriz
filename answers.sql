
-- Question 1: Achieving 1NF

SELECT
  pd.OrderID,
  pd.CustomerName,
  jt.Product
FROM ProductDetail AS pd
JOIN JSON_TABLE(
  -- wrap comma-list into a JSON array: ["Laptop"]
  CONCAT(
    '["',
    REPLACE(pd.Products, ', ', '","'),
    '"]'
  ),
  '$[*]' COLUMNS (
    Product VARCHAR(100) PATH '$'
  )
) AS jt
ORDER BY pd.OrderID;



-- Question 2: Achieving 2NF


-- (a) Orders table: each OrderID → CustomerName
SELECT DISTINCT
  OrderID,
  CustomerName
FROM OrderDetails
ORDER BY OrderID;

-- (b) OrderDetails table: each Product & Quantity fully depends on OrderID+Product
SELECT
  OrderID,
  Product,
  Quantity
FROM OrderDetails
ORDER BY OrderID, Product;
