use publications;

-- Challenge 1 - Who Have Published What At Where?

Select  ta.au_id as "AUTHOR ID" , a.au_lname as "LAST NAME", a.au_fname as "FIRST NAME", t.title as TITLE, p.pub_name as PUBLISHER From titleauthor ta
LEFT JOIN authors a
on ta.au_id=a.au_id
LEFT JOIN titles t
ON ta.title_id = t.title_id
LEFT JOIN publishers p
on t.pub_id=p.pub_id
GROUP BY p.pub_name, ta.au_id, a.au_lname, a.au_fname, t.title;

-- Challenge 2 - Who Have Published How Many At Where?

Select  ta.au_id as "AUTHOR ID" , a.au_lname as "LAST NAME", a.au_fname as "FIRST NAME",  p.pub_name as PUBLISHER, count(t.title) as "TITLE COUNT" From titleauthor ta
LEFT JOIN authors a
on ta.au_id=a.au_id
LEFT JOIN titles t
ON ta.title_id = t.title_id
LEFT JOIN publishers p
on t.pub_id=p.pub_id
GROUP BY p.pub_name, ta.au_id, a.au_lname, a.au_fname;

-- Challenge 3 - Best Selling Authors

Select  ta.au_id as "AUTHOR ID" , a.au_lname as "LAST NAME", a.au_fname as "FIRST NAME", sum(s.qty) as "TOTAL" From titleauthor ta
LEFT JOIN authors a
on ta.au_id=a.au_id
LEFT JOIN titles t
ON ta.title_id = t.title_id
LEFT JOIN sales s
on t.title_id=s.title_id
GROUP BY ta.au_id, a.au_lname, a.au_fname
ORDER BY TOTAL desc
LIMIT 3;

-- Challenge 4 - Best Selling Authors Ranking
Select  ta.au_id as "AUTHOR ID" , a.au_lname as "LAST NAME", a.au_fname as "FIRST NAME", sum(ifnull(s.qty,0)) as "TOTAL" From titleauthor ta
LEFT JOIN authors a
on ta.au_id=a.au_id
LEFT JOIN titles t
ON ta.title_id = t.title_id
LEFT JOIN sales s
on t.title_id=s.title_id
GROUP BY ta.au_id, a.au_lname, a.au_fname
ORDER BY TOTAL desc;



