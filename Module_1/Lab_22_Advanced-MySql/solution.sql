use publications;

-- Challenge 1 - Most Profiting Authors

-- Step 1: Calculate the royalty of each sale for each author and the advance for each author and publication

SELECT ta.title_id as "TITLE ID" , 
	   ta.au_id as "AUTHOR ID",
	   (t.price * s.qty * t.royalty / 100 * ta.royaltyper / 100) AS sales_royalty,
       (t.advance * ta.royaltyper / 100) AS advance
FROM titleauthor ta
INNER JOIN titles t
ON t.title_id=ta.title_id 
INNER JOIN sales s
ON s.title_id=t.title_id ;
  
  -- Step 2: Aggregate the total royalties for each title and author
  
SELECT title_id as "TITLE ID", 
	   au_id,
       sum(sa.sales_royalty) as "ROYALTIES",
       sum(sa.advance) AS "ADVANCE"
FROM 
	(SELECT 
	   ta.title_id , 
	   ta.au_id ,
	   (t.price * s.qty * t.royalty / 100 * ta.royaltyper / 100) AS sales_royalty,
       (t.advance * ta.royaltyper / 100) AS advance
	FROM titleauthor ta
	INNER JOIN titles t
	ON t.title_id=ta.title_id 
	INNER JOIN sales s
	ON s.title_id=t.title_id ) sa
GROUP BY au_id, title_id;

-- Step 3: Calculate the total profits of each author

SELECT au_id as "AUTHOR ID",
	   (sum(prof.royal)+sum(prof.adv)) as PROFIT
FRom
	(SELECT title_id as "TITLE ID", 
	   au_id,
       sum(sa.sales_royalty) as royal,
       sum(sa.advance) AS adv
FROM 
	(SELECT 
	   ta.title_id , 
	   ta.au_id ,
	   (t.price * s.qty * t.royalty / 100 * ta.royaltyper / 100) AS sales_royalty,
       (t.advance * ta.royaltyper / 100) AS advance
	FROM titleauthor ta
	INNER JOIN titles t
	ON t.title_id=ta.title_id 
	INNER JOIN sales s
	ON s.title_id=t.title_id ) sa
GROUP BY au_id, title_id ) prof 
group by au_id
order by  profit desc
limit 3;



		



  
  

