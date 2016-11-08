#!/bin/bash - 
#===============================================================================
#
#          FILE: Readme.ctnag.4.MPI-ESM-MR.sh
# 
USAGE="./Readme.ctnag.4.MPI-ESM-MR.sh  "
# 
#   DESCRIPTION:  
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: Tang (Tang), chao.tang.1@gmail.com
#  ORGANIZATION: le2p
#       CREATED: 06/07/2016 12:52:10 PM CEST
#      REVISION:  ---
#===============================================================================

#set -o nounset                             # Treat unset variables as an error
shopt -s extglob 							# "shopt -u extglob" to turn it off
source ~/Shell/functions.sh      			# TANG's shell functions.sh
#=================================================== 

For RegCM-4.4.5.10, seems impossible to use MPI-ESM-LR data with default namelist.in,
So I have changed all the word "MPI-ESM-MR" to "MPI-ESM-LR" in RegCM-4.4.5.10/PreProc/ICBC/mod_gn6hnc.F90.
and /home/ctang/RegCM-4.5.0/PreProc/ICBC/mod_sst_gnhnc.F90
And recompiled the RegCM code ( without clm & clm45 currently)



