-- REVENUES FOR 2019
USE H_Accounting;
SELECT * FROM account; -- There is a row called 'revenue'
-- Account code --> 4.01%

-- These table should be enough to answer the question 'REVENUES 2019'
-- statement
-- account
-- Journal entry
-- Journal entry line item
-- Statement section

-- TIP: remove tables from the schema that you're not currently using, you can always bring them back

-- WE SHOULD DEAL WITH THE DEBIT
SELECT a.account,
		SUM(i.debit) AS total_debit,
		SUM(i.credit) AS total_credit
FROM journal_entry_line_item AS i
INNER JOIN account AS a USING(account_id)
INNER JOIN journal_entry AS j USING(journal_entry_id)
WHERE account_code LIKE '401%' AND YEAR(j.entry_date) = '2019'
GROUP BY a.account
ORDER BY total_credit DESC;

-- PROFIT AND LOSS
-- COGS
SELECT -- a.account,
        SUM(i.debit) AS COGS-- USE DEBIT
        -- SUM(i.credit)-SUM(i.debit) AS COGS
FROM journal_entry_line_item AS i
INNER JOIN account AS a USING(account_id)
INNER JOIN journal_entry AS j USING(journal_entry_id)
WHERE a.account_code LIKE '501%' AND YEAR(j.entry_date) = '2019';

-- TOTAL EXPENSES
SELECT YEAR(j.entry_date) AS year,
		SUM(i.credit) AS expenses_credit,
        SUM(i.debit) AS expenses_debit -- USE DEBIT
        -- SUM(SUM(i.credit)) OVER() AS total_expenses
FROM journal_entry_line_item AS i
INNER JOIN account AS a USING(account_id)
INNER JOIN journal_entry AS j USING(journal_entry_id)
WHERE a.account_code LIKE '601%' AND YEAR(j.entry_date) = '2019'
GROUP BY year;

-- FINANCIAL EXPENSES (701)
SELECT YEAR(j.entry_date) AS year,
		SUM(i.credit) AS financial_expenses_credit,
        SUM(i.debit) AS financial_expenses_debit -- USE DEBIT
        -- SUM(SUM(i.credit)) OVER() AS total_expenses
FROM journal_entry_line_item AS i
INNER JOIN account AS a USING(account_id)
INNER JOIN journal_entry AS j USING(journal_entry_id)
WHERE a.account_code LIKE '701%' AND YEAR(j.entry_date) = '2019'
GROUP BY year;

-- DEPRECIATION
SELECT YEAR(j.entry_date) AS year,
		SUM(i.credit) AS depreciation_credit,
        SUM(i.debit) AS depreciation_debit -- USE DEBIT 
        -- SUM(SUM(i.credit)) OVER() AS total_expenses
FROM journal_entry_line_item AS i
INNER JOIN account AS a USING(account_id)
INNER JOIN journal_entry AS j USING(journal_entry_id)
WHERE a.account LIKE '%depreciation%' AND YEAR(j.entry_date) = '2019'
GROUP BY year;
-- ZERO DEPRECIATION

-- TAX
SELECT YEAR(j.entry_date) AS year,
		SUM(i.credit) AS tax_credit,
        SUM(i.debit) AS tax_debit -- USE DEBIT 
        -- SUM(SUM(i.credit)) OVER() AS total_expenses
FROM journal_entry_line_item AS i
INNER JOIN account AS a USING(account_id)
INNER JOIN journal_entry AS j USING(journal_entry_id)
WHERE a.account LIKE '%TAX%' AND YEAR(j.entry_date) = '2019'
GROUP BY year;

-- COME BACK WITH THE INCOME

-- IN THE BALANCE SHEET WE SHOULD USE BOTH CREDIT AND DEBIT
-- these transaction will end up in the retain earnings of the balance sheet