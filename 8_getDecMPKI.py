import os
import sys
from unittest import result


benchmark=sys.argv[1]
test=sys.argv[2]


#=============================

if(benchmark == "gap"):
	scalar = "19"

if(benchmark == "spec06"):
	if ( test == "400" or test == "perlbench" or test == "400.perlbench" ):
		test="400.perlbench"
	elif ( test == "401" or test == "bzip2" or test == "401.bzip2" ):  
		test="401.bzip2"
	elif ( test == "403" or test == "gcc" or test == "403.gcc" ):  
		test="403.gcc"
	elif ( test == "429" or test == "mcf" or test == "429.mcf" ):  
		test="429.mcf"
	elif ( test == "445" or test == "gobmk" or test == "445.gobmk" ):  
		test="445.gobmk"
	elif ( test == "456" or test == "hmmer" or test == "456.hmmer" ):  
		test="456.hmmer"
	elif ( test == "458" or test == "sjeng" or test == "458.sjeng" ):  
		test="458.sjeng"
	elif ( test == "462" or test == "libquantum" or test == "462.libquantum" ):  
		test="462.libquantum"
	elif ( test == "464" or test == "h264ref" or test == "464.h264ref" ):  
		test="464.h264ref"
	elif ( test == "471" or test == "omnetpp" or test == "471.omnetpp" ):  
		test="471.omnetpp"
	elif ( test == "473" or test == "astar" or test == "473.astar" ):  
		test="473.astar"
	elif ( test == "483" or test == "xalancbmk" or test == "483.xalancbmk" ):  
		test="483.xalancbmk"
	else:
		print("Input error!!")
		exit()

if(benchmark == "spec17"):
	if ( test == "505" or test == "mcf_r"  ):
		test="505.mcf_r"
	elif ( test == "541" or test == "leela_r"  ):  
		test="541.leela_r"
	elif ( test == "557" or test == "xz_r"  ):  
		test="557.xz_r"

	else:
		print("Input error!!")
		exit()


print("===========================")
print("benchmark : " + benchmark)
print("test      : " + test)
print("===========================")

test_name ="---"
logDir = "all_4_6"

print(test)
if (benchmark == "spec06"):
    PROF_PATH="/data/zxf/checkpoint/spec2006/"+test+"/prof"
    CKPT_PATH="/data/zxf/checkpoint/spec2006/"+test+"/ckpt"
    LOAD_PATH="/data/zxf/checkpoint/log/"+logDir+"/spec06/"+test[4:]
    test_name=test[4:]
elif (benchmark == "gap" ):
    PROF_PATH="/data/zxf/checkpoint/gap/"+test+"/prof_"+scalar
    CKPT_PATH="/data/zxf/checkpoint/gap/"+test+"/ckpt_"+scalar
    LOAD_PATH="/data/zxf/checkpoint/log/"+logDir+"/gap/"+test
    test_name=test
elif (benchmark == "spec17"):
    PROF_PATH=""
    CKPT_PATH="/data/zxf/checkpoint/spec2017/"+test+"/ckpt"
    LOAD_PATH="/data/zxf/checkpoint/log/"+logDir+"/spec17/"+sys.argv[2]
else:
    print("Input as : xx.py benchmark case")
    exit()
#==============================================



files=os.listdir(LOAD_PATH)
allckpt=os.listdir(CKPT_PATH)
allckpt.sort()


weights=[-9999]

for ckpt in allckpt:
    ckpt_list=ckpt.split("_")
    if(len(ckpt_list) > 3):
        weights.append(float(ckpt_list[5]))

print(weights)

def rd(num,k):
    return round(num,k)

numParam = 19+4

def printMPKI(PROF_PATH,test_ckp_id,weights):
    id_list=test_ckp_id.split("_")
    id = int(id_list[-1])
    weight = weights[id]
    MPKI_sum=0.0

    retArr=[]

    ProfPath=LOAD_PATH+"/ckpt_"+str(id)+"/MissInfo.txt"


    if (test_name == "omnetpp") and id == 9:
        return  [0 for i in range(numParam)]

    with open(ProfPath) as profile:
        context = profile.readlines()
        weight_t = weight

        if(context[-1][0] != 'D'):
            return [0 for i in range(numParam)]
        
        
        Proidx=-1
        while(1):
            if(context[Proidx-1][0]=='*'):
                break
            else:
                Proidx = Proidx - 1

        

        while(Proidx!=-1):
            if(context[Proidx][0] == '='):
                Proidx = Proidx + 1
                continue
            tmpList = context[Proidx].split(":")
            retArr.append( float(tmpList[-1].strip()) )
            Proidx = Proidx + 1

        MPKI = rd( float(retArr[0]) , 3)
        MKPI_tmp = MPKI*weight_t
        MPKI_sum=MPKI_sum+MKPI_tmp
        print(test_ckp_id +"  |\tMPKI:"+str(MPKI)+"\t*  weight:"+str(rd(weight,4)) + "   =\t"+str(round(MKPI_tmp,3)))
      
    #print(retArr)
    return [x*weight for x in retArr]

files.sort(key=lambda k:int(k.split("_")[-1]))

'''
MPKI_sum=0.0
ld1_sum = 0
ld2_sum = 0

ld1_rd=0
ld1_nrd=0

ld2_rd=0
ld2_nrd=0
ld2_hfrd=0

ld1_strM=0
ld2_strHalfM =0 
ld2_strM = 0
ld2_strHalfOnMissSide = 0


'''


def checkKeySeg(file):
    if(benchmark == "gap"):
        if test == "bfs":
            if file < 15:
                return False
        if test == "cc":
            if file < 12:
                return False
        if test == "pr":
            if file < 4:
                return False
        if test == "bc":
            if file < 8:
                return False
        if test == "tc":
            if not (file == 3 or file == 4 or file == 7 or file == 11) :
                return False
        if test == "sssp":
            if file < 4 :
                return False

    return True




#------------sum--------------

Result = [0 for i in range(numParam)]
for file in files:  # test_ckp_id
    #print(file)
    sp = file.split("_")
    if checkKeySeg(int(sp[-1])) == False :
        continue
    res = printMPKI(PROF_PATH,file,weights)
    
    for i in range(0,numParam):
        Result[i] += res[i]
    #print(Result)
        #MPKI_sum = printMPKI(PROF_PATH,file,weights)



#------------profile------------

TotMPKI=round(Result[0],5)

persentArr = [rd(100.0*rd(x,5)/TotMPKI,2) for x in Result]
MPKIArr = [rd(x,2) for x in Result]
NameArr = [ \
"Total_MPKI" ,\
"load1_MPKI",\
"load2_MPKI",\
"Ld1__Ready",\
"Ld1_nReady",\
"Ld1_nMatch",\
"space",\
"Ld2__Ready",\
"Ld2_hReady",\
"Ld2_nReady",\
"Ld2_nMatch",\
"space",\
"All_nReady",\
"All_hReady",\
"All__Ready",\
"space",\
"Ld1__StdMs",\
"Ld2_hStdMs",\
"Ld2__StdMs",\
"Ld2_nRdSdM",\
"Ld2_allSdM",\
"Ld2_OlySdM",\
"space",\
"BrcFinshed",\
"Ld2_PrSdAl",\
"Ld2_PrhfSd",\
"Ld2_PrNoRd"
]


idx_onNum = 0
print("*******  Persent **********")
for i,name in enumerate( NameArr ):
    if name =="space":
        print()
        continue
    else:
        #print(name + " : " +str(persentArr[i]) + "%")
        print(str(persentArr[idx_onNum]) + "%")
        idx_onNum = idx_onNum +1

idx_onNum = 0
print("***********************")
for i,name in enumerate( NameArr ):
    if name =="space":
        print()
        continue
    else:
        print(name + " : " +str(MPKIArr[idx_onNum]))
        idx_onNum = idx_onNum +1



















'''
load1=100.0*round(Result[1],5)/TotMPKI
load2=100.0*round(Result[2],5)/TotMPKI
other=100.0 - load1 - load2

load1_rd=100.0*round(Result[3],5)/TotMPKI
load1_nrd=100.0*round(Result[4],5)/TotMPKI

load2_rd=100.0*round(Result[5],5)/TotMPKI
load2_nrd=100.0*round(Result[6],5)/TotMPKI
load2_hfrd=100.0*round(Result[7],5)/TotMPKI 

ld1_strM=100.0*round(Result[8],5)/TotMPKI
ld2_strHalfM=100.0*round(Result[9],5)/TotMPKI
ld2_strM = 100.0*round(Result[10],5)/TotMPKI 
ld2_strHalfOnMissSide = 100.0*round(Result[11],5)/TotMPKI 

print("load1: "+str(round(Result[1],5)))
print("load2: "+str(round(Result[2],5)))

print("load1_rd: "+str(round(Result[3],5)))
print("load1_nrd: "+str(round(Result[4],5)))

print("load2_rd: "+str(round(Result[5],5)))
print("load2_nrd: "+str(round(Result[6],5)))
print("load2_hfrd: "+str(round(Result[7],5)))

print("load1_strM: "+str(round(Result[8],5)))
print("load2_strHM: "+str(round(Result[9],5)))
print("load2_strM: "+str(round(Result[10],5)))
print("load2_strOMS: "+str(round(Result[11],5)))

print(" ========  partion =======")

print("load1R: "+str(round(load1,2))+"%")
print("load2R: "+str(round(load2,2))+"%")

print("ld1_rd: "+str(round(load1_rd,2))+"%")
print("ld1_nR: "+str(round(load1_nrd,2))+"%")

print("ld2_rd: "+str(round(load2_rd,2))+"%")
print("ld2_HR: "+str(round(load2_hfrd,2))+"%")
print("ld2_nR: "+str(round(load2_nrd,2))+"%")

print("ld1_st: "+str(round(ld1_strM,2))+"%")
print("ld2_st: "+str(round(ld2_strHalfM,2))+"%")
print("ld2_st: "+str(round(ld2_strM,2))+"%")
print("ld2_st: "+str(round(ld2_strHalfOnMissSide,2))+"%")



print(str(round(load1,2)) )
print(str(round(load2,2)) )
print()


print(str(round(other,2)))
print(str(round(load2_rd,2)) )
print(str(round(load2_hfrd,2)) )
print(str(round(load2_nrd,2)) )

print(str(round(load1_rd,2)) )
print(str(round(load1_nrd,2)) )


#print("TotMPKI: "+str(round(MPKI_sum,5)))


print("&&&&&&&&&&&")
print(str(round(load1,2))+"%")
print(str(round(load2,2))+"%")

print(str(round(load1_rd,2))+"%")
print(str(round(load1_nrd,2))+"%")

print(str(round(load2_rd,2))+"%")
print(str(round(load2_hfrd,2))+"%")
print(str(round(load2_nrd,2))+"%")

print(str(round(ld1_strM,2))+"%")
print(str(round(ld2_strHalfM,2))+"%")
print(str(round(ld2_strM,2))+"%")
print(str(round(ld2_strHalfOnMissSide,2))+"%")
'''