#!/bin/bash - 
#===============================================================================
#
#          FILE: module_to_load.sh
# 
USAGE="./module_to_load.sh  "
# 
#   DESCRIPTION:  
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: Tang (Tang), chao.tang.1@gmail.com
#  ORGANIZATION: le2p
#       CREATED: 02/18/16 06:08:05 CET
#      REVISION:  ---
#===============================================================================

#set -o nounset                             # Treat unset variables as an error
shopt -s extglob 							# "shopt -u extglob" to turn it off
#source ~/Shell/functions.sh      			# TANG's shell functions.sh

#=================================================== 

#export TERM=xterm

#--------------------------------------------------- general coding evn:
module load intel/15.0.3.187
#module load intelmpi/5.0.1.035
# intelmpi/5.0.1.035 confilect with bullxmpi/1.2.8.4-mxm ( prereq by cdo)
module load bullxmpi/1.2.8.4-mxm
module load hdf5/1.8.14
#module load netcdf/4.2.1.1
module load netcdf/4.3.3-rc2_fortran-4.4.1
# Module netcdf compiled with intel/15.0.3.187 
# and intelmpi/5.0.1.035, and built on hdf5/1.8.14

#--------------------------------------------------- load cdo
# -force option is in testing, functione pas bien, donc:
#module load hdf5/1.8.14
module load curl/7.37.1
module load fftw3/3.3.4
module load curl/7.37.1
module load udunits/2.2.17
module load zlib/1.2.8
module load expat/2.1.0
module load cdo

#--------------------------------------------------- programing languages
module load mkl
module load qt
module load python/2.7.8
module load ncview
module load nco
module load ferret


#=================================================== to configure RegCM-4.4.5
##./configure FC=ifort CC=icc --enable-clm4.5
#=================================================== alias
