SELECT t.*
  FROM ProductMetafields AS t
  
SELECT t.Id, t.Handle, t.Title, (select x.value from ProductMetafields AS x where t.Id = x.ProductId and x.Key = 'english'
  FROM Products AS t
  
  
  
SELECT t.ProductId, t.Key, t.Value
  FROM ProductMetafields AS t