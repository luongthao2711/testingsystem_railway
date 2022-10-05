-- Question 1: Tạo trigger không cho phép người dùng nhập vào Group có ngày tạotrước 1 năm trước
DELIMITER $$
CREATE TRIGGER trigger_createdate
BEFORE INSERT ON `group`
	FOR EACH ROW
		BEGIN
IF NEW.`createdate` > YEAR (NOW()) -1 THEN
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT='do not allow user input' ;
	END IF;
END$$
DELIMITER ;


-- Question 2: Tạo trigger Không cho phép người dùng thêm bất kỳ user nào vào
-- department "Sale" nữa, khi thêm thì hiện ra thông báo "Department
-- "Sale" cannot add more user"

DELIMITER $$
CREATE TRIGGER trigger_dep 
BEFORE INSERT ON `account` 
	FOR EACH ROW 
		BEGIN 
        DECLARE de_departmentID TINYINT;
        SELECT departmentID INTO de_departmentID
        FROM department
        WHERE departmentName = 'Sale';
IF NEW. `departmentID`= de_departmentID THEN
	SIGNAL SQLSTATE '45000' 
	SET MESSAGE_TEXT= 'Department Sale cannot add more user';
	END IF;
END$$
DELIMITER ; 



-- Question 3: Cấu hình 1 group có nhiều nhất là 5 user

DELIMITER $$
CREATE TRIGGER trigger_user
	BEFORE INSERT ON `groupaccount`
FOR EACH ROW
	BEGIN 
		DECLARE g_groupID TINYINT;
SELECT 
    COUNT(groupID) INTO g_groupID
FROM
    `group` g
	WHERE groupID = NEW.groupID;
IF count_acc >= 5 THEN
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT ='canot insert account with groupID' ;
	END IF;
END$$
DELIMITER ;



-- Question 4: Cấu hình 1 bài thi có nhiều nhất là 10 Question
DELIMITER $$
CREATE TRIGGER trigger_exam
BEFORE INSERT ON `examquestion`
FOR EACH ROW 
BEGIN
DECLARE e_examID TINYINT;
SELECT 
   COUNT(examID) INTO e_examID
FROM
  examquestion eq
    WHERE examID = NEW.examID;
IF question_max >=10 THEN 
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'canot insert question with examID';
    END IF ;
    END$$
    DELIMITER ; 
    


-- Question 5: Tạo trigger không cho phép người dùng xóa tài khoản có email là
-- admin@gmail.com (đây là tài khoản admin, không cho phép user xóa),
-- còn lại các tài khoản khác thì sẽ cho phép xóa và sẽ xóa tất cả các thông
-- tin liên quan tới user đó
DELEMITER $$
CREATE TRIGGER trigger_delete_acc
BEFORE DELETE ON `account`
FOR EACH ROW
BEGIN
	IF OLD.email = 'admin@gmail.com' THEN
     SIGNAL SQLSTATE '45000'
     SET MESSAGE_TEXT = 'this is an admin account that cannot be deleted',
     END IF;
 END$$
DELIMITER ; 
     -- Question 6: Không sử dụng cấu hình default cho field DepartmentID của table
-- Account, hãy tạo trigger cho phép người dùng khi tạo account không điền
-- vào departmentID thì sẽ được phân vào phòng ban "waiting Department"

DELIMITER $$
CREATE TRIGGER trigger_dep
BEFORE INSERT ON `account`
 FOR EACH ROW 
BEGIN 
DECLARE v_depparement VARCHAR(255);
SELECT 
    departmentID
INTO v_department FROM
    department
WHERE
    departmentName = 'waiting Department';
IF NEW.departmentID IS NULL THEN
SET NEW.departmentID = v_department;
END IF ;
END$$
DELIMITER ; 


-- Question 7: Cấu hình 1 bài thi chỉ cho phép user tạo tối đa 4 answers cho mỗi
-- question, trong đó có tối đa 2 đáp án đúng.
DROP TRIGGER IF EXISTS trigger_answer;
DELIMITER $$
CREATE TRIGGER trigger_answer
BEFORE INSERT ON answer 
FOR EACH ROW 
BEGIN
DECLARE v_a_questionID TINYINT;
DECLARE v_a_iscorrect VARCHAR(50);
SELECT 
    COUNT(questionID)
INTO v_a_questionID FROM answer
WHERE questionID = NEW.questionID;
SELECT 
    COUNT(1)
INTO v_a_iscorrect FROM answer
WHERE
    questionID = NEW.questionID
        AND iscorrect = NEW.isccorect;
IF (v_a_questionID = 4) OR (v_a_isccorect = 2) THEN
SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT = 'a test up to 4 question';
END IF;
END$$
DELIMITER ;


-- Question 8: Viết trigger sửa lại dữ liệu cho đúng:
-- Nếu người dùng nhập vào gender của account là nam, nữ, chưa xác định
-- Thì sẽ đổi lại thành M, F, U cho giống với cấu hình ở database

-- Question 9: Viết trigger không cho phép người dùng xóa bài thi mới tạo được 2 ngày
DROP TRIGGER IF EXISTS trigger_exam;
DELIMITER $$
CREATE TRIGGER trigger_exam
BEFORE DELETE ON exam
FOR EACH ROW
BEGIN
DECLARE V_createdate DATETIME;
SET v_createdate = DATE_SUB(NOW(),INTERVAL 2 DAY);
IF (OLD.createdate >= v_createdate) THEN 
SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT = 'can not delete';
END IF;
END$$
DELIMITER ;
-- Question 10: Viết trigger chỉ cho phép người dùng chỉ được update, delete các
-- question khi question đó chưa nằm trong exam nào




-- Question 12: Lấy ra thông tin exam trong đó:
-- Duration <= 30 thì sẽ đổi thành giá trị "Short time"
-- 30 < Duration <= 60 thì sẽ đổi thành giá trị "Medium time"
-- Duration > 60 thì sẽ đổi thành giá trị "Long time"



-- Question 13: Thống kê số account trong mỗi group và in ra thêm 1 column nữa có tên
-- là the_number_user_amount và mang giá trị được quy định như sau: