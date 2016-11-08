#!/bin/bash - 
#===============================================================================
#
#          FILE: functions.sh
# 
#         USAGE: ./functions.sh 
# 
#   DESCRIPTION: this file contains my bash shell functions 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: Tang (Tang), tangchao90908@sina.com
#  ORGANIZATION: KLA
#       CREATED: 03/07/2014 14:30:26 RET
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error

#---  FUNCTION  ----------------------------------------------------------------
#          NAME:  show
#   DESCRIPTION:  show all the command line arguments
#    PARAMETERS:  
#       RETURNS:  
#-------------------------------------------------------------------------------
function show
{
	echo $#: $0 $@
}


#---  FUNCTION  ----------------------------------------------------------------
#          NAME:  color
#   DESCRIPTION:  echo text with colors
#    PARAMETERS: -n, donot print \n 
#       RETURNS:  
#-------------------------------------------------------------------------------
function color
{
	local USAGE="color [ -n ] [+ foreground] [+ background] [+ statements]"
	local ARG=${1:-""}
#=================================================== 
if ! [ -z $(echo "" | awk '{print "'$ARG'"}' | grep '^-') ]; then
	if [ $ARG = "-n" ]; then num=$(( $# - 1 )); shift 1
	else 
		echo $USAGE ;echo "$(tput setaf 1)$(tput setab 3)ERROR: color$(tput sgr 0)" 
	fi
else num=$#; ARG=""; fi
#=================================================== 
	case $num in
		0) echo $ARG;;
		1) echo $ARG $1 ;;
		2) echo $ARG "$(tput setaf $1)$2$(tput sgr 0)" ;;
		3) echo $ARG "$(tput setaf $1)$(tput setab $2)$3$(tput sgr 0)" ;;
		*) echo $USAGE; echo "$(tput setaf 1)$(tput setab 3)ERROR: color$(tput sgr 0)" ;;
	esac
}

#---  FUNCTION  ----------------------------------------------------------------
#          NAME:  colorpad
#   DESCRIPTION:  to show the color pad
#    PARAMETERS:  
#       RETURNS:  
#-------------------------------------------------------------------------------
function colorpad
{
for clbg in {40..47} {100..107} 49 ; do
	#Foreground
	for clfg in {30..37} {90..97} 39 ; do
		#Formatting
		for attr in 0 1 2 4 5 7 ; do
			#Print the result
			echo -en "\x1B[${attr};${clbg};${clfg}m ^[${attr};${clbg};${clfg}m \x1B[0m"
		done
		echo #Newline
	done
done
}

#---  FUNCTION  ----------------------------------------------------------------
#          NAME:  fonts
#   DESCRIPTION:  output charators with fonts
#    PARAMETERS:  
#       RETURNS:  
#-------------------------------------------------------------------------------
function fonts
{
	bold='tput bold'
	normal='tput sgr0'
	local USAGE="fonts [+ foreground] [+ statements]"
	format=""
	while getopts ":bnl" opt; do
		case $opt in 
			b) 
				format=$format${bold} ;;
			n)
				format=$format${normal} ;;
			\?) 
				echo $USAGE 
		esac
	done
	shift $(($OPTIND - 1))
	echo "$($format) $1"
}

#---  FUNCTION  ----------------------------------------------------------------
#          NAME:  stamp
#   DESCRIPTION:  print my stamp
#    PARAMETERS:  
#       RETURNS:  
#-------------------------------------------------------------------------------
function stamp
{
	echo "      _______________    _____                   __           ____     ___________________"
	echo "     /              /   /     \                 /  \         /   /    /                  /          "
	echo "    /______________/   /   .   \               /    \       /   /    /   -----------    /          "
	echo "        /   /         /   / \   \             /      \     /   /    /   /          /   /     "
	echo "       /   /         /   /   \   \           /   /\   \   /   /    /   /          '---/          "
	echo "      /   /         /   /_____\   \         /   /  \   \ /   /    /   /   ___________         "
	echo "     /   /         /   ,_______,   \       /   /    \   /   /    /   /   /______,   /          "
	echo "    /   /         /   /         \   \     /   /      \     /    /   /__________/   /            "
	echo "   /___/         /___/           \___\   /___/        \___/    /__________________/         "
}
#---  FUNCTION  ----------------------------------------------------------------
#          NAME:  loopt
#   DESCRIPTION:  execute cmds every 5 (default) seconds.
#    PARAMETERS:  
#       RETURNS:  
#-------------------------------------------------------------------------------
function loopt
{
	local TIME=5; local max=10000
	local USAGE="loopt [ -b ] [ -time step ] [+ max times ] + commands"

    BACKGROUND=0;TEST=0
#--------------------------------------------------- 
    #while getopts ":tb" opt; do
        #case $opt in
            #t) 
                #TEST=1 ;;
            #b) 
                #BACKGROUND=1 ;;
            #\?) echo $USAGE && exit 1
        #esac
    #done

#shift $(($OPTIND - 1))

#echo $TEST $BACKGROUND
#--------------------------------------------------- 
#if [ "$TEST" = "1" ]; then 
    #color 1 6 $USAGE 
#fi

	case $# in
		1) cmd=$1 ;;
		2) TIME=$1; cmd=$2 ;;
		3) TIME=$1; max=$2; cmd=$3 ;;
		*) color 1 3 "$(echo $USAGE)"; 
	esac
#--------------------------------------------------- 
	i=0
	while [ $i -lt $max ];
	do
            #echo cmd=$cmd
            #eval $cmd
            open http://www.allemagne.diplo.de/Vertretung/frankreich/fr/08-konsularisches/visa-VE/00-visa-uebseite.html
        countdown $(eval s2t $TIME)
        #sleep $TIME
		((i++))
	done
}

######################################################################
# process indicator#
function procIndc
{
    i=0
    color -n 1 7 " the process is running: "
    while [ $i -lt 100 ]
    do
        for j in '-' '\\' '|' '/'
        do
            echo -ne "\033[1D$j"
            sleep .1
        done
        ((i++))
    done
}

######################################################################
#####   translate second to time fo format : hh:mm:ss
function s2t
{
    s=$1
    prs=`expr $s % 60`
    m=`expr \( $s - $prs \) / 60`
    prm=`expr $m % 60`
    h=`expr \( $m - $prm \) / 60`

#------------------------------------------------ change the format 00:00:00 
    [ ${h} -lt 10 ] && h="0${h}"
    [ ${prm} -lt 10 ] && prm="0${prm}"
    [ ${prs} -lt 10 ] && prs="0${prs}"
#--------------------------------------------------- 
    echo ${h}":"${prm}":"${prs}
    #echo ${h}h:${prm}m:${prs}s
}


######################################################################
#####   translate time of format : hh:mm:ss to second
function t2s
{
    h=`echo $1 |egrep -o '[0-9]+h' |egrep -o '[0-9]+'`
    m=`echo $1 |egrep -o '[0-9]+m' |egrep -o '[0-9]+'`
    s=`echo $1 |egrep -o '[0-9]+s' |egrep -o '[0-9]+'`

    if [ ! -z $h ] 
    then
        h=`expr $h \* 3600`
    else
        h=0
    fi

    if [ ! -z $m ] 
    then
        m=`expr $m \* 60`
    else
        m=0
    fi

    if [ -z $s ] 
    then
        s=0
    fi

    echo `expr $h + $m + $s`
}


######################################################################
#####  count down 
#function s2t
#tput sc
#[☃ 17:35 ~]>>
#[☃ 17:35 ~]>count=0
#[☃ 17:35 ~]>while true;
#do
        #if [ $count -lt 40 ];then
                #let count++;
                #sleep 1;
                #tput rc
                #tput ed
                #echo -n $count;
        #else
                #exit 0;
        #fi
#done

######################################################################
function showdate
{
    while true; do echo -ne "`date`\r"; done
}
######################################################################
function countdown()
{
    IFS=:
    set -- $* 
    secs=$(( ${1#0} * 3600 + ${2#0} * 60 + ${3#0} ))
    while [ $secs -gt 0 ]
    do
        sleep 1 2>&-
        printf "\r%02d:%02d:%02d" $((secs/3600)) $(( (secs/60)%60)) $((secs%60))
        secs=$(( $secs - 1 ))
        wait
    done
    echo
}

######################################################################
##  for cmip5
######################################################################
function cmip5()
{
    while getopts ":t" opt; do
        case $opt in
            t) TEST=1 ;;
        \?) echo $USAGE && exit 1
        esac
    done
    shift $(($OPTIND - 1))

    color 1 7 "cmip5.%(product)s.%(institute)s.%(model)s.%(experiment)s.%(time_frequency)s.%(realm)s.%(cmor_table)s.%(ensemble)s"
}



######################################################################
# delete the file whose size is 0B in current directory
function del0()
{
    dir=$(pwd)
    num=$(find $dir -type f -size 0 | wc -l)
    color -n 1 7 "Number of ZERO byte files:"; color 7 1 " $num:"
    find $dir -type f -size 0 
    echo '--------------------------------'

    color -n 6 7 "delete them ??? (default NO)"
    read y
    if [ "$y" == 'Yes' ]; then
        find $dir -type f -size 0 | xargs rm -rf 
    else
        echo y = no
    fi

}
######################################################################
# get the name of CORDEX
function nameCOR()
{
    dir=$(pwd)
    num=$(find $dir -type f -size 0 | wc -l)
    color -n 1 7 "Number of ZERO byte files:"; color 7 1 " $num:"
    find $dir -type f -size 0 
    echo '--------------------------------'

    color -n 6 7 "delete them ??? (default NO)"
    read y
    if [ "$y" == 'Yes' ]; then
        find $dir -type f -size 0 | xargs rm -rf 
    else
        echo y = no
    fi
}
######################################################################
# get the name of CORDEX
function nameCOR()
{
    dir=$(pwd)
    num=$(find $dir -type f -size 0 | wc -l)
    color -n 1 7 "Number of ZERO byte files:"; color 7 1 " $num:"
    find $dir -type f -size 0 
    echo '--------------------------------'

    color -n 6 7 "delete them ??? (default NO)"
    read y
    if [ "$y" == 'Yes' ]; then
        find $dir -type f -size 0 | xargs rm -rf 
    else
        echo y = no
    fi
}
######################################################################
# del all files except the ones given as arg
function DelE()
{
    dir=$(pwd)
    
    while getopts ":t" opt; do
        case $opt in
            t) TEST=1 ;;
            \?) echo $USAGE && exit 1
        esac
    done

    shift $(($OPTIND - 1))


    case $# in
        1) 
            TEST=1 
            color 7 1 "delete ALL ???" 
            color 1 7 "$(eval ls)"
            read y
            if [ "$y" == 'Yes' ]; then
                find $dir -type f | xargs rm -rf 
                find . -type f ! -name "$1" -delete
            fi;;
        2) 
            TEST=1 
            color 7 1 "delete ALL ???" 
            color 1 7 "$(eval ls)"
            read y
            if [ "$y" == 'Yes' ]; then
                find $dir -type f | xargs rm -rf 
                find . -type f ! -name "$1" -delete
            fi;;
        \?) 
            
            rm `ls | grep -v "^aa$" `
    esac



    num=$(find $dir -type f -size 0 | wc -l)
    color -n 1 7 "Number of ZERO byte files:"; color 7 1 " $num:"
    find $dir -type f -size 0 
    echo '--------------------------------'

    color -n 6 7 "delete them ??? (default NO)"
    read y
    if [ "$y" == 'Yes' ]; then
        find $dir -type f -size 0 | xargs rm -rf 
    else
        echo y = no
    fi
}
################################
# get cmip5 model names in current directory
function getmodelname()
{

for file in $(ls *.nc); do a=${file##*Amon_}; echo ${a%%_hist*}; done | sort |uniq
}
################################
# get cmip5 model timestamp in current directory
function gettime()
{
for file in $(ls *.nc)
do
    color 7 1 $file
    ncdump -h $file | grep 'current'
done
}

################################
# find 0 size file in current directory for file type and given extension $1
function find0f()
{
    USAGE='find0f [extension or match parten]'
    dir=$(pwd)
    
    while getopts ":t" opt; do
        case $opt in
            t) TEST=1 ;;
            \?) echo $USAGE && exit 1
        esac
    done

    shift $(($OPTIND - 1))

    case $# in
        0) 
            find $dir -maxdepth 1 -type f -size 0 | wc -l
            color -n 1 7 "Number of ZERO byte files:"; color 7 1 " $(find $dir -maxdepth 1 -type f -size 0 | wc -l):"
            find $dir -maxdepth 1 -type f -size 0  | xargs ls -s
            color 4  '--------------------------------';;
        1) 
            #echo "find $dir -maxdepth 1 -type f -name \"$1\" -size 0 | wc -l"
            find $dir -maxdepth 1 -type f -name "$1" -size 0 | wc -l
            color -n 1 7 "Number of ZERO byte files:"; color 7 1 " $(find $dir -maxdepth 1 -type f -name "$1" -size 0 | wc -l):"
            find $dir -maxdepth 1 -type f -name "$1" -size 0 
            #find $dir -type f ! -name "$1" -size 0 
            color 4 '--------------------------------';;
        \?) 
            echo $USAGE
    esac

}
################################
# find 0 size file in current directory for file type and given extension $1
function nctimstep()
{

    FILE=1
    while getopts ":tf" opt; do
        case $opt in
            t) TEST=1 ;;
            f) FILE=1 ;;
            \?) echo $USAGE && exit 1
        esac
    done

shift $(($OPTIND - 1))

    if [ "$FILE" -eq "1" ]; then
        for f in $(ls $1*.nc)
        do 
            color -n 7 1 "$(eval ncdump -h $f | grep current)"; color 1 7 "$f "
        done
    fi

}

#=================================================== ENSO
function nino34()
{
    cdo sellonlatbox,170,240,-5,5 $1 ${1%.nc}.nino3.4.nc
}

#=================================================== 
function swio()
{
    cdo sellonlatbox,0,110,0,-40 $1 ${1%.nc}.swio.nc
}
function swio2()
{
    cdo sellonlatbox,3,107,-3,-37 $1 ${1%.nc}.swio.nc
}
#===================================================  do not work
function dockdely()
{
    KILL=0;RECOVER=0;SMALL=0;
#=================================================== 
    while getopts ":tskr" opt; do
        case $opt in
            t) TEST=1 ;;
            k) KILL=1 ;;
            s) SMALL=1 ;;
            r) RECOVER=1 ;;
            \?) echo $USAGE && exit 1
        esac
    done
    shift $(($OPTIND - 1))


    if [ $KILL = "1" ];then
        defaults write com.apple.Dock autohide-delay -float 1000 && killall Dock
    fi

    if [ $RECOVER = "1" ];then
        defaults write com.apple.Dock autohide-delay -float 2 && killall Dock
    fi
    if [ $SMALL = "1" ];then
        defaults write com.apple.dock tilesize -int 1
        killall Dock
    fi
}
#=================================================== 

function syncf()
{

USAGE=" ./sync.sh [ -s] [ + target directory ] [ + local directory ]"
target=${2:-/Users/tang/climate/}
#=================================================== 
s="--progress"
while getopts ":s" opt; do
	case $opt in 
		s) s="" ;;
		\?) echo $USAGE && exit 1
	esac
done
shift $(($OPTIND - 1))

#=================================================== to synchronize file from titan
rsync -arzhSPH $s ctang@titan.univ.run:$1 $target

color 2 4 "code:"; 
color -n 7 1 "rsync -arzhSPH ctang@titan.univ.run: "; color 1 7 "target "
}
#=================================================== 
# to show my code
function smc()
{
    echo '--------------------------------'
    cat ~/.mycode

    echo '--------------------------------'
    echo "cat ~/.mycode"
}
#=================================================== 
#  to backup titan work
function twb()
{
    Modeling=${1:where is modeling directory?}
    echo '--------------------------------'
    cat ~/.mycode

    echo '--------------------------------'
    echo "cat ~/.mycode"
}
