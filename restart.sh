#!/bin/bash - 
#===============================================================================
#
#          FILE: restart.sh
# 
USAGE='USAGE: (restart.sh [+ opts] + jobs(running) + XXX.restart.pbs [ > ofile 2>&1 ] &)'
# 
#   DESCRIPTION:  to monitor PBS jobs, & restart RegCM model 
# 
#       OPTIONS: --- -t, for test, so time=2
#       		 --- -c, create the RegCM restart regcm.in and PBS file
#  REQUIREMENTS: --- ps, awk, grep, qstat, stat
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: Tang (Tang), tangchao90908@sina.com
#  ORGANIZATION: KLA
#       CREATED: 03/20/2014 12:01:05 PM RET
#      REVISION:  ---
#===============================================================================
TIME=600; CREATE=0; echo ${0##/*/} $@
#=================================================== command line opts
while getopts ":tc" opt; do
	case $opt in 
		t) TIME=2 ;;
		c) CREATE=1 ;;
		\?) echo $USAGE && exit 1
	esac
done
shift $(($OPTIND - 1))
#=================================================== 
if [ $# -lt 2 ];then echo $USAGE; exit 1; fi
#=================================================== check job name
job1=${1:?"please give the PBS job name"}
job1id=$(qstat | grep "$job1" | awk '{print $1}')
if [ -z $job1id ];then
	qstat
	echo "========================================"
	echo "There is NO running job named $job1."
	echo "========================================"
	exit 1
fi
#=================================================== check permision
Dir=${3:-.};cd $Dir 						 # default dir
if [[ $(stat -c "%a" $Dir) -lt 660 ]]; then
	echo "Permission denied. Ask the ower $(eval stat -c "%U" $Dir ) !"
	exit 1
elif ! [ -d input ] || ! [ -d output ] ; then
	echo " You are in $(pwd), is this Regcm working directory ?"
	exit 1
fi
#=================================================== check restart file
pbs2=${2:?"please give the PBS file to restart"}
echo waiting for the job $job1, the job to restart: $pbs2
echo "=========================================================="
if ! [ -f "$pbs2" ]; then
	echo "$pbs2 doesn't exists, or is not a regular file."; exit 1
elif [ "${pbs2##*.}" != "pbs" ]; then
	echo "$pbs2 is not a PBS file."
	exit 1
fi
#=================================================== get pbs1 from job1id
echo $job1id
pbs1=$(qstat -f $job1id | awk '/Submit_arguments/{print $NF}')
echo psb1=$pbs1

#=================================================== get regcm.in from pbs1
nl1var=$(awk '/^mpirun/{print $5}' $pbs1)  # namelist_1_var

if ! [ ${nl1var#$} = $nl1var ] ; then
	echo "it's a var, attempt to find it."
	def=$(grep ^${nl1var##*$} $pbs1)
	nl1=${def##*=}
	echo nl1=${def##*=}
else
	nl1=$nl1var
fi
echo regcm.in1=$nl1
#=================================================== get runlog file1
log1=$(awk '/^mpirun/{print $(NF-1)}' $pbs1)  # namelist_1_var
if ! [ ${log1#*$} = $log1 ] ; then
	echo "it's a var, attempt to find it."
	log1var=${log1#*$}
	echo log1var=$log1var
	def2=$(grep ^${log1var##*$} $pbs1)
	echo def2=$def2
	log1=$(awk '/^mpirun/{gsub(/\$'$log1var'/,"'${def2##*=}'");print $(NF-1)}' $pbs1)
else
	log1=$log1var
fi
echo runlog1=$log1

#=================================================== push to background
slep()
{
	for ((i=0;i<=500;i++))
	do
		sleep 1
		let i++
	done
	exit 0
}
function monitor()
{
#=================================================== monitor the jobs
	until [ $(qstat | grep -c $job1 ) -eq 0 ] 
	do
		echo Job $job1 is still running, waiting...   $(date)
		sleep $TIME
	done
	echo "Job $job1 stoped."
	echo "========================================"
#=================================================== to start the work
echo  start the new job: $name
qsub $pbs2 
name=$(awk '/#PBS -N/{print $NF}' $pbs2)
echo "========================================"
qstat | grep $name 
}


#echo "$(tput setaf 1)Red text $(tput setab 7)and white background$(tput sgr 0)"
echo "$(tput setaf 1)$(tput setab 7)============ ATTENTION ============$(tput sgr 0)"

	echo "All the tests $(tput setaf 2)Succussed!$(tput sgr 0)"
	echo "And, now this restart.sh progress will be $(tput setaf 3)DAEMONIZED!$(tput sgr 0)" 
	echo "When $job1 is terminated and the Exit_status=0 "
	echo "job $job2 will be submit with $pbs2,$(tput setaf 3) $(tput setab 1)Continue? (Yes/n)?$(tput sgr 0)"
	read answer
	if [ $answer = "Yes" ]; then
		if [ $TIME > 10 ]; then
			monitor > $pbs2.out 2>&1 &  
		else
			slep > $pbs2.out 2>&1 &  
		fi
	echo "$(tput setaf 1)$(tput setab 7)====================================$(tput sgr 0)"
	sleep 2
	ps -ef | grep $pbs2 | awk '{if ( $3 == 1 ) printf "Now, Everything is OK.\n"}'
#	echo " ps -ef | grep $pbs2 | awk '{if ( \$3 == 1 ) printf "Now, Everything is OK.\n"}'"
	else exit 1; fi


	exit
#=================================================== print last argument
#for last; do true; done
#echo $last
#echo "${@: -1}"
#echo ${@:${#@}} 
#echo ${@:$#}
#echo ${BASH_ARGV[0]}   		 #If you are using Bash >= 3.0

#=================================================== if the model success
#if [ $(tail $log1 | grep -c "successfully reached end") -lt 1 ];then
#	echo "RegCM simulation $job1 did NOT reach the end!"
#	exit 1
#fi

#=================================================== check process ID
id=$(ps -ef | grep \/restart\.sh | grep "pbs" | awk '{print $2}')
pid=$(ps -ef | grep \/restart\.sh | grep "pbs" | awk '{print $3}')

#echo $id 
#echo $pid
#if [ $pid -ne 1 ]; then
#	kill $id
#	echo $USAGE; 
#	echo "It's better do exactly like above,"
#	echo "to leave the program running in background"
#	echo "and to free your current terminal."
#	echo "This program was killed !!"
#fi
#=================================================== monitor the jobs
until [ $(qstat | grep -c $job1 ) -eq 0 ] do
	echo Job $job1 is still running, waiting...   $(date)
	sleep $TIME
done
echo "Job $job1 stoped."
echo "========================================"

#=================================================== to start the work

echo  start the new job: $name
qsub $pbs2 
name=$(awk '/#PBS -N/{print $NF}' $pbs2)
echo "========================================"
qstat | grep $name 
exit 
