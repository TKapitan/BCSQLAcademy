
/* Základní SELECT */
SELECT
	*
FROM [dbo].[CRONUS CZ s_r_o_$Customer$437dbf0e-84ff-417a-965d-ed2bb9650972] A


/* SELECT s definicí polí */
SELECT
	A.[VAT Registration No_],
	A.[No_],
	A.[Name]
	--,*
FROM [dbo].[CRONUS CZ s_r_o_$Customer$437dbf0e-84ff-417a-965d-ed2bb9650972] A


/* SELECT s filtrem øádkù */
SELECT
	A.[VAT Registration No_],
	*
FROM [dbo].[CRONUS CZ s_r_o_$Customer$437dbf0e-84ff-417a-965d-ed2bb9650972] A
WHERE
	A.[VAT Registration No_] != ''


/* SELECT s filtrem øádkù (pokroèilejší) */
SELECT
	A.[VAT Registration No_],
	*
FROM [dbo].[CRONUS CZ s_r_o_$Customer$437dbf0e-84ff-417a-965d-ed2bb9650972] A
WHERE
	A.[VAT Registration No_] != ''
	-- AND Contact LIKE 'Fr.%'
	-- AND SUBSTRING(Contact, 1, 3) = 'Fr.'
	-- AND Name NOT LIKE '%Design%'


/* SELECT s rozšíøeným ResultSetem */
SELECT
	A.[VAT Registration No_],
	5+3*8,
	A.Address + ', ' + A.City + ', ' + A.[Post Code],
	CAST(A.[Last Modified Date Time] as DATE) as [Last Modified Date],
	FORMAT(A.[Last Modified Date Time], 'dd.MM.yyyy') as [Last Modified Date Readable],
	YEAR(A.[Last Modified Date Time]) as [Year of Last Modification],
	MONTH(A.[Last Modified Date Time]) as [Month of Last Modification],
	FORMAT(GETDATE(), 'dd.MM.yyyy') as [Today Readable],
	DATEDIFF(day, A.[Last Modified Date Time], GETDATE()) as [Modified before DAYS],
	DATEDIFF(month, A.[Last Modified Date Time], GETDATE()) as [Modified before MONTHS],
	LEN(A.Address) as [Address Lenght],
	CASE A.[Currency Code] 
		WHEN 'EUR' THEN 'EUR'
		ELSE 'Other currency'
	END as [Is EUR Currency],
	CASE 
		WHEN A.[Currency Code] = 'EUR' AND A.[Country_Region Code] = 'ES' THEN 'ES EUR'
		WHEN A.[Currency Code] = 'EUR' AND A.[Country_Region Code] = 'NL' THEN A.[Country_Region Code] + ' EUR'
		WHEN A.[Currency Code] = 'EUR' THEN 'Other EUR'
		WHEN A.[Customer Disc_ Group] = '' THEN 'Neuplny zakaznik'
		ELSE ''
	END as [Something I Don't Understand]
FROM [dbo].[CRONUS CZ s_r_o_$Customer$437dbf0e-84ff-417a-965d-ed2bb9650972] A
WHERE
	A.[VAT Registration No_] != ''


/* AGREGACE */
SELECT
	SUM(Amount),
	COUNT(Amount),
	MAX(Amount),
	MIN(Amount)
FROM [dbo].[CRONUS CZ s_r_o_$Customer$437dbf0e-84ff-417a-965d-ed2bb9650972] A


/* AGREGACE 2 */
SELECT
	A.[SalesPerson Code],
	A.[Country_Region Code],
	SUM(Amount),
	COUNT(Amount),
	MAX(Amount),
	MIN(Amount)
FROM [dbo].[CRONUS CZ s_r_o_$Customer$437dbf0e-84ff-417a-965d-ed2bb9650972] A
GROUP BY A.[SalesPerson Code], A.[Country_Region Code]


/* AGREGACE s FILTREM */
SELECT
	A.[SalesPerson Code],
	A.[Country_Region Code],
	SUM(Amount) as [Sum Amount],
	COUNT(Amount) as [Count Amount],
	MAX(Amount) as [Max Amount],
	MIN(Amount) as [Min Amount]
FROM [dbo].[CRONUS CZ s_r_o_$Customer$437dbf0e-84ff-417a-965d-ed2bb9650972] A
GROUP BY A.[SalesPerson Code], A.[Country_Region Code]
HAVING 
	SUM(Amount) < 0 
	AND MAX(Amount) < 0


/* RAZENI */
SELECT
	A.[SalesPerson Code],
	A.[Country_Region Code],
	SUM(Amount) as [Sum Amount],
	COUNT(Amount) as [Count Amount],
	MAX(Amount) as [Max Amount],
	MIN(Amount) as [Min Amount]
FROM [dbo].[CRONUS CZ s_r_o_$Customer$437dbf0e-84ff-417a-965d-ed2bb9650972] A
GROUP BY A.[SalesPerson Code], A.[Country_Region Code]
HAVING 
	SUM(Amount) < 0 
ORDER BY [Count Amount], MAX(Amount)


/* Poøadí vyhodnocování SELECT
		1. Získání dat (FROM, JOIN)
		2. Filtr øádkù (WHERE)
		3. Seskupení (GROUP BY)
		4. Filtr dle seskupení (HAVING)
		5. ResultSet (SELECT)
		6. Øazení & Stránkování (ORDER BY, LIMIT/OFFSET)
			Tj. pouze v øazení a stránkování mùžeme používat aliasy!
*/


/* SPOJOVANI TABULEK

(INNER) JOIN: Returns records that have matching values in both tables
LEFT (OUTER) JOIN: Returns all records from the left table, and the matched records from the right table
RIGHT (OUTER) JOIN: Returns all records from the right table, and the matched records from the left table
FULL (OUTER) JOIN: Returns all records when there is a match in either left or right table
---
CROSS JOIN: Cartesian product of all records from both tables
*/

SELECT COUNT(*) FROM [dbo].[CRONUS CZ s_r_o_$Sales Header$437dbf0e-84ff-417a-965d-ed2bb9650972]
-- 44
SELECT COUNT(*) FROM [dbo].[CRONUS CZ s_r_o_$Sales Line$437dbf0e-84ff-417a-965d-ed2bb9650972]
-- 95

SELECT
	SH.*,
	SL.*
FROM [dbo].[CRONUS CZ s_r_o_$Sales Header$437dbf0e-84ff-417a-965d-ed2bb9650972] SH
--INNER JOIN [dbo].[CRONUS CZ s_r_o_$Sales Line$437dbf0e-84ff-417a-965d-ed2bb9650972] SL ON (SH.[Document Type] = SL.[Document Type] AND SH.[No_] = SL.[Document No_])
--LEFT JOIN [dbo].[CRONUS CZ s_r_o_$Sales Line$437dbf0e-84ff-417a-965d-ed2bb9650972] SL ON (SH.[Document Type] = SL.[Document Type] AND SH.[No_] = SL.[Document No_])
--RIGHT JOIN [dbo].[CRONUS CZ s_r_o_$Sales Line$437dbf0e-84ff-417a-965d-ed2bb9650972] SL ON (SH.[Document Type] = SL.[Document Type] AND SH.[No_] = SL.[Document No_])
--FULL JOIN [dbo].[CRONUS CZ s_r_o_$Sales Line$437dbf0e-84ff-417a-965d-ed2bb9650972] SL ON (SH.[Document Type] = SL.[Document Type] AND SH.[No_] = SL.[Document No_])

SELECT
	C.*,
	CI.*
FROM [dbo].[CRONUS CZ s_r_o_$Customer$437dbf0e-84ff-417a-965d-ed2bb9650972] C
CROSS JOIN [dbo].[CRONUS CZ s_r_o_$Company Information$437dbf0e-84ff-417a-965d-ed2bb9650972] CI
