-- question2: lấy ra tất cả các phòng ban --
SELECT * FROM department;

-- question3 lấy ra id của phòng ban "Sale" --
 SELECT departmentID FROM department WHERE departmentName= 'Sale';
 
  -- question4 lấy ra thông tin account có full name dài nhất--
SELECT MAX(LENGTH(fullname)) FROM `account`;
-- question5 Lấy ra thông tin account có full name dài nhất và thuộc phòng ban có id= 3 --
SELECT max(length(fullname)) FROM `account`
WHERE  accountID = 3;
 
 -- question6 Lấy ra tên group đã tham gia trước ngày 20/12/2019 --
 SELECT * FROM `group` WHERE creadate < '2019-12-20';
 
 -- question7 Lấy ra ID của question có >= 4 câu trả lời--
 SELECT * FROM question WHERE questionID >= 4;
 
 -- question8 Lấy ra các mã đề thi có thời gian thi >= 60 phút và được tạo trước ngày2019/12/20 --
 SELECT * FROM exam WHERE duration >='60 phút' AND createdate < '2019-12-20';
 
 -- question9 Lấy ra 5 group được tạo gần đây nhất--
 SELECT * FROM `group` ORDER BY  createdate DESC LIMIT 5;
 
 -- question10 Đếm số nhân viên thuộc department có id = 2--
 SELECT * FROM department WHERE departmentID = 2;

 
 -- question11 Lấy ra nhân viên có tên bắt đầu bằng chữ "D" và kết thúc bằng chữ "o" --
SELECT * FROM position WHERE positionName not like '%D%o';

-- question12 Xóa tất cả các exam được tạo trước ngày 20/12/2019--

DELETE xoa_bang.exam
FROM exam
  WHERE createdate > 2019-12-20;
-- question13 Xóa tất cả các question có nội dung bắt đầu bằng từ "câu hỏi"--
DELETE xoa_qe_cauhoi
  FROM question
  WHERE conten NOT LIKE 'cauhoi';

-- quesgtion14 Update thông tin của account có id = 5 thành tên "Nguyễn Bá Lộc" và
-- email thành loc.nguyenba@vti.com.vn--

UPDATE `account`
SET fullName = "Nguyễn Bá Lộc", email = 'loc.nguyen@vti.com.vn' WHERE accountID = 5;



-- Question 15: update account có id = 5 sẽ thuộc group có id = 4--
UPDATE groupaccount
SET accountID = 5
WHERE groupID = 4;