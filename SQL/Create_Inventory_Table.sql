CREATE TABLE IFSINFO.PRL_PART_REVIEW
(
USERNAME VARCHAR2(50),
RUN_DATE_TIME DATE,
INVENTORY_PART_NUMBER VARCHAR2(50),
NUMBER_RESERVED INTEGER,
SHOP_ORD_RESERVED INTEGER,
CUST_ORD_RESERVED INTEGER,
CORRECTED CHAR(1) DEFAULT 'N',
DATE_CORRECTED DATE,
IGNORED CHAR(1) DEFAULT 'N',
DATE_IGNORED DATE
)
TABLESPACE IAL_DATA
LOGGING 
NOCACHE
NOPARALLEL
NOMONITORING;
COMMIT;

CREATE TABLE IFSINFO.PRL_INV_ADJ
(
INVENTORY_PART_NUMBER VARCHAR2(50),
PART_LOCATION VARCHAR2(35),
QTY_RESERVED NUMBER,
ADJUST CHAR(1) DEFAULT 'N',
USERNAME VARCHAR2(50),
SET_RESERVED_TO INTEGER,
DATE_REPORTED DATE
)
TABLESPACE IAL_DATA
LOGGING 
NOCACHE
NOPARALLEL
NOMONITORING;
COMMIT;

GRANT ALL ON IFSINFO.PRL_INV_ADJ TO IFSAPP WITH GRANT OPTION;
GRANT ALL ON IFSINFO.PRL_PART_REVIEW TO IFSAPP WITH GRANT OPTION;

COMMIT;