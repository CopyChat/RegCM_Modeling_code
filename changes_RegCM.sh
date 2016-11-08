#===============================================================
#
#          FILE: changes.sh
# 
#   DESCRIPTION:  in this file, I write the changes I have made
#   			  in the source 
# 				  code of RegCM-4.3.5.6.
# 
#         NOTES: --- I have put all of the changed pieces of code
# 				 in the directory of 
#    			 RegCM-4.3.5.6 and a copy of which in ~/backup
#
#        AUTHOR: Tang (Tang), tangchao90908@sina.com
#  ORGANIZATION: KLA
#       CREATED: 02/05/2014 10:53:19 RET
#      REVISION:  ---
#=================================================================


to make the code compatible with the dimensions of input data for 
 different resolution and domains.
#=========================================================

/labos/le2p/ctang/RegCM/RegCM-4.3.5.6/PreProc/ICBC/mod_ein.F90

LINE : 309
#-------------------------------
select case (ires)
      case (15)
        jlat = 28
        ilon = 68
        xres = 1.50
        !jlat = 121
        !ilon = 240
        !xres = 1.50
      case (25)
        jlat = 73
        ilon = 144
        xres = 2.50
      case (75)
        jlat = 55
        ilon = 135
        xres = 0.750
        !jlat = 241
        !ilon = 480
        !xres = 0.750
#-------------------------------

	
TO OUTPUT the LW & SW SSR (diffuse & direct component)
#============================================================

First, 


/labos/le2p/ctang/RegCM/RegCM-4.3.5.6/Main/mpplib/mod_outvars.f90

LINE: 115 add these below:

real(rk8) , dimension(:,:) , pointer :: rad_soll_out => null()
real(rk8) , dimension(:,:) , pointer :: rad_solld_out => null()
real(rk8) , dimension(:,:) , pointer :: rad_sols_out => null()
real(rk8) , dimension(:,:) , pointer :: rad_solsd_out => null()


Second,

/labos/le2p/ctang/RegCM/RegCM-4.3.5.6/Main/mpplib/mod_ncout.F90
LINE: ~ 254 add these lines below:

integer(ik4) , parameter :: rad_soll  = 18
integer(ik4) , parameter :: rad_solld  = 19
integer(ik4) , parameter :: rad_sols  = 20
integer(ik4) , parameter :: rad_solsd  = 21

LINE: ~ 74 change the number 12 to 16 ( 4 variables to be added )

integer(ik4) , parameter :: nrad2dvars = 16 + nbase


LINE: ~ 1090, add these line just between the code 
"rad_firtp_out => v2dvar_rad(rad_firtp)%rval"
and the code
"end if":


call setup_var(v2dvar_rad(rad_soll),vsize,'dlwssr','W m-2', &
'Downward longwave surface solar radiation direct', &
'Downward_longwave_surface_solar_radiation_direct',.true.)
rad_soll_out => v2dvar_rad(rad_soll)%rval
call setup_var(v2dvar_rad(rad_solld),vsize,'dlwssrd','W m-2', &
'Downward longwave surface solar radiation diffuse', &
'Downward_longwave_surface_solar_radiation_diffuse',.true.)
rad_solld_out => v2dvar_rad(rad_solld)%rval
call setup_var(v2dvar_rad(rad_sols),vsize,'dswssr','W m-2', &
'Downward shortwave surface solar radiation direct', &
'Downward_shortwave_surface_solar_radiation_direct',.true.)
rad_sols_out => v2dvar_rad(rad_sols)%rval
call setup_var(v2dvar_rad(rad_solsd),vsize,'dswssrd','W m-2', &
'Downward shortwave surface solar radiation diffuse', &
'Downward_shortwave_surface_solar_radiation_diffuse',.true.)
rad_solsd_out => v2dvar_rad(rad_solsd)%rval



Third,

/labos/le2p/ctang/RegCM/RegCM-4.3.5.6/Main/radlib/mod_rad_outrad.F90
LINE: ~176
add thess below the line "call copy2d(firtp,rad_firtp_out)":

call copy2d(soll,rad_soll_out)
call copy2d(solld,rad_solld_out)
call copy2d(sols,rad_sols_out)
call copy2d(solsd,rad_solsd_out)

and then, recompile the code like this:


cd ../../

source /opt/intel/Compiler/13.4/183/bin/compilervars.sh intel64

for version 4.4-rc25(28):
	change LINE 19637:
	FCFLAGS="-m64 -O3 -axSSSE3 -static-intel -convert big_endian -assume byterecl" 

./configure CC=icc FC=ifort MPIFC=/opt/mpi/mpibull2-1.3.9-18.s/bin/mpif90 CPPFLAGS=-I/worktmp/users/ctang/netcdfregcmnewversion/local/include LDFLAGS=-L/worktmp/users/ctang/netcdfregcmnewversion/local/lib LIBS=-L/worktmp/users/ctang/netcdfregcmnewversion/local/lib -lnetcdff -lnetcdf F77=ifort --with-netcdf=/worktmp/users/ctang/netcdfregcmnewversion/local --with-hdf5=/worktmp/users/ctang/netcdfregcmnewversion/local --prefix=/labos/le2p/ctang/RegCM/RegCM-4.4-rc28/

for version 4.4-rc30:
	change LINE 16482:
	FCFLAGS="-m64 -O3 -axSSSE3 -static-intel -convert big_endian -assume byterecl" 

FCFLAGS="-m64 -O3 -axSSSE3 -static-intel -convert big_endian -assume byterecl" ./configure CC=icc FC=ifort --with-netcdf=/worktmp/users/ctang/netcdfregcmnewversion/local --with-hdf5=/worktmp/users/ctang/netcdfregcmnewversion/local

make 
make install

#===============================================================================
NOTE:use "ldd ~/RegCM/RegCM-4.4-rc28/bin/regcmMPI_clm45 | more"
to check the libs used to compile the exe file




NOTE: all these changed files are packed in ~/RegCM/changes_RegCM.tar and ~/backup/changes_RegCM.tar as a copy. And I persionally think it would be OK that just copy the changed files to the place where they should be in the RegCM-4.3.5.6 and overwrite the source codes. While, I DID NOT test it.
