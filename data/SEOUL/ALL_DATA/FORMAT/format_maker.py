import sys, os
sys.path.append("/Users/leejunho/Desktop/git/python3Env/group_study/project_pre/func")
from d0_makelist_column import MakeList_column

infile = "../SEOUL_Day.txt"
#infile = "/Users/leejunho/Desktop/git/python3Env/group_study/project_pre/data_txt/BEIJING_Aqi/carbon_copied_data/n0_basic_day/Aqi_Beijing_Holi_re.txt"
COL_List = MakeList_column(infile)
Of = open("NEW.txt","w+")
for i in range(len(COL_List[0])):
    if i==0:
        Of.write("%s\n" %COL_List[0][i])
#        Of.write("%s TEMP_RANGE\n" %COL_List[0][i])
    else:
        Of.write("%s\n" %COL_List[0][i])
#        Of.write("%s %s\n" %(COL_List[0][i],(str(float(COL_List[12][i])-float(COL_List[10][i]))))) 
#         Of.write("%s %s\n" %(COL_List[0][i],(str(((float(COL_List[10][i])+float(COL_List[12][i]))/2.0)))))
Of.close()
