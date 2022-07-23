SELECT	Users.Username AS [User Name], 
		--Documents.Filename AS [Filename], 
		--Documents.LockPath AS [Document Path], 
		--Documents.LockDate AS [Checked Out Date], 
		GETDATE() AS [Today's Date],
		count(documents.Filename) as NumOfDocuments
		--DATEDIFF(DAY,Documents.LockDate,GETDATE())AS [Days Checked Out]
FROM	Documents INNER JOIN
        Users ON Documents.UserID = Users.UserID
WHERE   (Documents.Deleted = 0) AND (DATEDIFF(DAY,Documents.LockDate,GETDATE())) >= 7 AND Documents.LockDate IS NOT NULL
group by users.Username
ORDER BY Users.UserName
