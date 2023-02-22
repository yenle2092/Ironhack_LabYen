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
FROM
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

    -- Challenge 2 - Alternative Solution
    
CREATE TEMPORARY TABLE tbl1
SELECT 
		a.au_id, 
        t.title_id, (SUM((t.advance * ta.royaltyper / 100)) + SUM((t.price * s.qty * t.royalty / 100 * ta.royaltyper / 100))) AS total
FROM titleauthor ta
INNER JOIN authors a
		   ON ta.au_id = a.au_id
INNER JOIN titles t
		   ON ta.title_id = t.title_id
INNER JOIN sales s
		   ON t.title_id = s.title_id
GROUP BY a.au_id, t.title_id
ORDER BY a.au_id
;

SELECT 
		tbl1.au_id, 
        SUM(tbl1.total) as profit
FROM tbl1
GROUP BY tbl1.au_id
ORDER BY profit DESC
LIMIT 3
;

--  Challenge 3: Most profiting author

/* Elevating from your solution in Challenge 1 & 2, create a permanent table named most_profiting_authors to hold the data about the most profiting authors. The table should have 2 columns:

au_id - Author ID
profits - The profits of the author aggregating the advances and royalties
*/

-- Challenge 3/ most_profiting_authors

CREATE TABLE most_profiting_authors
SELECT 
		tbl1.au_id, 
        SUM(tbl1.total) as profitS
FROM tbl1
GROUP BY tbl1.au_id
ORDER BY profits DESC
LIMIT 3
;



		



  
  

