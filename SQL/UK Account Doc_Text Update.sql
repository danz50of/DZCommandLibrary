--select * from document_text where note_text like '%IBAN%';

UPDATE document_text_tab SET NOTE_TEXT = replace(NOTE_TEXT,'A/C name: Peerless-AV Ltd; Sort code: 60-92-42; A/C no: 41001358; SWIFT/BIC : CHASGB2L; IBAN : GB60CHAS60924241001358', 'A/C name: Peerless-AV Ltd;SWIFT/BIC : BARCGB22; IBAN : GB12BARC20035343568788') WHERE OUTPUT_TYPE = 'UKEUROBANK';
UPDATE document_text_tab SET NOTE_TEXT = replace(NOTE_TEXT,'A/C name: Peerless-AV Ltd; Sort code: 60-92-42; A/C no: 41001353;SWIFT/ BIC : CHASGB2L; IBAN : GB98CHAS60924241001353', 'A/C name: Peerless-AV Ltd; Sort code: 20-03-53; A/C no: 73286428;SWIFT/ BIC : BARCGB22; IBAN : GB69BARC20035373286428') WHERE OUTPUT_TYPE = 'UKCSTGBPBK';
UPDATE document_text_tab SET NOTE_TEXT = replace(NOTE_TEXT,'A/C name: Peerless-AV Ltd; Sort code: 60-92-42; A/C no: 41001357;SWIFT/ BIC : CHASGB2L; IBAN : GB87CHAS60924241001357', 'Peerless-AV Ltd;SWIFT/ BIC : BARCGB22; IBAN : GB93BARC20035352841500') WHERE OUTPUT_TYPE = 'UKDLLRBANK';
COMMIT;
/*
Euro:  A/C name: Peerless-AV Ltd; Sort code: 60-92-42; A/C no: 41001358; SWIFT/BIC : CHASGB2L; IBAN : GB60CHAS60924241001358 to IBAN:GB12BARC20035343568788 Swift/BIC:BARCGB22
A/C name: Peerless-AV Ltd;SWIFT/BIC : BARCGB22; IBAN : GB12BARC20035343568788

USDLR:   A/C name: Peerless-AV Ltd; Sort code: 60-92-42; A/C no: 41001357;SWIFT/ BIC : CHASGB2L; IBAN : GB87CHAS60924241001357 to IBAN:GB93BARC20035352841500 Swift/BIC:BARCGB22
USDLR:   A/C name: Peerless-AV Ltd;SWIFT/ BIC : BARCGB22; IBAN : GB93BARC20035352841500

GBP:   A/C name: Peerless-AV Ltd; Sort code: 60-92-42; A/C no: 41001353;SWIFT/ BIC : CHASGB2L; IBAN : GB98CHAS60924241001353   to Sort Code:20-03-53 A/C No: 73286428 - IBAN:GB69BARC20035373286428 Swift/BIC:BARCGB22
GBP:   A/C name: Peerless-AV Ltd; Sort code: 20-03-53; A/C no: 73286428;SWIFT/ BIC : BARCGB22; IBAN : GB69BARC20035373286428

*/