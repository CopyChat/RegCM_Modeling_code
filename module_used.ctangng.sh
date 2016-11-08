module load intel/15.0.3.187
module load intelmpi/5.0.1.035
module load hdf5/1.8.14


#module load netcdf/4.2.1.1
module load netcdf/4.3.3-rc2_fortran-4.4.1
# Module netcdf compiled with intel/15.0.3.187 and intelmpi/5.0.1.035, and built on hdf5/1.8.14
./configure FC=ifort CC=icc --enable-clm4.5


changes made in PreProc/CLM45/mksurfdata.F90
LINE: 157
tags: ! changes ctang 2016-02-17
changes: add two , declearation of logical 
  logical :: enable_urban_landunit, enable_more_crop_pft
which is firstly defined here: ./Share/mod_dynparam.F90

changes made in Main/clmlib/clm4.5/mod_clm_urbaninput.F90
LINE: 76
tags: ! changes ctang 2016-02-17
changes: add two , declearation of logical 
  logical :: enable_urban_landunit, enable_more_crop_pft
which is firstly defined here: ./Share/mod_dynparam.F90

changes made in  Main/clmlib/clm4.5/mod_clm_control.F90
LINE: 118
tags: ! changes ctang 2016-02-17
changes: add three , declearation of logical 
    logical :: enable_urban_landunit, enable_more_crop_pft,enable_megan_emission
which is firstly defined here: ./Share/mod_dynparam.F90

