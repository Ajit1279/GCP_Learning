/* Comments */
CREATE OR REPLACE PROCEDURE mydataset.create_customer(name STRING, OUT id STRING)
BEGIN
SET id = GENERATE_UUID();
INSERT INTO mydataset.customers (customer_id, name)
  VALUES(id, name);
SELECT FORMAT("Created customer %s (%s)", id, name);
END
