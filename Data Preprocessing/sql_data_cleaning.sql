-- Data Processing

-- Remove null CustomerIDs
DELETE FROM sales_data
WHERE CustomerID IS NULL;

-- Exclude canceled orders: Invoices starting with 'C' indicate cancellations.
DELETE FROM sales_data
WHERE InvoiceNo LIKE 'C%';

-- Ensure positive quantities and prices:
DELETE FROM sales_data
WHERE Quantity <= 0 OR UnitPrice <= 0;

-- Create a TotalPrice column:
ALTER TABLE sales_data ADD COLUMN TotalPrice DECIMAL(10,2);

UPDATE sales_data
SET TotalPrice = Quantity * UnitPrice
WHERE Quantity IS NOT NULL AND UnitPrice IS NOT NULL;