select InventoryCD, attr1.Attribute as "Universal Product Code",attr2.Attribute as Config from InventoryItem 
left join (Select CSAnswers.RefNoteID,ISNULL(CSAttributeDetail.Description,CSAnswers.Value) as Attribute  from  CSAnswers inner join CSAttribute on CSAnswers.AttributeID = CSAttribute.AttributeID and CSAttribute.Description = 'Universal Product Code'
	left join CSAttributeDetail on CSAnswers.AttributeID=CSAttributeDetail.AttributeID and CSAnswers.Value = CSAttributeDetail.ValueID ) attr1
	on InventoryItem.NoteID = attr1.RefNoteID
left join (Select CSAnswers.RefNoteID,ISNULL(CSAttributeDetail.Description,CSAnswers.Value) as Attribute  from  CSAnswers inner join CSAttribute on CSAnswers.AttributeID = CSAttribute.AttributeID and CSAttribute.Description = 'Configurable Attributes'
   left join CSAttributeDetail on CSAnswers.AttributeID=CSAttributeDetail.AttributeID and CSAnswers.Value = CSAttributeDetail.ValueID ) attr2
	on InventoryItem.NoteID = attr2.RefNoteID




	
select * from CSAttribute