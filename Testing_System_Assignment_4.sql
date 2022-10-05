-- question1 Viết lệnh để lấy ra danh sách nhân viên và thông tin phòng ban của họ --
 SELECT 
    *
FROM
  `account` AS A
       LEFT JOIN
    department AS DE ON A.departmentID = DE.departmentID;

-- question2 Viết lệnh để lấy ra thông tin các account được tạo sau ngày 20/12/2010--
 SELECT 
    *
FROM
    `account`
WHERE
    createdate > '2010-12-20';
  
 -- question3 Viết lệnh để lấy ra tất cả các developer --
 SELECT 
  A.*, p.positionName
FROM
    `account` AS A
        JOIN
position AS P ON P.positionID = A.positionID
    WHERE P.positionName = 'Dev';
    
 
 -- question4 Viết lệnh để lấy ra danh sách các phòng ban có >3 nhân viên --
 SELECT 
    DE.* , count(A.departmentID)
FROM
    `account` AS A
        JOIN
    department AS DE ON A.departmentID = DE.departmentID
 GROUP BY DE.departmentID
 HAVING count(A.departmentID)>3;
 
 -- question5Viết lệnh để lấy ra danh sách câu hỏi được sử dụng trong đề thi nhiều nhất--
  
  SELECT 
    COUNT(*)
FROM
    examquestion eq
GROUP BY eq.examID
ORDER BY count(*) DESC LIMIT 1;


SELECT 
    q.*, count(eq.examID) as c
FROM
    question q
        JOIN
    examquestion eq ON q.questionID = eq.questionID
    GROUP BY eq.examID HAVING c = 1;

 -- question6Thống kê mỗi category Question được sử dụng trong bao nhiêu Question--
 SELECT 
 CQ.categoryID, CQ.categoryName, count(Q.categoryID)
FROM
  categoryquestion AS CQ
        LEFT JOIN
   question AS Q ON CQ.categoryID = Q.categoryID
    GROUP BY CQ.categoryID
    ORDER BY CQ.categoryID;
    
    -- question7 Thông kê mỗi Question được sử dụng trong bao nhiêu Exam --
SELECT 
    Q.content, COUNT(EQ.questionID) AS sl_exam
FROM
    question AS Q
        LEFT JOIN
    examquestion AS EQ ON Q.questionID = EQ.questionID
    GROUP BY Q.questionID
    ORDER BY EQ.examID;
    -- question8 Lấy ra Question có nhiều câu trả lời nhất--
SELECT 
    Q.QuestionID, Q.Content, COUNT(A.QuestionID) AS 'max_cau_tra_loi'
FROM
    Question Q
         JOIN
    Answer A ON Q.QuestionID = A.QuestionID
GROUP BY A.QuestionID
HAVING COUNT(A.QuestionID) = (SELECT 
        MAX(Q1)
    FROM
        (SELECT 
            COUNT(A.QuestionID) AS Q1
        FROM
            Answer A
        RIGHT JOIN Question Q ON A.QuestionID = Q.QuestionID
        GROUP BY A.QuestionID) AS MaxQ1);
   
 -- question9 Thống kê số lượng account trong mỗigroup--
 SELECT 
    G.groupID, COUNT(GA.accountID) AS sl_ac_trong_gr
FROM
    `GROUP` AS G
       RIGHT JOIN
    groupaccount AS GA ON G.groupID = GA.groupID
GROUP BY GA.accountID;

-- question10Tìm chức vụ có ít người nhất--

SELECT 
    po.positionName, count(ac.positionID)
FROM
    `account` ac
        JOIN
    position po ON ac.positionID = po.positionID
    GROUP BY po.positionID
    LIMIT 1;
   
-- question11Thống kê mỗi phòng ban có bao nhiêu dev, test, scrum master, PM--
    SELECT 
    D.DepartmentID,
    D.DepartmentName,
    COUNT(P.PositionID)
FROM
    Position P
		JOIN
    `Account` A ON P.PositionID = A.PositionID
        RIGHT JOIN
    Department D ON A.DepartmentID = D.DepartmentID
GROUP BY A.DepartmentID
ORDER BY A.DepartmentID ASC;
-- question12 Lấy thông tin chi tiết của câu hỏi bao gồm: thông tin cơ bản của
-- question, loại câu hỏi, ai là người tạo ra câu hỏi, câu trả lời là gì--

SELECT 
    q.questionID, q.content, ac.fullname, aw.content
FROM
    question AS q 
JOIN 
categoryquestion AS cq ON q.categoryID = cq.categoryID 
JOIN
`account` AS ac ON q.creatorID = ac.accountID 
JOIN
answer AS aw ON q.questionID = aw.questionID
JOIN
    typequestion AS tq ON q.typeID = tq.typeID
    GROUP BY q.questionID;
  
-- question13 Lấy ra số lượng câu hỏi của mỗi loại tự luận hay trắc nghiệm --
SELECT 
    q.content, tq.typeName, count(tq.typeID) `slg_cau_hoi`
FROM
    question q
        JOIN
    typequestion tq ON q.typeID = tq.typeID
    GROUP BY tq.typeID;
    
    

-- question14,15Lấy ra group không có account nào--
SELECT 
    *, count(ga.groupID)
FROM
    `group` gr
        LEFT JOIN
    groupaccount ga ON gr.groupID = ga.groupID
    WHERE ga.groupID Is NULL;
    
-- question16Lấy ra question không có answer nào--

SELECT 
    qe.*,count(aw.questionId)
FROM
    question qe
        JOIN
    answer aw ON qe.questionID = aw.questionID
WHERE
    aw.questionID IS NULL;

-- Question 17:a) Lấy các account thuộc nhóm thứ 1--
-- b) Lấy các account thuộc nhóm thứ 2--
-- c) Ghép 2 kết quả từ câu a) và câu b) sao cho không córecord nào trùng nhau--

SELECT 
    GO.*, count(A.accountID) AS `ac_nhom1`
FROM
    groupaccount AS GO
        JOIN
    `account` AS A ON GO.accountID = A.accountID
    GROUP BY A.accountID
HAVING count(GO.groupID) = 1
    UNION
    SELECT 
    GO.*, count(A.accountID) AS `ac_nhom2`
FROM
    groupaccount AS GO
        JOIN
    `account` AS A ON GO.accountID = A.accountID
    GROUP BY A.accountID
    HAVING count(GO.groupID) = 2;




-- Question 18:a) Lấy các group có lớn hơn 5 thành viên--
-- b) Lấy các group có nhỏ hơn 7 thành viên--
-- c) Ghép 2 kết quả từ câu a) và câu b)--

SELECT 
    GR.*, count(GT.accountID) AS 'slg_ac_trong_gr'
FROM
    `group` AS GR
       LEFT JOIN
    groupaccount AS GT ON GR.groupID = GT.groupID
GROUP BY GT.groupID
HAVING count(GT.groupID) > 2
UNION ALL
SELECT 
    GR.*, count(GT.accountID) AS 'slg_ac_trong_gr'
FROM
    `group` AS GR
        JOIN
    groupaccount AS GT ON GR.groupID = GT.groupID
GROUP BY GT.groupID
HAVING count(GT.groupID) < 7;