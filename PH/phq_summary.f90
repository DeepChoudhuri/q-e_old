!
! Copyright (C) 2001 PWSCF group
! This file is distributed under the terms of the
! GNU General Public License. See the file `License'
! in the root directory of the present distribution,
! or http://www.gnu.org/copyleft/gpl.txt .
!
!
!-----------------------------------------------------------------------
subroutine phq_summary  
  !-----------------------------------------------------------------------
  !
  !    This routine writes on output the quantities which have been read
  !    from the punch file, and the quantities computed in the phq_setup
  !    file.
  !
  !    if iverbosity = 0 only a partial summary is done.
  !
#include"machine.h"

  use pwcom 
  use allocate 
  use parameters, only : DP 
  use phcom 
  implicit none 

  integer :: i, l, nt, mu, nu, ipol, apol, na, isymq, isym, nsymtot, &
       ik, ib, irr, imode0
  ! generic counter
  ! counter on angular momenta
  ! counter on atomi types
  ! counter on modes
  ! counter on modes
  ! counter on polarizations
  ! counter on polarizations
  ! counter on atoms
  ! counter on symmetries
  ! counter on symmetries
  ! counter on symmetries
  ! counter on k points
  ! counter on beta functions
  ! counter on irreducible representation
  ! the first mode

  real(kind=DP) :: ft1, ft2, ft3, sr (3, 3), xkg (3)  
  ! fractionary translation
  ! fractionary translation
  ! fractionary translation
  ! the symmetry matrix in cartesian coord
  ! k point in crystal coordinates

  character :: ps * 5  
  ! the name of the pseudo
  write (6, 100) title_ph, crystal, ibrav, alat, omega, nat, ntyp, &
       ecutwfc, ecutwfc * dual, tr2_ph, alpha_mix (1), &
       nmix_ph
100 format (/,5x,a75,/,/,5x, 'crystal is ',a20,/,/,5x, &
       &     'bravais-lattice index     = ',i12,/,5x, &
       &     'lattice parameter (a_0)   = ',f12.4,'  a.u.',/,5x, &
       &     'unit-cell volume          = ',f12.4,' (a.u.)^3',/,5x, &
       &     'number of atoms/cell      = ',i12,/,5x, &
       &     'number of atomic types    = ',i12,/,5x, &
       &     'kinetic-energy cut-off    = ',f12.4,'  Ry',/,5x, &
       &     'charge density cut-off    = ',f12.4,'  Ry',/,5x, &
       &     'convergence threshold     = ',1pe12.1,/,5x, &
       &     'beta                      = ',0pf12.4,/,5x, &
       &     'number of iterations used = ',i12,/)
  !
  !    and here more detailed informations. Description of the unit cell
  !
  write (6, '(2(3x,3(2x,"celldm(",i1,")=",f11.5),/))') (i, &
       celldm (i) , i = 1, 6)
  write (6, '(5x, &
       &  "crystal axes: (cart. coord. in units of a_0)",/, &
       &         3(15x,"a(",i1,") = (",3f8.4," )  ",/ ) )')  (apol, &
       & (at (ipol, apol) , ipol = 1, 3) , apol = 1, 3)
  write (6, '(5x, &
       &"reciprocal axes: (cart. coord. in units 2 pi/a_0)",/, &
       &         3(15x,"b(",i1,") = (",3f8.4," )  ",/ ) )')  (apol, &
       & (bg (ipol, apol) , ipol = 1, 3) , apol = 1, 3)
  !
  !    description of the atoms inside the unit cell
  !
  write (6, '(/, 5x,"Atoms inside the unit cell: ")')  
  write (6, '(/,3x,"Cartesian axes")')  
  write (6, '(/,5x,"site n.  atom      mass ", &
       &                "          positions (a_0 units)")')

  write (6, '(7x,i2,5x,a6,f8.4,"   tau(",i2, &
       &                              ") = (",3f11.5,"  )")')  &
       &(na, atm (ityp (na) ) , amass (ityp (na) )  / amconv, na,  &
       &(tau (ipol, na) , ipol = 1, 3) , na = 1, nat)
  write (6, '(/,5x,"Computing dynamical matrix for ")')  
  write (6, '(20x,"q = (",3f11.5," )")') (xq (ipol) , ipol = 1, &
       3)
  !
  !   description of symmetries
  !
  write (6, * )  
  if (nsymq.le.1.and..not.minus_q) then  
     write (6, '(5x,"No symmetry!")')  
  else  
     if (minus_q) then  
        write (6, '(5x,i2," Sym.Ops. (with q -> -q+G )",/)') &
             nsymq + 1
     else  
        write (6, '(5x,i2," Sym.Ops. (no q -> -q+G )",/)') nsymq  
     endif

  endif
  if (iverbosity.eq.1) then  

     write (6, '(36x,"s",24x,"frac. trans.")')  
     if (minus_q) then  
        nsymtot = nsymq + 1  
     else  
        nsymtot = nsymq  
     endif
     do isymq = 1, nsymtot  
        if (isymq.gt.nsymq) then  
           isym = irotmq  
           write (6, '(/,5x,"This transformation sends q -> -q+G")')  
        else  
           isym = irgq (isymq)  
        endif
        write (6, '(/6x,"isym = ",i2,5x,a45/)') isymq, sname (isym)  
        call s_axis_to_cart (s (1, 1, isym), sr, at, bg)  
        if (ftau (1, isym) .ne.0.or.ftau (2, isym) .ne.0.or.ftau (3, &
             isym) .ne.0) then
           ft1 = at (1, 1) * ftau (1, isym) / nr1 + at (1, 2) * ftau ( &
                2, isym) / nr2 + at (1, 3) * ftau (3, isym) / nr3
           ft2 = at (2, 1) * ftau (1, isym) / nr1 + at (2, 2) * ftau ( &
                2, isym) / nr2 + at (2, 3) * ftau (3, isym) / nr3
           ft3 = at (3, 1) * ftau (1, isym) / nr1 + at (3, 2) * ftau ( &
                2, isym) / nr2 + at (3, 3) * ftau (3, isym) / nr3
           write (6, '(1x,"cryst.",3x,"s(",i2,") = (",3(i6,5x), &
                &                    " )    f =( ",f10.7," )")') isymq,  (s (1, &
                & ipol, isym) , ipol = 1, 3) , float (ftau (1, isym) )  / float (nr1)
           write (6, '(17x," (",3(i6,5x), &
                &                    " )       ( ",f10.7," )")')  (s (2, ipol, &
                &isym) , ipol = 1, 3) , float (ftau (2, isym) )  / float (nr2)
           write (6, '(17x," (",3(i6,5x), &
                &                    " )       ( ",f10.7," )"/)')  (s (3, ipol, &
                & isym) , ipol = 1, 3) , float (ftau (3, isym) )  / float (nr3)
           write (6, '(1x,"cart.",3x,"s(",i2,") = (",3f11.7, &
                &                    " )    f =( ",f10.7," )")') isymq,  (sr (1 &
                &, ipol) , ipol = 1, 3) , ft1
           write (6, '(17x," (",3f11.7, &
                &                    " )       ( ",f10.7," )")')  (sr (2, ipol) &
                & , ipol = 1, 3) , ft2
           write (6, '(17x," (",3f11.7, &
                &                    " )       ( ",f10.7," )"/)')  (sr (3, ipol &
                &) , ipol = 1, 3) , ft3
        else  
           write (6, '(1x,"cryst.",3x,"s(",i2,") = (",3(i6,5x), &
                &                    " )")') isymq,  (s (1, ipol, isym) , ipol = &
                &1, 3)
           write (6, '(17x," (",3(i6,5x)," )")') (s (2, ipol, isym) &
                , ipol = 1, 3)
           write (6, '(17x," (",3(i6,5x)," )"/)') (s (3, ipol, &
                isym) , ipol = 1, 3)
           write (6, '(1x,"cart.",3x,"s(",i2,") = (",3f11.7, &
                &                    " )")') isymq,  (sr (1, ipol) , ipol = 1, 3)
           write (6, '(17x," (",3f11.7," )")') (sr (2, ipol) , &
                ipol = 1, 3)
           write (6, '(17x," (",3f11.7," )"/)') (sr (3, ipol) , &
                ipol = 1, 3)
        endif
     enddo
  endif
  !
  !     Description of the reciprocal lattice vectors
  !
  write (6, '(/5x,"G cutoff =",f10.4,"  (", &
       &       i7," G-vectors)","     FFT grid: (",i3, &
       &       ",",i3,",",i3,")")') gcutm, ngm, nr1, nr2, nr3

  if (doublegrid) write (6, '(5x,"G cutoff =",f10.4,"  (", &
       &                      i7," G-vectors)","  smooth grid: (",i3, &
       &                      ",",i3,",",i3,")")') gcutms, ngms, nr1s, nr2s, nr3s
  if (degauss.eq.0.d0) then  
     write (6, '(5x,"number of k points=",i5)') nkstot  
  else  
     write (6, '(5x,"number of k points=",i5, &
          &               "  gaussian broad. (ryd)=",f8.4,5x, &
          &               "ngauss = ",i3)') nkstot, degauss, ngauss
  endif
  write (6, '(23x,"cart. coord. in units 2pi/a_0")')  
  do ik = 1, nkstot  
     write (6, '(8x,"k(",i5,") = (",3f12.7,"), wk =",f12.7)') ik, &
          (xk (ipol, ik) , ipol = 1, 3) , wk (ik)
  enddo
  if (iverbosity.eq.1) then  
     write (6, '(/23x,"cryst. coord.")')  
     do ik = 1, nkstot  
        do ipol = 1, 3  
           ! xkg are the compone
           xkg (ipol) = at (1, ipol) * xk (1, ik) + at (2, ipol) * xk (2, &
                ik) + at (3, ipol) * xk (3, ik)
           ! of xk in the crysta
           ! rec. lattice basis
        enddo
        write (6, '(8x,"k(",i5,") = (",3f12.7,"), wk =",f12.7)') &
             ik, (xkg (ipol) , ipol = 1, 3) , wk (ik)
     enddo

  endif
  do nt = 1, ntyp  
     if (tvanp (nt) ) then  
        ps = '(US)'  
        write (6, '(/5x,"pseudo",i2," is ",a2, &
             &        1x,a5,"   zval =",f5.1,"   lmax=",i2, &
             &        "   lloc=",i2)') nt, psd (nt) , ps, zp (nt) , lmax (nt) &
             &, lloc (nt)
        write (6, '(5x,"Version ", 3i3, " of US pseudo code")') &
             (iver (i, nt) , i = 1, 3)
        write (6, '(/,5x,"Using log mesh of ", i5, " points",/)') &
             mesh (nt)
        write (6, '(5x,"The pseudopotential has ",i2, &
             &       " beta functions with: ",/)') nbeta (nt)
        do ib = 1, nbeta (nt)  
           write (6, '(15x," l(",i1,") = ",i3)') ib, lll (ib, nt)  

        enddo
        write (6, '(/,5x,"Q(r) pseudized with ", &
             &          i2," coefficients,  rinner = ",3f8.3, /, &
             &          58x,2f8.3)') nqf (nt) ,  (rinner (i, nt) , i = 1, nqlc ( &
             &nt) )
     else  
        if (nlc (nt) .eq.1.and.nnl (nt) .eq.1) then  
           ps = '(vbc)'  
        elseif (nlc (nt) .eq.2.and.nnl (nt) .eq.3) then  
           ps = '(bhs)'  
        elseif (nlc (nt) .eq.1.and.nnl (nt) .eq.3) then  
           ps = '(our)'  
        else  
           ps = '     '  

        endif

        write (6, '(/5x,"pseudo",i2," is ",a2, &
             &        1x,a5,"   zval =",f5.1,"   lmax=",i2, &
             &        "   lloc=",i2)') nt, psd (nt) , ps, zp (nt) , lmax (nt) &
             &, lloc (nt)
        if (numeric (nt) ) then  
           write (6, '(5x,"(in numerical form: ",i3,&
                &" grid points",", xmin = ",f5.2,", dx = ",&
                &f6.4,")")' )  mesh (nt) , xmin (nt) , dx (nt)
        else  
           write (6, '(/14x,"i=",7x,"1",13x,"2",10x,"3")')  
           write (6, '(/5x,"core")')  
           write (6, '(5x,"alpha =",4x,3g13.5)') (alpc (i, nt) , i = &
                1, 2)
           write (6, '(5x,"a(i)  =",4x,3g13.5)')  (cc (i, nt) , i = 1, 2)  
           do l = 0, lmax (nt)  
              write (6, '(/5x,"l = ",i2)') l  
              write (6, '(5x,"alpha =",4x,3g13.5)') (alps (i, l, nt) , &
                   i = 1, 3)
              write (6, '(5x,"a(i)  =",4x,3g13.5)')  (aps (i, l, nt) , i = 1, &
                   &3)
              write (6, '(5x,"a(i+3)=",4x,3g13.5)') (aps (i, l, nt) , i &
                   = 4, 6)
           enddo
           if (nlcc (nt) ) write (6, 200) a_nlcc (nt), b_nlcc (nt), &
                alpha_nlcc (nt)
200        format(/5x,'nonlinear core correction: ', &
                &          'rho(r) = ( a + b r^2) exp(-alpha r^2)', &
                &          /,5x,'a    =',4x,g11.5, &
                &          /,5x,'b    =',4x,g11.5, &
                &          /,5x,'alpha=',4x,g11.5)
        endif
     endif
  enddo
  write (6, '(//5x,"Atomic displacements:")')  
  write (6, '(5x,"There are ",i3," irreducible representations") &
       &') nirr
  imode0 = 0  
  do irr = 1, nirr  
     if (done_irr (irr) .eq.1) then  
        write (6, '(/, 5x,"Representation ",i5,i7, &
             &                  " modes -  Done")') irr, npert (irr)
     elseif (comp_irr (irr) .eq.1) then  
        write (6, '(/, 5x,"Representation ",i5,i7, &
             &             " modes - To be done")') irr, npert (irr)
     elseif (comp_irr (irr) .eq.0) then  
        write (6, '(/, 5x,"Representation ",i5,i7, &
             &     " modes - Not done in this run")') irr, npert (irr)
     endif
     if (iverbosity.eq.1) then  

        write (6, '(5x,"Phonon polarizations are as follows:",/)')  
        if (npert (irr) .eq.1) then  
           write (6, '(20x," mode # ",i3)') imode0 + 1  
           write (6, '(20x," (",2f10.5,"   ) ")')  ( (u (mu, nu) ,&
                &nu = imode0 + 1, imode0 + npert (irr) ) , mu = 1, 3 * nat)
        elseif (npert (irr) .eq.2) then  
           write (6, '(2(10x," mode # ",i3,16x))') imode0 + 1, &
                imode0 + 2
           write (6, '(2(10x," (",2f10.5,"   ) "))')  ( (u (mu, nu) , nu &
                &= imode0 + 1, imode0 + npert (irr) ) , mu = 1, 3 * nat)
        else  
           write (6, '(4x,3(" mode # ",i3,13x))') imode0 + 1, imode0 &
                + 2, imode0 + 3
           write (6, '((5x,3("(",2f10.5," ) ")))') ( (u (mu, nu) , &
                nu = imode0 + 1, imode0 + npert (irr) ) , mu = 1, 3 * nat)
        endif
        imode0 = imode0 + npert (irr)  
     endif
  enddo
  if (.not.all_comp) then  
     write (6, '(/,5x,"Compute atoms: ",8(i5,","))') (atomo (na) &
          , na = 1, nat_todo)
  endif
#ifdef FLUSH
  call flush (6)  
#endif
  return  
end subroutine phq_summary
