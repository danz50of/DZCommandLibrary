UPDATE XDC_PROCESS_OBJECT SET XPO_INIT_STRING = replace(XPO_INIT_STRING, 'Data Source=PROD;','Data Source=TEST;');

select * from xdc_process_object;

UPDATE XDC_PROCESS_OBJECT SET XPO_INIT_STRING = replace(XPO_INIT_STRING,'10.100.3.196:63080', '10.100.3.194:62080');

UPDATE XDC_PROCESS_OBJECT SET XPO_PROGID = replace(XPO_PROGID, 'IFSBaseDev','IFSBaseDevQA');

UPDATE XDC_PROCESS_OBJECT SET XPO_PROGID = replace(XPO_PROGID, 'PeerlessBaseDev','PeerlessBaseDevQA');

UPDATE XDC_PROCESS_OBJECT SET XPO_PROGID = replace(XPO_PROGID, 'TMSBaseDev','TMSBaseDevQA');

--UPDATE XDC_PROCESS_OBJECT SET XPO_INIT_STRING = replace(XPO_INIT_STRING, '|2004|','|APPS75|');


SELECT * FROM XDC_CONNECTION_STRINGS;

UPDATE XDC_CONNECTION_STRINGS  SET XCS_CONNECTION_STRING = replace(XCS_CONNECTION_STRING, 'Data Source=PROD;','Data Source=TEST');

UPDATE XDC_CONNECTION_STRINGS  SET XCS_CONNECTION_STRING = replace(XCS_CONNECTION_STRING, '10.100.3.196:63080','10.100.3.194:62080');

--UPDATE XDC_CONNECTION_STRINGS  SET XCS_CONNECTION_STRING = replace(XCS_CONNECTION_STRING, '|2004|','|APPS75|');

--UPDATE XDC_PROCESS_OBJECT SET XPO_PROGID = replace(XPO_PROGID, 'IFSBaseDevTest', 'IFSBaseDev');

--UPDATE XDC_PROCESS_OBJECT SET XPO_PROGID = replace(XPO_PROGID, 'PeerlessBaseDevTest', 'PeerlessBaseDev');

DELETE FROM XDC_TRANS

DELETE FROM XTMS_TASK_DETAIL

SELECT * FROM XTMS_TASK_DETAIL

COMMIT


select * from xdc_router_object

UPDATE XDC_ROUTER_OBJECT  SET XRO_INIT_STRING = replace(XRO_INIT_STRING, 'IFS_PROD','IFS_TEST');

UPDATE XDC_ROUTER_OBJECT  SET XRO_INIT_STRING = replace(XRO_INIT_STRING, '50410','50440');


COMMIT;