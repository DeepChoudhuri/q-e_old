!
! Copyright (C) 2001 PWSCF group
! This file is distributed under the terms of the
! GNU General Public License. See the file `License'
! in the root directory of the present distribution,
! or http://www.gnu.org/copyleft/gpl.txt .
!
!
!-----------------------------------------------------------------------
subroutine gen_dpdvp  
  !-----------------------------------------------------------------------
  !
  ! It calculates the scalar product < Pc dpsi/du | dH/du | psi > and
  ! writes it on a file. Used in the metallic case.
  ! Three files are used:
  !  iudpdvp_1 :   < Pc dpsi_k/du(-q)    | dH/du(q) |   psi_k >
  !  iudpdvp_2 :   < Pc dpsi_k/du(-q)    | dH/du(0) |   psi_{k+q} >
  !  iudpdvp_3 :   < Pc dpsi_{k+q}/du(0) | dH/du(q) |   psi_k >
  !
#include "machine.h"
  use pwcom
  use phcom
  use d3com
  use allocate

  implicit none

  integer :: ik, ikk, ikq, ig, nrec, nu_i, nu_j, ibnd, jbnd, ios  

  real (8) :: zero (3)  
  complex (8) :: ZDOTC  
  complex (8), pointer :: dvloc (:), dpsidvpsi (:,:)


  if (degauss.eq.0.d0) return  
  call mallocate(dvloc, nrxx)  
  call mallocate(dpsidvpsi, nbnd, nbnd)  
  rewind (unit = iunigk)  

  call setv (3, 0.d0, zero, 1)  

  do ik = 1, nksq  
     read (iunigk, err = 100, iostat = ios) npw, igk  
     if (lgamma) then  
        ikk = ik  
        ikq = ik  
        npwq = npw  
     else  
        ikk = 2 * ik - 1  
        ikq = 2 * ik  
        read (iunigk, err = 100, iostat = ios) npwq, igkq  
     endif
100  call error ('gen_dpdvp', 'reading iunigk-iunigkq', abs (ios) )  
     call init_us_2 (npw, igk, xk (1, ikk), vkb0)  
     call init_us_2 (npwq, igkq, xk (1, ikq), vkb)  

     call davcio (evc, lrwfc, iuwfc, ikk, - 1)  

     if (.not.lgamma) call davcio (evq, lrwfc, iuwfc, ikq, - 1)  
     do nu_j = 1, 3 * nat  
        call dvscf (nu_j, dvloc, xq)  
        call dvdpsi (nu_j, xq, dvloc, vkb0, vkb, evc, dvpsi)
        do nu_i = 1, 3 * nat  
           nrec = (nu_i - 1) * nksq + ik  

           call davcio (dpsi, lrdwf, iudqwf, nrec, - 1)  
           do ibnd = 1, nbnd  
              do jbnd = 1, nbnd  
                 dpsidvpsi (ibnd, jbnd) = &
                      ZDOTC (npwq, dpsi (1,ibnd), 1, dvpsi (1,jbnd), 1)
              enddo
           enddo
#ifdef PARA
           call reduce (2 * nbnd * nbnd, dpsidvpsi)  
#endif
           nrec = nu_i + (nu_j - 1) * 3 * nat + (ik - 1) * 9 * nat * nat  
           call davcio (dpsidvpsi, lrdpdvp, iudpdvp_1, nrec, + 1)  
        enddo

        if (.not.lgamma) then  
           do nu_i = 1, 3 * nat  
              nrec = (nu_i - 1) * nksq + ik  
              call davcio (dpsi, lrdwf, iud0qwf, nrec, - 1)  
              do ibnd = 1, nbnd  
                 do jbnd = 1, nbnd  
                    dpsidvpsi (ibnd, jbnd) = &
                         ZDOTC (npwq, dpsi (1, ibnd), 1, dvpsi (1, jbnd), 1)
                 enddo
              enddo
#ifdef PARA
              call reduce (2 * nbnd * nbnd, dpsidvpsi)  
#endif
              nrec = nu_i + (nu_j - 1) * 3 * nat + (ik - 1) * 9 * nat * nat  
              call davcio (dpsidvpsi, lrdpdvp, iudpdvp_3, nrec, + 1)  
           enddo
        endif
     enddo

     if (.not.lgamma) then  
        npw = npwq  
        do ig = 1, npwx  
           igk (ig) = igkq (ig)  
        enddo
        do nu_j = 1, 3 * nat  
           call dvscf (nu_j, dvloc, zero)  

           call dvdpsi (nu_j, zero, dvloc, vkb,vkb, evq, dvpsi)  
           do nu_i = 1, 3 * nat  
              nrec = (nu_i - 1) * nksq + ik  

              call davcio (dpsi, lrdwf, iudqwf, nrec, - 1)  
              do ibnd = 1, nbnd  
                 do jbnd = 1, nbnd  
                    dpsidvpsi (ibnd, jbnd) = &
                         ZDOTC (npwq, dpsi (1,ibnd), 1, dvpsi(1,jbnd), 1)
                 enddo
              enddo
#ifdef PARA
              call reduce (2 * nbnd * nbnd, dpsidvpsi)  
#endif
              nrec = nu_i + (nu_j - 1) * 3 * nat + (ik - 1) * 9 * nat * nat  

              call davcio (dpsidvpsi, lrdpdvp, iudpdvp_2, nrec, + 1)  
           enddo
        enddo
     endif
  enddo

  call close_open (4)  
  call mfree (dvloc)
  call mfree (dpsidvpsi)  
  return  
end subroutine gen_dpdvp
