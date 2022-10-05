-- Question 1: Tạo store để người dùng nhập vào tên phòng ban 
-- in ra tất cả các account thuộc phòng ban đó
DELIMITER $$
CREATE PROCEDURE get_dep_q1()
BEGIN
SELECT
    *
FROM
    account a
        JOIN
    department d ON a.departmentID = d.departmentID;
    END$$
    DELIMITER ; 
    -- USE
    CALL get_dep_q1();
    -- Question 2: Tạo store để in ra số lượng account trong mỗi group
    DELIMITER $$
    CREATE PROCEDURE get_ac_gr_q2(IN in_groupID TINYINT)
    BEGIN 
  SELECT 
    COUNT(ga.accountID) AS sl_acc
FROM
    groupaccount ga
        JOIN
    `Group` g ON g.groupID = ga.groupID
WHERE
    g.groupID =in_groupID;
	END$$ 
    DELIMITER;
    -- USE 
    CALL get_ac_gr_q2 ('');
-- Question 3: Tạo store để thống kê mỗi type question 
-- bao nhiêu question được tạo trong tháng hiện tại
DROP PROCEDURE IF EXISTS get_typ_qes_q3;
DELIMITER $$
create procedure get_typ_qes_q3()
		begin
			SELECT 
				tq.*, COUNT(q.TypeID) as sl_question
			FROM
				typequestion tq
					LEFT JOIN
				question q ON tq.TypeID = q.TypeID
			WHERE
				YEAR(q.CreateDate) = YEAR(NOW())
					AND MONTH(q.createDate) = MONTH(NOW())
			GROUP BY tq.typeID;
		End$$
DELIMITER ;

-- Question 4: Tạo store để trả ra id của typequestion có nhiều câu hỏi nhất
DELIMITER $$
CREATE PROCEDURE get_max_cau_hoi_q4 (OUT out_qes_id TINYINT)
BEGIN 
WITH cte_max_max_cau_hoi AS 
	(SELECT 
    COUNT(qs.TypeID) AS total_question
FROM
    question qs
GROUP BY qs.TypeID)
			SELECT 
    tq.TypeID, COUNT(q.TypeID) AS total
FROM
    typequestion tq
        JOIN
    question q ON tq.TypeID = q.TypeID
GROUP BY tq.TypeID
			HAVING total = (SELECT MAX(total_question) FROM cte_max_max_cau_hoi );
 END$$
DELIMITER ;
-- Question 5: Sử dụng store ở question 4 để tìm ra tên của typequestion--

DELIMITER $$  
CREATE PROCEDURE get_max_cau_hoi_q5 ()
BEGIN 
 WITH cte_max_q5 AS 
		(SELECT COUNT(qs.TypeID) AS total_question 
		FROM question qs 
		GROUP BY qs.TypeID)
			SELECT tq.TypeName, COUNT(q.TypeID) AS total_type
			FROM typequestion tq
	     JOIN question q ON tq.TypeID = q.TypeID
			GROUP BY tq.TypeID  
			HAVING total_type = (SELECT MAX(total_question) FROM cte_max_q5 );
        END$$
        DELIMITER ;
        

-- Question 6: Viết 1 store cho phép người dùng nhập vào 1 chuỗi và 
-- trả về group có tên chứa chuỗi của người dùng nhập vào hoặc trả về 
-- user có username chứa chuỗi của người dùng nhập vào

DELIMITER $$
CREATE PROCEDURE proc_cau6(
	IN in_sequence VARCHAR(255))
		BEGIN
			SELECT a.username AS result FROM ACCOUNt a WHERE a.username LIKE CONCAT('%', in_sequence, '%')
			UNION
			SELECT g.groupName AS result FROM `group` g WHERE g.GroupName LIKE CONCAT('%', in_sequence, '%');
		END$$
DELIMITER ;



-- Question 7: Viết 1 store cho phép người dùng nhập vào thông tin fullName, email và trong store sẽ tự động gán
-- username sẽ giống email nhưng bỏ phần @..mail đi
-- positionID: sẽ có default là developer
-- departmentID: sẽ được cho vào 1 phòng chờ
-- Sau đó in ra kết quả tạo thành công

DELIMITER $$
CREATE PROCEDURE get_create_acc_q7 (
	IN in_fullname VARCHAR(255),
	IN in_email VARCHAR(100))
BEGIN 
		DECLARE positionID_ SMALLINT DEFAULT 1;
		DECLARE departmentID_ TINYINT DEFAULT 13;
		DECLARE usename VARCHAR(100);
        DECLARE createdate DATETIME;

INSERT INTO `account` (username, positionID, departmentID, email, fullname)
		VALUES (usename, positionID_, departmentID_, in_email, in_fullname);
END $$
DELIMITER ;



-- Question 8: Viết 1 store cho phép người dùng nhập vào Essay hoặc Multiple-Choice
-- để thống kê câu hỏi essay hoặc multiple-choice nào có content dài nhất 


-- Question 9: Viết 1 store cho phép người dùng xóa exam dựa vào ID--
DELIMITER $$
CREATE PROCEDURE  get_delete_id_q9(IN in_examID TINYINT)
BEGIN 
DELETE FROM examquestion WHERE examID = in_examID;
END$$
DELIMITER ;

-- Question 10: Tìm ra các exam được tạo từ 3 năm trước và xóa các exam đó đi 
-- (sử dụng store ở câu 9 để xóa)
-- Sau đó in số lượng record đã remove từ các table liên quan trong khi removing




-- Question 11: Viết store cho phép người dùng xóa phòng ban bằng cách 
-- người dùng nhập vào tên phòng ban và các account thuộc phòng ban đó 
-- sẽ được chuyển về phòng ban default là phòng ban chờ việc

DELIMITER $$
CREATE PROCEDURE get_delete_q11(IN in_department_name VARCHAR(255))
BEGIN 
DECLARE v_departmentID TINYINT;
SELECT 
    departmentID
INTO v_departmentID FROM
    department d
WHERE a.departmentID = v_departmentID; 
DELETE FROM department de WHERE de.departmentName = in_department_name;
END$$
DELIMITER ;
-- Question 12: Viết store để in ra mỗi tháng có bao nhiêu câu hỏi được tạo trong nămnay


-- Question 13: Viết store để in ra mỗi tháng có bao nhiêu câu hỏi được tạo trong 6tháng gần đây nhất
-- (Nếu tháng nào không có thì sẽ in ra là "không có câu hỏi nào trong tháng")
