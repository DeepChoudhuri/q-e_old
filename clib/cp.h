/*
  Copyright (C) 2002 FPMD group
  This file is distributed under the terms of the
  GNU General Public License. See the file `License'
  in the root directory of the present distribution,
  or http://www.gnu.org/copyleft/gpl.txt .
*/



#if defined __CRAY | defined __ABSOFT

#  define CREATE_PLAN CREATE_PLAN
#  define CREATE_PLANX CREATE_PLANX
#  define CREATE_PLANY CREATE_PLANY
#  define CREATE_PLANZ CREATE_PLANZ
#  define DESTROY_PLAN DESTROY_PLAN
#  define DESTROY_PLANX DESTROY_PLANX
#  define DESTROY_PLANY DESTROY_PLANY
#  define DESTROY_PLANZ DESTROY_PLANZ
#  define FFT_X_STICK FFT_X_STICK
#  define FFT_XY_STICK FFT_XY_STICK
#  define FFT_XY FFT_XY
#  define FFT_Y_STICK FFT_Y_STICK
#  define FFT_Y_STICK2 FFT_Y_STICK2
#  define FFT_Z_STICK FFT_Z_STICK
#  define FFT_Z FFT_Z
#  define FFT_STICK FFT_STICK
#  define CP_GETENV CP_GETENV
#  define CP_DATE CP_DATE
#  define CPFLUSH CPFLUSH
#  define CPTIMER CPTIMER
#  define ELAPSED_SECONDS ELAPSED_SECONDS
#  define FACTOR235 FACTOR235
#  define FACTOR2 FACTOR2
#  define LN_ALLOC LN_ALLOC 
#  define LN_DEALLOC LN_DEALLOC
#  define LN_SET LN_SET
#  define LN_ACTIVATE LN_ACTIVATE
#  define LN_IND LN_IND
#  define MEMSTAT MEMSTAT
#  define READOCC READOCC
#  define ROUND2 ROUND2
#  define MYUNITNAME MYUNITNAME
#  define CP_ITOA CP_ITOA

#endif

#if defined __SGI | defined __FUJITSU | defined __SX5 | defined __INTEL

#  define CREATE_PLAN create_plan_
#  define CREATE_PLANX create_planx_
#  define CREATE_PLANY create_plany_
#  define CREATE_PLANZ create_planz_
#  define DESTROY_PLAN destroy_plan_
#  define DESTROY_PLANX destroy_planx_
#  define DESTROY_PLANY destroy_plany_
#  define DESTROY_PLANZ destroy_planz_
#  define FFT_X_STICK fft_x_stick_
#  define FFT_XY_STICK fft_xy_stick_
#  define FFT_XY fft_xy_
#  define FFT_Y_STICK fft_y_stick_
#  define FFT_Y_STICK2 fft_y_stick2_
#  define FFT_Z_STICK fft_z_stick_
#  define FFT_Z fft_z_
#  define FFT_STICK fft_stick_
#  define CP_GETENV cp_getenv_
#  define CP_DATE cp_date_
#  define CPFLUSH cpflush_
#  define CPTIMER cptimer_
#  define ELAPSED_SECONDS elapsed_seconds_
#  define CCLOCK cclock_
#  define FACTOR235 factor235_
#  define FACTOR2 factor2_
#  define LN_ALLOC ln_alloc_ 
#  define LN_DEALLOC ln_dealloc_
#  define LN_SET ln_set_
#  define LN_ACTIVATE ln_activate_
#  define LN_IND ln_ind_
#  define MEMSTAT memstat_
#  define READOCC readocc_
#  define ROUND2 round2_
#  define MYUNITNAME myunitname_
#  define CP_ITOA cp_itoa_

#endif

#if defined __PORTLAND

#  if defined __GNU_LINK

#  define CREATE_PLAN create_plan__
#  define CREATE_PLANX create_planx__
#  define CREATE_PLANY create_plany__
#  define CREATE_PLANZ create_planz__
#  define DESTROY_PLAN destroy_plan__
#  define DESTROY_PLANX destroy_planx__
#  define DESTROY_PLANY destroy_plany__
#  define DESTROY_PLANZ destroy_planz__
#  define FFT_X_STICK fft_x_stick__
#  define FFT_XY_STICK fft_xy_stick__
#  define FFT_XY fft_xy__
#  define FFT_Y_STICK fft_y_stick__
#  define FFT_Y_STICK2 fft_y_stick2__
#  define FFT_Z_STICK fft_z_stick__
#  define FFT_Z fft_z__
#  define FFT_STICK fft_stick_
#  define CP_GETENV cp_getenv_
#  define CP_DATE cp_date_
#  define CPFLUSH cpflush_
#  define CPTIMER cptimer_
#  define CCLOCK cclock_
#  define ELAPSED_SECONDS elapsed_seconds_
#  define FACTOR235 factor235__
#  define FACTOR2 factor2__
#  define LN_ALLOC ln_alloc__
#  define LN_DEALLOC ln_dealloc__
#  define LN_SET ln_set__
#  define LN_ACTIVATE ln_activate__
#  define LN_IND ln_ind__
#  define MEMSTAT memstat_
#  define READOCC readocc__
#  define ROUND2 round2__
#  define MYUNITNAME myunitname__
#  define CP_ITOA cp_itoa__

#  else

#  define CREATE_PLAN create_plan_
#  define CREATE_PLANX create_planx_
#  define CREATE_PLANY create_plany_
#  define CREATE_PLANZ create_planz_
#  define DESTROY_PLAN destroy_plan_
#  define DESTROY_PLANX destroy_planx_
#  define DESTROY_PLANY destroy_plany_
#  define DESTROY_PLANZ destroy_planz_
#  define FFT_X_STICK fft_x_stick_
#  define FFT_XY_STICK fft_xy_stick_
#  define FFT_XY fft_xy_
#  define FFT_Y_STICK fft_y_stick_
#  define FFT_Y_STICK2 fft_y_stick2_
#  define FFT_Z_STICK fft_z_stick_
#  define FFT_Z fft_z_
#  define FFT_STICK fft_stick_
#  define CP_GETENV cp_getenv_
#  define CP_DATE cp_date_
#  define CPFLUSH cpflush_
#  define CPTIMER cptimer_
#  define ELAPSED_SECONDS elapsed_seconds_
#  define CCLOCK cclock_
#  define FACTOR235 factor235_
#  define FACTOR2 factor2_
#  define LN_ALLOC ln_alloc_
#  define LN_DEALLOC ln_dealloc_
#  define LN_SET ln_set_
#  define LN_ACTIVATE ln_activate_
#  define LN_IND ln_ind_
#  define MEMSTAT memstat_
#  define READOCC readocc_
#  define ROUND2 round2_
#  define MYUNITNAME myunitname_
#  define CP_ITOA cp_itoa_

#  endif

#endif

#if defined __AIX 

#  define CP_GETENV cp_getenv
#  define CP_DATE cp_date
#  define CREATE_PLAN create_plan
#  define CREATE_PLANX create_planx
#  define CREATE_PLANY create_plany
#  define CREATE_PLANZ create_planz
#  define DESTROY_PLAN destroy_plan
#  define DESTROY_PLANX destroy_planx
#  define DESTROY_PLANY destroy_plany
#  define DESTROY_PLANZ destroy_planz
#  define FFT_X_STICK fft_x_stick
#  define FFT_XY_STICK fft_xy_stick
#  define FFT_XY fft_xy
#  define FFT_Y_STICK fft_y_stick
#  define FFT_Y_STICK2 fft_y_stick2
#  define FFT_Z_STICK fft_z_stick
#  define FFT_Z fft_z
#  define FFT_STICK fft_stick
#  define CPFLUSH cpflush
#  define CPTIMER cptimer
#  define ELAPSED_SECONDS elapsed_seconds
#  define CCLOCK cclock
#  define FACTOR235 factor235
#  define FACTOR2 factor2
#  define LN_ALLOC ln_alloc 
#  define LN_DEALLOC ln_dealloc
#  define LN_SET ln_set
#  define LN_ACTIVATE ln_activate
#  define LN_IND ln_ind
#  define MEMSTAT memstat
#  define READOCC readocc
#  define ROUND2 round2
#  define MYUNITNAME myunitname
#  define CP_ITOA cp_itoa

#endif

#if defined __QSW

#  if defined __TRU64

#    define CREATE_PLAN create_plan_
#    define CREATE_PLANX create_planx_
#    define CREATE_PLANY create_plany_
#    define CREATE_PLANZ create_planz_
#    define DESTROY_PLAN destroy_plan_
#    define DESTROY_PLANX destroy_planx_
#    define DESTROY_PLANY destroy_plany_
#    define DESTROY_PLANZ destroy_planz_
#    define FFT_X_STICK fft_x_stick_
#    define FFT_XY_STICK fft_xy_stick_
#    define FFT_XY fft_xy_
#    define FFT_Y_STICK fft_y_stick_
#    define FFT_Y_STICK2 fft_y_stick2_
#    define FFT_Z_STICK fft_z_stick_
#    define FFT_Z fft_z_
#    define FFT_STICK fft_stick_
#    define CP_GETENV cp_getenv_
#    define CP_DATE cp_date_
#    define CPFLUSH cpflush_
#    define CPTIMER cptimer_
#    define ELAPSED_SECONDS elapsed_seconds_
#    define CCLOCK cclock_
#    define FACTOR235 factor235_
#    define FACTOR2 factor2_
#    define LN_ALLOC ln_alloc_
#    define LN_DEALLOC ln_dealloc_
#    define LN_SET ln_set_
#    define LN_ACTIVATE ln_activate_
#    define LN_IND ln_ind_
#    define MEMSTAT memstat_
#    define READOCC readocc_
#    define ROUND2 round2_
#    define MYUNITNAME myunitname_
#    define CP_ITOA cp_itoa_

#  else

#    define CREATE_PLAN create_plan_
#    define CREATE_PLANX create_planx__
#    define CREATE_PLANY create_plany__
#    define CREATE_PLANZ create_planz__
#    define DESTROY_PLAN destroy_plan__
#    define DESTROY_PLANX destroy_planx__
#    define DESTROY_PLANY destroy_plany__
#    define DESTROY_PLANZ destroy_planz__
#    define FFT_X_STICK fft_x_stick__
#    define FFT_XY_STICK fft_xy_stick_
#    define FFT_XY fft_xy_
#    define FFT_Y_STICK fft_y_stick__
#    define FFT_Y_STICK2 fft_y_stick2_
#    define FFT_Z_STICK fft_z_stick__
#    define FFT_Z fft_z_
#    define FFT_STICK fft_stick_
#    define CP_GETENV cp_getenv_
#    define CP_DATE cp_date_
#    define CPFLUSH cpflush_
#    define CPTIMER cptimer_
#    define ELAPSED_SECONDS elapsed_seconds_
#    define CCLOCK cclock_
#    define FACTOR235 factor235_
#    define FACTOR2 factor2_
#    define LN_ALLOC ln_alloc__
#    define LN_DEALLOC ln_dealloc__
#    define LN_SET ln_set__
#    define LN_ACTIVATE ln_activate__
#    define LN_IND ln_ind__
#    define MEMSTAT memstat_
#    define READOCC readocc_
#    define ROUND2 round2_
#    define MYUNITNAME myunitname_
#    define CP_ITOA cp_itoa_

#  endif

#endif
