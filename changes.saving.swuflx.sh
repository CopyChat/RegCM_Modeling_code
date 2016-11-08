to save input variables of rrtmg_sw in RegCM-4.4.5.10 (Rev. 5242,please check with svn info , account ctang; pw: jing90908ss).
#good

Things ot be clear:

1) All the default files are located next to the modified file, make it esay to compare
	with each other.

2) dependence:

	A). the code is in the derectory A) on argo: 		
		/home/ctang/RRTM_test/regcm/RegCM-4.4.5.10.5244.ctang.swuflx.tar
	B) my mac :
		/Users/tang/climate/Modeling/ICTP/code.in.ictp.argo
	C) on titan:
		&&&&&&&&&&&&&&&&&&&&&&&& not here 

3) Attention: 
	please rerun ./bootstrap.sh after copy this to other places.
	to avoid possible dependence problems.

4) to locate the changes, just search the code:
	( search the tag="to_save_var_swuflx_ctang_2015_11_16" made by ctang in the code)


5) the output file is named as $varname.nc in the working directory( out of output directory).

6) the output frequency is indicated in namelist file by parameter dt (e.g. 100 seconds)

7) just follow this file change.file.sh

#===================================================
vim Main/mod_regcm_interface.F90 +/to_save_var_swuflx_ctang_2015_11_16
vim Main/mpplib/mod_regcm_types.F90 +/to_save_var_swuflx_ctang_2015_11_16
vim Main/mod_rad_interface.F90 +/to_save_var_swuflx_ctang_2015_11_16
vim Main/radlib/mod_rrtmg_driver.F90 +/to_save_var_swuflx_ctang_2015_11_16
vim Main/radlib/mod_rad_colmod3.F90 +/to_save_var_swuflx_ctang_2015_11_16
vim Main/mpplib/mod_ncout.F90 +/to_save_var_swuflx_ctang_2015_11_16
vim Main/radlib/mod_rad_outrad.F90 +/to_save_var_swuflx_ctang_2015_11_16
vim Main/mod_atm_interface.F90 +/to_save_var_swuflx_ctang_2015_11_16

exit

#================================================== First
# First:
# mod_regcm_interface call grid_nc_create in mod_mpparam.F90, line 108.
# to save variable, the frequence is indicated in namelist file,by dt(exp. 100 seconds)

 Main/mod_regcm_interface.F90  
Line: ~ 222

!   to_save_var_swuflx_ctang_2015_11_16
	#call grid_nc_greate('czen',cross,myvar_0,my2d_0)
    call grid_nc_create('swuflx',cross,myvar_1,my3d_1)
    call grid_nc_create('swdflx',cross,myvar_2,my3d_2)
    call grid_nc_create('swhr',cross,myvar_3,my3d_3)
    call grid_nc_create('swuflxc',cross,myvar_4,my3d_4)
    call grid_nc_create('swdflxc',cross,myvar_5,my3d_5)
    call grid_nc_create('swhrc',cross,myvar_6,my3d_6)
#ifdef DEBUG

Line: ~ 288

      call output
!   to_save_var_swuflx_ctang_2015_11_16
	  !call grid_nc_write(my2d_0)
      call grid_nc_write(my3d_1)
      call grid_nc_write(my3d_2)
      call grid_nc_write(my3d_3)
      call grid_nc_write(my3d_4)
      call grid_nc_write(my3d_5)
      call grid_nc_write(my3d_6)
      !
      ! Send information to the driver

Line: ~ 315

!   to_save_var_swuflx_ctang_2015_11_16
    !call grid_nc_destroy(my2d_0)
    call grid_nc_destroy(my3d_1)
    call grid_nc_destroy(my3d_2)
    call grid_nc_destroy(my3d_3)
    call grid_nc_destroy(my3d_4)
    call grid_nc_destroy(my3d_5)
    call grid_nc_destroy(my3d_6)
#ifdef DEBUG

#===================================================Second
# Second
# Define the variable to be output, myvar 

Main/mod_atm_interface.F90

Line: ~ 147

  ! to_save_var_swuflx_ctang_2015_11_16
  !type(grid_nc_var2d) , public , save :: my2d_0
  type(grid_nc_var3d) , public , save :: my3d_1
  type(grid_nc_var3d) , public , save :: my3d_2
  type(grid_nc_var3d) , public , save :: my3d_3
  type(grid_nc_var3d) , public , save :: my3d_4
  type(grid_nc_var3d) , public , save :: my3d_5
  type(grid_nc_var3d) , public , save :: my3d_6
  #real(rk8) , public , pointer, dimension(:,:) , save :: myvar_0
  real(rk8) , public , pointer, dimension(:,:,:) , save :: myvar_1
  real(rk8) , public , pointer, dimension(:,:,:) , save :: myvar_2
  real(rk8) , public , pointer, dimension(:,:,:) , save :: myvar_3
  real(rk8) , public , pointer, dimension(:,:,:) , save :: myvar_4
  real(rk8) , public , pointer, dimension(:,:,:) , save :: myvar_5
  real(rk8) , public , pointer, dimension(:,:,:) , save :: myvar_6
  
===================================================
# Third,
# declairation of this myvar_?

Main/mpplib/mod_regcm_type.F90

Line: ~ 462

    real(rk8) , pointer , dimension(:,:) :: flwd
!   to_save_var_swuflx_ctang_2015_11_16
    #real(rk8) , pointer , dimension(:,:) :: myvar_0
    real(rk8) , pointer , dimension(:,:,:) :: myvar_1
    real(rk8) , pointer , dimension(:,:,:) :: myvar_2
    real(rk8) , pointer , dimension(:,:,:) :: myvar_3
    real(rk8) , pointer , dimension(:,:,:) :: myvar_4
    real(rk8) , pointer , dimension(:,:,:) :: myvar_5
    real(rk8) , pointer , dimension(:,:,:) :: myvar_6
    real(rk8) , pointer , dimension(:,:,:) :: heatrt
  end type rad_2_mod
  

# make it before heartrt !!!
===================================================
# Forth,
# Main/mod_rad_interface.F90

Line: ~ 63

  subroutine allocate_radiation
!   to_save_var_swuflx_ctang_2015_11_16
    use mod_atm_interface , only : myvar_1,myvar_2,myvar_3,myvar_4,myvar_5,myvar_6
    implicit none
    
Line: ~ 73

    call allocate_mod_rad_outrad
    if ( irrtm == 1 ) then
!   to_save_var_swuflx_ctang_2015_11_16
      call allocate_mod_rad_rrtmg(myvar_1,myvar_2,myvar_3,myvar_4,myvar_5,myvar_6)
    
Line: ~ 129

    call assignpnt(heatrt,r2m%heatrt)
!   to_save_var_swuflx_ctang_2015_11_16
    #call assignpnt(myvar_0,r2m%myvar_0)
    call assignpnt(myvar_1,r2m%myvar_1)
    call assignpnt(myvar_2,r2m%myvar_2)
    call assignpnt(myvar_3,r2m%myvar_3)
    call assignpnt(myvar_4,r2m%myvar_4)
    call assignpnt(myvar_5,r2m%myvar_5)
    call assignpnt(myvar_6,r2m%myvar_6)
  end subroutine init_radiation

===================================================
# Fifth
# Main/radlib/mod_rrtmg_driver.F90 :

Line: ~ 98

  
  ! to save myvar, by GG
  ! to_save_var_swuflx_ctang_2015_11_16
   subroutine allocate_mod_rad_rrtmg(myvar_1,myvar_2,myvar_3,myvar_4,myvar_5,myvar_6)
  !subroutine allocate_mod_rad_rrtmg(myvar_2)
  !subroutine allocate_mod_rad_rrtmg(myvar_3)
  !subroutine allocate_mod_rad_rrtmg(myvar_4)
  !subroutine allocate_mod_rad_rrtmg(myvar_5)
  !subroutine allocate_mod_rad_rrtmg(myvar_6)
  
  
Line: ~ 110
    implicit none
  ! to_save_var_swuflx_ctang_2015_11_16
    real(rk8) , pointer , dimension(:,:,:) :: myvar_1
    real(rk8) , pointer , dimension(:,:,:) :: myvar_2
    real(rk8) , pointer , dimension(:,:,:) :: myvar_3
    real(rk8) , pointer , dimension(:,:,:) :: myvar_4
    real(rk8) , pointer , dimension(:,:,:) :: myvar_5
    real(rk8) , pointer , dimension(:,:,:) :: myvar_6
    integer(ik4) :: k

#if defined ( __PGI ) || defined ( __OPENCC__ ) || defined ( __INTEL_COMPILER )
    integer , external :: getpid
    
    
Line: ~ 138

    ktf = kzp1 + n_preflev - kclimf - 1


    ! to save myvar, by GG
    !   to_save_var_swuflx_ctang_2015_11_16
    ! call getmem2d(myvar_0,jci1,jci2,ici1,ici2,'rrtmg:myvar_0')
    
    call getmem3d(myvar_1,jci1,jci2,ici1,ici2,1,ktf,'rrtmg:myvar_1')
    call getmem3d(myvar_2,jci1,jci2,ici1,ici2,1,ktf,'rrtmg:myvar_2')
    call getmem3d(myvar_3,jci1,jci2,ici1,ici2,1,ktf,'rrtmg:myvar_3')
    call getmem3d(myvar_4,jci1,jci2,ici1,ici2,1,ktf,'rrtmg:myvar_4')
    call getmem3d(myvar_5,jci1,jci2,ici1,ici2,1,ktf,'rrtmg:myvar_5')
    call getmem3d(myvar_6,jci1,jci2,ici1,ici2,1,ktf,'rrtmg:myvar_6')

    call getmem1d(frsa,1,npr,'rrtmg:frsa')
    
    
Line: ~ 440

  totcl(:) = sum(clwp_int,2)*d_r1000
! to_save_var_swuflx_ctang_2015_11_16
    call radout(lout,solin,sabtp,frsa,clrst,clrss,qrs,            &
                firtp,frla,clrlt,clrls,qrl,slwd,sols,soll,solsd,  &
                solld,swuflx,swdflx,swhr,swuflxc,swdflxc,swhrc,   &
                totcf,totcl,totci,cld_int,clwp_int,abv,     &
                sol,aeradfo,aeradfos,aerlwfo,aerlwfos,tauxar3d,   &
                tauasc3d,gtota3d,deltaz,outtaucl,outtauci,r2a,ktf, &
                asaeradfo,asaeradfos,asaerlwfo,asaerlwfos)
  end subroutine rrtmg_driver
  
  ATTENTION: 
  
  1) the order of variable is important: 
  	add 6 variables before totcf,after solld; and add,ktf,after r2a.
  2) this form of the function "radout" could keeps exactly the same 
  	as the one in ./Main/radlib/mod_rad_colmod3.F90, as following:
  	
  	Line: 451 in mod_rad_colmod3.F90
  	
  	  ! computations and output purposes.
    !
    call radout(lout,solin,fsnt,fsns,fsntc,fsnsc,qrs,flnt,flns,  &
                flntc,flnsc,qrl,flwds,sols,soll,solsd,solld,     &
                qrl,qrl,qrl,qrl,qrl,qrl,totcf,totcl,totci,cld,clwp,abv,sol,aeradfo,      &
                aeradfos,aerlwfo,aerlwfos,tauxar3d,tauasc3d,     &
                gtota3d,deltaz,outtaucl,outtauci,r2m,0)
	#ifdef DEBUG
	
	A) 6 3d variable are added in the same location, although they're not used.
	B) add a '0' after r2m, as ktf correspondingly
	
	AND AND AND AND AND ANDAND AND ANDAND AND ANDAND AND ANDAND AND AND
	
	the same as "radout" in Main/radlib/mod_rad_outrad.F90 Line ~ 49
	
	  end subroutine allocate_mod_rad_outrad
     !
     !   to_save_var_swuflx_ctang_2015_11_16
      subroutine radout(lout,solin,sabtp,frsa,clrst,clrss,qrs,firtp,         &
                    frla,clrlt,clrls,qrl,slwd,sols,soll,solsd,solld,     &
                    swuflx,swdflx,swhr,swuflxc,swdflxc,swhrc,   &
                    totcf,totcl,totci,cld,clwp,abv,sol,aeradfo,aeradfos, &
                    aerlwfo,aerlwfos,tauxar3d,tauasc3d,gtota3d,deltaz,   &
                    outtaucl,outtauci,r2m,ktf,                           &
                    asaeradfo,asaeradfos,asaerlwfo,asaerlwfos)
       implicit none
    !
    ! copy radiation output quantities to model buffer

	A) 6 3d variable are added in the same location, although they're not used.
	B) add a '0' after r2m, as ktf correspondingly

	
	
  	#---------------- end of ATTENTION.


===================================================
# Sixth
# Main/mpplib/mod_ncout.F90


Line: ~ nothing


===================================================
# Seventh
# Main/radlib/mod_rad_outrad.F90 


Line: ~ 49

	see "radout" above
	
	
Line: ~ 92

 add "czen" after "solld" as a 2d variable:

    logical , intent(in) :: lout ! Preapre data for outfile
     !   to_save_var_swuflx_ctang_2015_11_16
    real(rk8) , pointer , dimension(:) :: clrls , clrlt ,  &
                clrss , clrst , firtp , frla , frsa ,      &
                sabtp , slwd , solin , soll , solld ,czen,  &
                sols , solsd , totcf , totcl , totci , abv , sol
 	
Line: ~ 90

     !   to_save_var_swuflx_ctang_2015_11_16
    real(rk8) , pointer , dimension(:,:) :: cld , clwp , qrl ,
    swuflx,swdflx,swhr,swuflxc,swdflxc,swhrc,qrs , deltaz
    real(rk8) , pointer , dimension(:,:,:) :: outtaucl , outtauci
    

Line: ~ 100

# to declaim ktf.

    real(rk8) , pointer , dimension(:) :: aerlwfo , aerlwfos
!   to_save_var_swuflx_ctang_2015_11_16
    integer(ik4) :: ktf
    intent (in) cld , clrls , clrlt , clrss , clrst ,             &
                clwp , firtp , frla , frsa , qrl , qrs , sabtp ,  &
                slwd , solin , soll , solld , sols , solsd ,      &
                totcf , totcl , totci , aeradfo , aeradfos,       &
                asaeradfo , asaeradfos , aerlwfo , aerlwfos ,    &
                asaerlwfo , asaerlwfos , deltaz , outtaucl ,     &
                outtauci , ktf
    type(rad_2_mod) , intent(inout) :: r2m
    
 
 Line: ~ 125
 
 attention: the call for rrtmg_sw is defined in Main/radlib/mod_rrtmg_drier.F90
 
 which is depend on the czen, one element of czen > zero, the rrtmg_sw is called.
 
        end do
      end do
    ! to save myvar, ctang
!   to_save_var_swuflx_ctang_2015_11_16
    if ( irrtm == 1 ) then
      do k = 1 , ktf
        n = 1
        do i = ici1 , ici2
          do j = jci1 , jci2
            r2m%myvar_1(j,i,k) = swuflx(n,k)
            r2m%myvar_2(j,i,k) = swdflx(n,k)
            r2m%myvar_3(j,i,k) = swhr(n,k)
            r2m%myvar_4(j,i,k) = swuflxc(n,k)
            r2m%myvar_5(j,i,k) = swdflxc(n,k)
            r2m%myvar_6(j,i,k) = swhrc(n,k)
            n = n + 1
          end do
        end do
      end do
    end if
    ! surface absorbed solar flux in watts/m2
    ! net up longwave flux at the surface
    
    
Line: ~ 175

			#r2m%myvar_0(j,i) = czen(n)
			n = n + 1
		end do
	end do
	
===================================================
# Eighth
# ./Main/radlib/mod_rad_colmod3.F90

see "radout"




===================================================

===================================================
===================================================
===================================================
===================================================
===================================================
===================================================
in inside rrtmg_sw_rad.F90 do the same thing:

===================================================
===================================================
===================================================
===================================================

First,



LINE: ~ 65 

 	! to_save_var_swuflx_ctang_2015_11_25
    use mod_dynparm, only : myid
      
      
LINE: ~ 486


    ! to_save_var_swuflx_ctang_2015_11_25
    !write(10+myid) '##########jjj############'
    !write(100+myid,'(I10)') nlay
    !write(200+myid,'(I10)') ncol
    !do i = 1 , nlay+1
      !!do iplon = 1, ncol
      !write(1000+myid,'(f15.7)') swuflx(10000,i)
      !write(2000+myid,'(f15.7)') swuflxc(10000,i)
      !write(3000+myid,'(f15.7)') swdflx(10000,i)
      !write(4000+myid,'(f15.7)') swdflxc(10000,i)
      !write(5000+myid,'(f15.7)') swhr(10000,i)
      !write(6000+myid,'(f15.7)') swhrc(10000,i)
      !!end do
    !end do
    !flush(10+myid)
    !flush(100+myid)
    !flush(200+myid)
    !flush(1000+myid)
    !flush(2000+myid)
    !flush(3000+myid)
    !flush(4000+myid)
    !flush(5000+myid)
    !flush(6000+myid)

    !stop

    ! Initializations

LINE: ~ 842 

after the calculation, at the end fo shis subroutine:

      ! End longitude loop
    end do

    ! to_save_var_swuflx_ctang_2015_11_25
    write(10+myid) '#########kkk#############'
    do i = 1 , nlay+1
      !do iplon = 1, ncol
      write(10000+myid,'(f15.7)') swuflx(10000,i)
      write(20000+myid,'(f15.7)') swuflxc(10000,i)
      write(30000+myid,'(f15.7)') swdflx(10000,i)
      write(40000+myid,'(f15.7)') swdflxc(10000,i)
      write(50000+myid,'(f15.7)') swhr(10000,i)
      write(60000+myid,'(f15.7)') swhrc(10000,i)
      !end do
    end do
    flush(10+myid)
    flush(10000+myid)
    flush(20000+myid)
    flush(30000+myid)
    flush(40000+myid)
    flush(50000+myid)
    flush(60000+myid)

    !stop
      end subroutine rrtmg_sw
