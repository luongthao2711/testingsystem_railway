-- Question 1: Tạo view có chứa danh sách nhân viên thuộc phòng ban sale 
CREATE VIEW dsach_nvien AS 
SELECT 
    *
FROM
    department de
WHERE
    EXISTS( SELECT
            COUNT(1)
        FROM
            `account` ac
        WHERE
            de.departmentID = ac.departmentID
                AND de.departmentID = 'sale');
                
-- Question 2: Tạo view có chứa thông tin các account tham gia vào nhiều group nhất
CREATE VIEW v_thong_tin AS
 
       SELECT 
    *
FROM
    account a
WHERE
    EXISTS( SELECT 
            *
        FROM
            groupaccount ga
        WHERE
            ga.accountID = a.accountID
        HAVING COUNT(ga.accountID) = (SELECT 
                MAX(c)
            FROM
                (SELECT 
                    COUNT(ga.accountID) AS c
                FROM
                    groupaccount
                GROUP BY ga.accountID) test));         
		
-- Question 3: Tạo view có chứa câu hỏi có những content quá dài 
-- (content quá 300 từ được coi là quá dài) và xóa nó đi
CREATE VIEW nhung_content_dai AS
SELECT 
    content
FROM
    question
WHERE
    LENGTH(content) > 10;
DELETE FROM nhung_content_dai;
-- Question 4: Tạo view có chứa danh sách các phòng ban có nhiều nhân viên nhất
CREATE VIEW dsach_pban AS
SELECT 
    *
FROM
    department de
WHERE
    EXISTS( SELECT 
            *
        FROM
            `account` ac
        WHERE
           de.departmentID = departmentID
        HAVING COUNT(de.departmentID) = (SELECT 
                MAX(A)
            FROM
                (SELECT 
                    COUNT(de.departmentID) AS A
                FROM
                    `account`
                GROUP BY de.departmentID) test));
-- Question 5: Tạo view có chứa tất các các câu hỏi do user họ Nguyễn tạo
CREATE VIEW user_ho_nguyen AS
SELECT qs.*, ac.fullname
FROM question qs
JOIN `Account` ac ON qs.CreatorID = ac.AccountID
WHERE ac.fullname = 'Nguyễn';