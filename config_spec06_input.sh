#************************ benchmark parameters ****************
# --options
#ref
args_perlbench[1]="-I./lib checkspam.pl 2500 5 25 11 150 1 1 1 1"
args_perlbench[2]="-I./lib diffmail.pl 4 800 10 17 19 300"
args_perlbench[3]="-I./lib splitmail.pl 1600 12 26 16 4500"
name_perlbench[3]="splitmail.1600.12.26.16.4500"
name_perlbench[2]="diffmail.4.800.10.17.19.300"
name_perlbench[1]="checkspam.2500.5.25.11.150.1.1.1.1"
name_perlbench[0]="attrs"
num_perlbench=4

args_bzip2[0]="input.program 5"
args_bzip2[1]="input.source 280"
args_bzip2[2]="chicken.jpg 30"
args_bzip2[3]="liberty.jpg 30"
args_bzip2[4]="input.program 280"
args_bzip2[5]="text.html 280"
args_bzip2[6]="input.combined 200"
name_bzip2[2]="chicken.jpg"
name_bzip2[5]="text.html"
name_bzip2[4]="input.program"
name_bzip2[1]="input.source"
name_bzip2[3]="liberty.jpg"
name_bzip2[6]="input.combined"
name_bzip2[0]="input.program"
num_bzip2=7

args_gcc[0]="cccp.i -o cccp.s"
args_gcc[1]="166.i -o 166.s"
args_gcc[2]="200.i -o 200.s"
args_gcc[3]="c-typeck.i -o c-typeck.s"
args_gcc[4]="cp-decl.i -o cp-decl.s"
args_gcc[5]="expr.i -o expr.s"
args_gcc[6]="expr2.i -o expr2.s"
args_gcc[7]="g23.i -o g23.s"
args_gcc[8]="s04.i -o s04.s"
args_gcc[9]="scilab.i -o scilab.s"
name_gcc[4]="cp-decl"
name_gcc[6]="expr2"
name_gcc[1]="166"
name_gcc[3]="c-typeck"
name_gcc[9]="scilab"
name_gcc[5]="expr"
name_gcc[7]="g23"
name_gcc[2]="200"
name_gcc[8]="s04"
name_gcc[0]="cccp"
num_gcc=10

args_mcf[0]="inp.in"
args_mcf[1]="inp.in"
name_mcf[0]="inp"
name_mcf[1]="inp"
num_mcf=2


args_gobmk[0]="--quiet --mode gtp"
args_gobmk[1]="--quiet --mode gtp"
args_gobmk[2]="--quiet --mode gtp"
args_gobmk[3]="--quiet --mode gtp"
args_gobmk[4]="--quiet --mode gtp"
args_gobmk[5]="--quiet --mode gtp"
name_gobmk[5]="trevord"
name_gobmk[4]="trevorc"
name_gobmk[1]="13x13"
name_gobmk[3]="score2"
name_gobmk[2]="nngs"
name_gobmk[0]="dniwog"
num_gobmk=6




args_hmmer[0]="--fixed 0 --mean 325 --num 45000 --sd 200 --seed 0 bombesin.hmm"
args_hmmer[1]="nph3.hmm swiss41"
args_hmmer[2]="--fixed 0 --mean 500 --num 500000 --sd 350 --seed 0 retro.hmm"
name_hmmer[1]="nph3"
name_hmmer[2]="retro"
name_hmmer[0]="bombesin"
num_hmmer=3

args_sjeng[0]="test.txt"
args_sjeng[1]="ref.txt"
name_sjeng[1]="ref"
name_sjeng[0]="test"
num_sjeng=2


args_libquantum[0]="33 5"
args_libquantum[1]="1397 8"
name_libquantum[1]="ref"
name_libquantum[0]="test"
num_libquantum=2

args_h264ref[0]="-d foreman_test_encoder_baseline.cfg"
args_h264ref[1]="-d foreman_ref_encoder_baseline.cfg"
args_h264ref[2]="-d foreman_ref_encoder_main.cfg"
args_h264ref[3]="-d sss_encoder_main.cfg"
name_h264ref[1]="foreman_ref_baseline_encodelog"
name_h264ref[3]="sss_main_encodelog"
name_h264ref[2]="foreman_ref_main_encodelog"
name_h264ref[0]="foreman_test_baseline_encodelog"
num_h264ref=4


args_omnetpp[0]="omnetpp.ini"
args_omnetpp[1]="omnetpp.ini"
name_omnetpp[0]="omnetpp"
name_omnetpp[1]="omnetpp"
num_omnetpp=2

args_astar[0]="lake.cfg"
args_astar[1]="rivers.cfg"
args_astar[2]="BigLakes2048.cfg"
name_astar[1]="rivers"
name_astar[2]="BigLakes2048"
name_astar[0]="lake"
num_astar=3



args_xalancbmk[0]="-v test.xml xalanc.xsl"
args_xalancbmk[1]="-v t5.xml xalanc.xsl"
name_xalancbmk[1]="ref"
name_xalancbmk[0]="test"
num_xalancbmk=2


#************************ benchmark input ****************
input_perlbench=""
input_bzip2=""
input_gcc=""

input_mcf=""

input_gobmk[0]="dniwog.tst"
input_gobmk[1]="13x13.tst"
input_gobmk[2]="nngs.tst"
input_gobmk[3]="score2.tst"
input_gobmk[4]="trevorc.tst"
input_gobmk[5]="trevord.tst"

input_hmmer=""
input_sjeng=""

input_libquantum=""
input_h264ref=""


input_omnetpp=""
input_astar=""


input_xalancbmk=""

#****************************** choose benchmark ******************************
if [ $target == "400.perlbench" ]; 	then
	cmd=$cmd_perlbench
	if [ $2 -lt $num_perlbench ]; then
		args=${args_perlbench[$2]}
		input=$input_perlbench
		output=${name_perlbench[$2]}".out"
		errout=${name_perlbench[$2]}".err"
	else
		echo "$2 is too big"
		exit
	fi
	
elif  [ $target == "401.bzip2" ]; 	then
	cmd=$cmd_bzip2
	if [ $2 -lt $num_bzip2 ]; then
		args=${args_bzip2[$2]}
		input=$input_bzip2
		output=${name_bzip2[$2]}".out"
		errout=${name_bzip2[$2]}".err"
	else
		echo "$2 is too big"
		exit
	fi
	
elif  [ $target == "403.gcc" ]; 		then
	cmd=$cmd_gcc
	if [ $2 -lt $num_gcc ]; then
		args=${args_gcc[$2]}
		input=$input_gcc
		output=${name_gcc[$2]}".out"
		errout=${name_gcc[$2]}".err"
	else
		echo "$2 is too big"
		exit
	fi
	
elif  [ $target == "429.mcf" ]; 		then
	cmd=$cmd_mcf
	if [ $2 -lt $num_mcf ]; then
		args=${args_mcf[$2]}
		input=$input_mcf
		output=${name_mcf[$2]}".out"
		errout=${name_mcf[$2]}".err"
	else
		echo "$2 is too big"
		exit
	fi
	
elif  [ $target == "445.gobmk" ]; 	then
	cmd=$cmd_gobmk
	if [ $2 -lt $num_gobmk ]; then
		args=${args_gobmk[$2]}
		input=${input_gobmk[$2]}
		output=${name_gobmk[$2]}".out"
		errout=${name_gobmk[$2]}".err"
	else
		echo "$2 is too big"
		exit
	fi
	
elif  [ $target == "456.hmmer" ]; 	then
	cmd=$cmd_hmmer
	if [ $2 -lt $num_hmmer ]; then
		args=${args_hmmer[$2]}
		input=$input_hmmer
		output=${name_hmmer[$2]}".out"
		errout=${name_hmmer[$2]}".err"
	else
		echo "$2 is too big"
		exit
	fi
	
elif  [ $target == "458.sjeng" ]; 	then
	cmd=$cmd_sjeng
	if [ $2 -lt $num_sjeng ]; then
		args=${args_sjeng[$2]}
		input=$input_sjeng
		output=${name_sjeng[$2]}".out"
		errout=${name_sjeng[$2]}".err"
	else
		echo "$2 is too big"
		exit
	fi
	
elif  [ $target == "462.libquantum" ]; then
	cmd=$cmd_libquantum
	if [ $2 -lt $num_libquantum ]; then
		args=${args_libquantum[$2]}
		input=$input_libquantum
		output=${name_libquantum[$2]}".out"
		errout=${name_libquantum[$2]}".err"
	else
		echo "$2 is too big"
		exit
	fi
	
elif  [ $target == "464.h264ref" ]; 	then
	cmd=$cmd_h264ref
	if [ $2 -lt $num_h264ref ]; then
		args=${args_h264ref[$2]}
		input=$input_h264ref
		output=${name_h264ref[$2]}".out"
		errout=${name_h264ref[$2]}".err"
	else
		echo "$2 is too big"
		exit
	fi
	
elif  [ $target == "471.omnetpp" ]; 	then
	cmd=$cmd_omnetpp
	if [ $2 -lt $num_omnetpp ]; then
		args=${args_omnetpp[$2]}
		input=$input_omnetpp
		output=${name_omnetpp[$2]}".log"
		errout=${name_omnetpp[$2]}".err"
	else
		echo "$2 is too big"
		exit
	fi
	
elif  [ $target == "473.astar" ];	then
	cmd=$cmd_astar
	if [ $2 -lt $num_astar ]; then
		args=${args_astar[$2]}
		input=$input_astar
		output=${name_astar[$2]}".out"
		errout=${name_astar[$2]}".err"
	else
		echo "$2 is too big"
		exit
	fi
	
elif  [ $target == "483.xalancbmk" ]; then
	cmd=$cmd_xalancbmk
	if [ $2 -lt $num_xalancbmk ]; then
		args=${args_xalancbmk[$2]}
		input=$input_xalancbmk
		output=${name_xalancbmk[$2]}".out"
		errout=${name_xalancbmk[$2]}".err"
	else
		echo "$2 is too big"
		exit
	fi
	
else
	echo "input wrong!"
	exit
fi