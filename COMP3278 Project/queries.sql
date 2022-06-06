-- Q1
SELECT * FROM Library;

-- Q2
SELECT * FROM Staff
WHERE ID_Library = 4;

SELECT * FROM Staff
WHERE salary>50000;

SELECT * FROM Staff
WHERE join_date > "2011-01-01"
ORDER BY join_date ASC;

SELECT * FROM Staff
WHERE position = 'Accounting Assistant';

-- Q3
SELECT * FROM Member
WHERE penalty > 0;

-- Q4
SELECT * FROM Collection
WHERE language = 'Chinese';

-- Q5
SELECT location, ID_item, Item.ISBN, Collection.name, status FROM Item, Library, Collection
WHERE Item.ID_library = Library.ID_library
AND Library.location = 'Jinnan'
AND Item.ISBN = Collection.ISBN
ORDER BY status ASC, Item.ISBN ASC;

-- Q6
SELECT location, ID_item, Item.ISBN, Collection.name, status FROM Item, Library, Collection
WHERE Item.ID_library = Library.ID_library
AND Collection.name = 'Unthinkable'
AND Item.ISBN = Collection.ISBN
ORDER BY status;

-- Q7
SELECT location, ID_item, Item.ISBN, Collection.name, status FROM Item, Library, Collection
WHERE Item.ID_library = Library.ID_library
AND Collection.type = 1
AND Item.ISBN = Collection.ISBN
ORDER BY Item.ISBN ASC, status ASC;

-- Q8
SELECT location, ID_item, Item.ISBN, Collection.name, status FROM Item, Library, Collection
WHERE Item.ID_library = Library.ID_library
AND category="Drama"
AND Item.ISBN = Collection.ISBN
ORDER BY Item.ISBN ASC, status ASC;

-- Q9
SELECT Member.ID_member, Member.name, Slot.ID_slot, Collection.name, borrow_date, return_date
FROM Member, Slot
LEFT OUTER JOIN Item
ON Slot.ID_Item = Item.ID_Item
LEFT OUTER JOIN Collection 
ON Item.ISBN = Collection.ISBN
WHERE Member.ID_member = Slot.ID_member
AND Member.ID_member = 35
ORDER BY ID_slot ASC;

-- Q10
SELECT Member.ID_member, Member.name, Member.card_ID, Slot.ID_slot, Collection.name, borrow_date, return_date
FROM Member, Slot, Item, Collection
WHERE Slot.ID_Item = Item.ID_Item AND Item.ISBN = Collection.ISBN AND Member.ID_member = Slot.ID_member
AND return_date < '2020-11-20'
ORDER BY ID_member ASC, ID_slot ASC;

-- Q11
SELECT Library.ID_library, location, item_amount, real_count 
FROM Library 
LEFT OUTER JOIN(
SELECT ID_library, COUNT(*) AS real_count 
FROM Item GROUP BY ID_library
) AS count 
ON count.ID_library = Library.ID_library;


-- Q12
SELECT Member.ID_member, Member.name, remain.empty
FROM Member
LEFT OUTER JOIN(
SELECT ID_member, COUNT(*) AS empty
FROM Slot
WHERE ID_Item IS NULL
GROUP BY ID_member) AS remain
ON Member.ID_member = remain.ID_member;

-- Q13
SELECT Member.ID_member, Member.name
FROM Member, Slot
WHERE Member.ID_member NOT IN (
SELECT Member.ID_member
FROM Member, Slot
WHERE Member.ID_member = Slot.ID_member AND Slot.ID_item IS NOT NULL
GROUP BY Member.ID_member)
GROUP BY Member.ID_member;

-- Q14
SELECT Member.ID_member, Member.name, Collection.ISBN, Collection.name
FROM Member, Slot, Item, Collection
WHERE Member.ID_member = Slot.ID_member AND Slot.ID_Item = Item.ID_Item AND Item.ISBN = Collection.ISBN
AND Collection.name = "Houseboat";

-- Q15
SELECT location, ID_item, Item.ISBN, Collection.name, status 
FROM Item, Library, Collection, 
(SELECT FLOOR(RAND()*20)AS num) AS rand 
WHERE Item.ID_library = Library.ID_library 
AND Collection.ID_search = rand.num 
AND Item.ISBN = Collection.ISBN 
ORDER BY status


