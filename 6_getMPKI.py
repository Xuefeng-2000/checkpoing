import os
import sys


benchmark=sys.argv[1]
test=sys.argv[2]


#=============================

if(benchmark == "gap"):
	scalar = "20"

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



print("===========================")
print("benchmark : " + benchmark)
print("test      : " + test)
print("===========================")

test_name ="---"

print(test)
if (benchmark == "spec06"):
    PROF_PATH="/data/zxf/checkpoint/spec2006/"+test+"/prof"
    CKPT_PATH="/data/zxf/checkpoint/spec2006/"+test+"/ckpt"
    test_name=test[4:]
elif (benchmark == "gap" ):
    PROF_PATH="/data/zxf/checkpoint/gap/"+test+"/prof_"+scalar
    CKPT_PATH="/data/zxf/checkpoint/gap/"+test+"/ckpt_"+scalar
    test_name=test
elif (benchmark == "spec17"):
    PROF_PATH=""
else:
    print("Input as : xx.py benchmark case")
    exit()
#==============================================



files=os.listdir(PROF_PATH)
allckpt=os.listdir(CKPT_PATH)
allckpt.sort()


weights=[-9999]

for ckpt in allckpt:
    ckpt_list=ckpt.split("_")
    if(len(ckpt_list) > 3):
        weights.append(float(ckpt_list[5]))

print(weights)

def printMPKI(PROF_PATH,test_ckp_id,weights):
    id_list=test_ckp_id.split("_")
    if test == "pr_spmv" or test == "cc_sv":
        id=int(id_list[3])
    else:
        id=int(id_list[2])
    weight = weights[id]
    MPKI_sum=0.0
    #print(test_ckp_id+"  ->  "+weight)
    BPpath=PROF_PATH+"/"+test_ckp_id+"/"+"BPMiss_log.txt"
    with open(BPpath) as BPfile:
        context=BPfile.readlines()
       #print(context[-3])
        MPKI=float(context[-3].split(": ")[-1].strip())
        MKPI_tmp = MPKI*weight
        MPKI_sum=MPKI_sum+MKPI_tmp
        print(test_ckp_id +"  |\tMPKI:"+str(round(MPKI,4))+"\t*  weight:"+str(round(weight,4)) + "   =\t"+str(round(MKPI_tmp,5)))
    return MPKI_sum


rmlist = []
for file in files:
    if test == "pr_spmv":
        test_name="pr"
    if test == "cc_sv":
        test_name="cc"
    tmp=file.split("_") 
    if(tmp[0]  !=  test_name):
        rmlist.append(tmp[0])

for i in rmlist:
    files.remove(i)


files.sort(key=lambda k:int(k.split("_")[-1]))


MPKI_sum=0.0
for file in files:  # test_ckp_id
    tmp=file.split("_")
    if(tmp[0] == test_name):
        dirToProf=os.listdir(PROF_PATH+"/"+file)
        MPKI_sum += printMPKI(PROF_PATH,file,weights)

print("TotMPKI: "+str(round(MPKI_sum,5)))
