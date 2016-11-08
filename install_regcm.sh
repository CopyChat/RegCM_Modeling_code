#!/bin/bash - 
#===============================================================================
#
#          FILE: install_regcm.sh
# 
USAGE=" ./install_regcm.sh  "
# 
#   DESCRIPTION:  
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: Tang (Tang), chao.tang.1@gmail.com
#  ORGANIZATION: le2p
#       CREATED: 02/18/16 08:53:01 CET
#      REVISION:  ---
#===============================================================================

#set -o nounset                             # Treat unset variables as an error
shopt -s extglob 							# "shopt -u extglob" to turn it off

#=================================================== /

echo " please make distclean, if you had tried to compile before."
module purge
module load intel/15.0.3.187
#module load intelmpi/5.0.1.035
# intelmpi/5.0.1.035 confilect with bullxmpi/1.2.8.4-mxm ( prereq by cdo)
module load bullxmpi/1.2.8.4-mxm
module load hdf5/1.8.14
#module load netcdf/4.2.1.1
module load netcdf/4.3.3-rc2_fortran-4.4.1
# Module netcdf compiled with intel/15.0.3.187 
# and intelmpi/5.0.1.035, and built on hdf5/1.8.14

#=================================================== to configure RegCM-4.4.5
echo "./configure FC=ifort CC=icc --enable-clm45"
#=================================================== alias
