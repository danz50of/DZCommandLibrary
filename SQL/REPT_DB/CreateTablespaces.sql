create tablespace <name> datafile 'D:\oradata\rept\<NAME>.dbf' size <size> g;

alter tablespace <name> add datafile 'D:\oradata\rept\<NAME><NUM>.dbf' size <size> <g|m>; 