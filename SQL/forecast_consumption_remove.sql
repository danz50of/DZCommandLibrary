         UPDATE inventory_part_tab
            SET forecast_consumption_flag = 'NOFORECAST',
                note_text = 'Unchecked Online Consumption flag on ' || SYSDATE || ' using G470902_DeleteSpareParts.sql script For forecast MPS Set 2.',
                rowversion = sysdate
            WHERE contract = 'MP'
            --and part_no in ('055-KPJF2-B','055-KPJF2-S','055-KPRS-B-1','055-KPRS-S-1','055-KPRS-W-1','055-KUNV-B-2','055-KUNV-S-2','055-KUNV-W-2',
            and part_no in ('CMJ450','CMJ453','CMJ455','CMJ500')--,'HTA730','HTA730S','HTA740','HTA740S','HTA750','HTA750S','HTA760','HTA760S','HTF100S','HTF200S','HTFT640S','HTFT660S','HTP730','HTP740','HTT100S','HTT200S','ONE-TP','ONE-TP-S','PA730','PA730-S','PA740','PA740-S','PCS200','PF640','PF650','PF660','PFT640','PFT640-S','PFT660','PFT660-S','PJF2-UNV','PJF2-UNV-S','PP730','PP730-S','PP740','PP740-S','PRG-1','PRG-1S','PRG-1W','PRG-UNV','PRG-UNV-S','PRG-UNV-W','PRS-UNV','PRS-UNVP','PRS-UNVP-S','PRS-UNVP-W','PRS-UNV-S','PRS-UNV-W','PS200','PS200-S','PWMT300','SA730P','SA730P-S','SA740P','SA740P-S','SA745P','SA745P-S','SA745PU','SA745PU-S','SA750P','SA750P-S','SA750PU','SA750PU-S','SA760P','SA760P-S','SA760PU','SA760PU-S','SA770PU','SA770PU-S','SAL730P','SAL730P-S','SF640','SF640P','SF640P-S','SF640-S','SF650','SF650P','SF650P-S','SF650-S','SF660','SF660P','SF660P-S','SF660-S','SF670','SF670P','SP730P','SP730P-S','SP740P','SP740P-S','ST635','ST635P')
            --AND   part_no = newrec_.part_no
            AND   forecast_consumption_flag = 'FORECAST';
            
            
            commit;