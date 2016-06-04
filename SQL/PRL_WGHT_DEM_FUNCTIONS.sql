CREATE OR REPLACE FUNCTION PRL_WGHT_DEM_Get_Weighted_Ave (
part_no_ in varchar2, percent1_ in number, percent2_ in number, percent3_ in number, percent4_ in number) return number
is
mnthly_avg_ number;
mnt_1_ number;
mnt_2_ number;
mnt_3_ number;
mnt_4_ number;
CURSOR Get_Wght_Avg is
select MONTH_1, MONTH_2, MONTH_3, MONTH_4 
FROM IFSINFO.PRL_WGHT_DEM_MS_MNTH_SUM
WHERE PART = part_no_;
BEGIN
OPEN Get_Wght_Avg;
FETCH Get_Wght_Avg INTO mnt_1_, mnt_2_, mnt_3_, mnt_4_;
mnthly_avg_ := 0;
mnthly_avg_ := mnthly_avg_ + ((percent1_ / 100)  * mnt_1_);
mnthly_avg_ := mnthly_avg_ + ((percent2_ / 100)  * mnt_2_);
mnthly_avg_ := mnthly_avg_ + ((percent3_ / 100)  * mnt_3_);
mnthly_avg_ := mnthly_avg_ + ((percent4_ / 100)  * mnt_4_);
CLOSE Get_Wght_Avg;
return mnthly_avg_;
END;