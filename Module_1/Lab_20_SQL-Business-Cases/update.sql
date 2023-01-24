-- Bonus Challenge - Updating and Deleting Database Records
UPDATE salesperson
SET Store="Miami"
WHERE ID=4;

select * from salesperson;

UPDATE customers
SET Email="ppicasso@gmail.com"
WHERE Name="Pablo Picasso";

UPDATE customers
SET Email="lincoln@us.gov"
WHERE Name="Abraham Lincoln";

UPDATE customers
SET Email="hello@napoleon.me"
WHERE Name="Napoléon Bonaparte";

select * from customers;

