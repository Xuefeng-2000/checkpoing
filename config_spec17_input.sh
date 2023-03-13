#************************ benchmark parameters ****************
# --options
#ref
args_perlbench[1]="-I./lib checkspam.pl 2500 5 25 11 150 1 1 1 1 "
args_perlbench[2]="-I./lib diffmail.pl 4 800 10 17 19 300"
args_perlbench[3]="-I./lib splitmail.pl 1600 12 26 16 4500"
name_perlbench[3]="splitmail.1600.12.26.16.4500"
name_perlbench[2]="diffmail.4.800.10.17.19.300"
name_perlbench[1]="checkspam.2500.5.25.11.150.1.1.1.1"
name_perlbench[0]="attrs"
num_perlbench=4


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

args_leela[0]="test.sgf"
args_leela[1]="ref.sgf"
name_leela[1]="ref"
name_leela[0]="test"
num_leela=2



args_sjeng[0]="test.txt"
args_sjeng[1]="ref.txt"
name_sjeng[1]="ref"
name_sjeng[0]="test"
num_sjeng=2


## xz


args_omnetpp[0]="omnetpp.ini"
args_omnetpp[1]="-c General -r 0"
name_omnetpp[0]="omnetpp"
name_omnetpp[1]="_General_0"
num_omnetpp=2



args_xalancbmk[0]="-v test.xml xalanc.xsl"
args_xalancbmk[1]="-v t5.xml xalanc.xsl"
name_xalancbmk[1]="ref"
name_xalancbmk[0]="test"
num_xalancbmk=2

args_x264[0]="-i BuckBunny.264 -o BuckBunny.yuv"
args_x264[1]="--pass 1 --stats x264_stats.log --bitrate 1000 --frames 1000 -o BuckBunny_New.264 BuckBunny.yuv 1280x720"
name_x264[1]="_BuckBunny.264_BuckBunny.yuv"
name_x264[0]="_BuckBunny.264_BuckBunny.yuv"
num_x264=2


args_xz[1]="cpu2006docs.tar.xz 6643 055ce243071129412e9dd0b3b69a21654033a9b723d874b2015c774fac1553d9713be561ca86f74e4f16f22e664fc17a79f30caa5ad2c04fbc447549c2810fae 10360782721111795472 4"
args_xz[0]="cld.tar.xz 1400 19cf30ae51eddcbefda78dd06014b4b96281456e078ca7c13e1c0c9e6aaea8dff3efb4ad6b0456697718cede6bd5454852652806a657bb56e07d61128434b474 536995164 5399388728"
name_xz[0]="cpu2006docs"
name_xz[1]="cld.tar.xz"
num_xz=2

#************************ benchmark input ****************
input_perlbench=""
input_gcc=""

input_mcf=""

input_gobmk[0]="dniwog.tst"
input_gobmk[1]="13x13.tst"
input_gobmk[2]="nngs.tst"
input_gobmk[3]="score2.tst"
input_gobmk[4]="trevorc.tst"
input_gobmk[5]="trevord.tst"


input_deepsjeng=""

input_libquantum=""
input_h264ref=""


input_omnetpp=""

input_xz=""

input_xalancbmk=""

#****************************** choose benchmark ******************************
if [ $target == "600.perlbench_s" ]; 	then
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
	
elif  [ $target == "602.gcc_s" ]; 		then
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
	
elif  [ $target == "605.mcf_s" ]; 		then
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
	
	
elif  [ $target == "631.deepsjeng_s" ]; 	then
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
	
elif  [ $target == "625.x264_s" ]; 	then
	cmd=$cmd_x264
	if [ $2 -lt $num_x264 ]; then
		args=${args_x264[$2]}
		input=$input_x264
		output=${name_x264[$2]}".out"
		errout=${name_x264[$2]}".err"
	else
		echo "$2 is too big"
		exit
	fi

elif  [ $target == "641.leela_s" ]; 	then
	cmd=$cmd_leela
	if [ $2 -lt $num_leela ]; then
		args=${args_leela[$2]}
		input=$input_leela
		output=${name_leela[$2]}".out"
		errout=${name_leela[$2]}".err"
	else
		echo "$2 is too big"
		exit
	fi
	
elif  [ $target == "620.omnetpp_s" ]; 	then
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
	
elif  [ $target == "623.xalancbmk_s" ]; then
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

elif  [ $target == "657.xz_s" ]; then
	cmd=$cmd_xz
	if [ $2 -lt $num_xz ]; then
		args=${args_xz[$2]}
		input=$input_xz
		output=${name_xz[$2]}".out"
		errout=${name_xz[$2]}".err"
	else
		echo "$2 is too big"
		exit
	fi	
else
	echo "input wrong!"
	exit
fi