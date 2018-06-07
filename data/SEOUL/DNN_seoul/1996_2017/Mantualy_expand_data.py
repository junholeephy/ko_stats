import sys, os
sys.path.append("/Users/leejunho/Desktop/git/python3Env/group_study/project_pre/func")
from d0_makelist import MakeList

ROW_list = MakeList("Expand.txt")

Expand_Row_list = []
for EX in range(100):
    for i in range(len(ROW_list)):
        if(i==0):
            if(EX==0):
                Expand_Row_list.append(ROW_list[i])
                continue
            else:
                continue
        Expand_Row_list.append(ROW_list[i])
#print(Expand_Row_list)

Of = open("Expand_multi10.txt", "w+")
for i in range(len(Expand_Row_list)):
    for j in range(len(Expand_Row_list[i])):
        Of.write("%s" %Expand_Row_list[i][j])
        if(j!=len(Expand_Row_list[i])-1):
            Of.write(" ")
        if(j==len(Expand_Row_list[i])-1):
            Of.write("\n")

Of.close()

