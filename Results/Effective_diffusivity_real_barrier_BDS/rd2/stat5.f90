module stat5_data
!*************************stat5***********************************
!     statistical analysis using                      B Bunk 1993
!           o data blocking                           rev  2/2005
!           o autocorrelation analysis
!           o jackknife

!        nvar  : no. of variables
!        nbmax : max. no. of blocks per variable
! - - - - - - - - - - - - - - - - - - - - - - - - - -

      integer, save                             :: nvar = 0, nbmax = 0
      integer, save, dimension(:), allocatable  :: nbl, lbl, lnew
      real(8), save, dimension(:,:), allocatable:: blksum
      real(8), save, dimension(:), allocatable  :: sqsum
end module stat5_data
! - - - - - - - - - - - - - - - - - - - - - - - - - -
!     allocate and clear counters
subroutine clear5(nvar1,nbmax1)

      use stat5_data

      real(8) zero
      parameter(zero=0.)

      if(nvar1.lt.1)    stop 'error in clear5: nvar is invalid'
      if(nbmax1.lt.2 .or. mod(nbmax1,2).ne.0) &
                        stop 'error in clear5: nbmax is invalid'

      if (nvar1 /= nvar .or. nbmax1 /= nbmax) then 
         if (nvar > 0) then
            deallocate(nbl, lbl, lnew, blksum, sqsum, stat=ierror)
            if(ierror /= 0) stop 'error in clear5: deallocate failed'
         endif
         allocate(nbl(nvar1), lbl(nvar1), lnew(nvar1), &
            blksum(nvar1,nbmax1), sqsum(nvar1), stat=ierror)
         if (ierror /= 0) stop 'error in clear5: allocate failed'
      endif

      nvar=nvar1
      nbmax=nbmax1

      do 10 ivar=1,nvar
      nbl(ivar)=0
      lbl(ivar)=1
      lnew(ivar)=0
      sqsum(ivar)=zero
      do 10 ibl=1,nbmax
      blksum(ivar,ibl)=zero
10    continue
end subroutine
! - - - - - - - - - - - - - - - - - - - - - - - - - -
!     accumulate data

subroutine accum5(ivar,value)

      use stat5_data

      real(8) value,zero
      parameter(zero=0.)

      if(ivar.lt.1 .or. ivar.gt.nvar) &
                  stop 'error in accum5: ivar out of range'

      if(nbl(ivar) .eq. nbmax)then
            do 10 ibl=1,nbmax/2
            blksum(ivar,ibl)=blksum(ivar,2*ibl-1) + blksum(ivar,2*ibl)
10          continue
            do 20 ibl=nbmax/2+1,nbmax
            blksum(ivar,ibl)=zero
20          continue
            nbl(ivar)=nbmax/2
            lbl(ivar)=2*lbl(ivar)
      endif

      iblnew=nbl(ivar) + 1
      blksum(ivar,iblnew)=blksum(ivar,iblnew) + value
      sqsum(ivar)=sqsum(ivar) + value**2
      lnew(ivar)=lnew(ivar) + 1

      if(lnew(ivar) .eq. lbl(ivar))then
            nbl(ivar)=iblnew
            lnew(ivar)=0
      endif
end subroutine
! - - - - - - - - - - - - - - - - - - - - - - - - - -
!     compute averages

function aver5(ivar)

      use stat5_data

      real(8) aver5,zero
      parameter(zero=0.)

      if(ivar.lt.1 .or. ivar.gt.nvar) &
                  stop 'error in aver5: ivar out of range'

      aver5=zero
      nmeas=nbl(ivar)*lbl(ivar) + lnew(ivar)
      if(nmeas.eq.0) return
      do 10 ibl=1,min(nbl(ivar)+1,nbmax)
      aver5=aver5 + blksum(ivar,ibl)
10    continue
      aver5=aver5/nmeas
end function
! - - - - - - - - - - - - - - - - - - - - - - - - - -
!     compute errors

function sigma5(ivar)

      use stat5_data

      real(8) sigma5,var5,zero
      parameter(zero=0.)

      if(ivar.lt.1 .or. ivar.gt.nvar) &
                  stop 'error in sigma5: ivar out of range'

      sigma5=sqrt(max( var5(ivar) , zero ))
end function
! - - - - - - - - - - - - - - - - - - - - - - - - - -
!     compute variances

function var5(ivar)

      use stat5_data

      real(8) var5
      real(8) av,d,gam,gamvar,zero,one
      dimension d(nbmax)
      parameter(zero=0.,one=1.)

      if(ivar.lt.1 .or. ivar.gt.nvar) &
                  stop 'error in var5: ivar out of range'

      var5=zero
      nb=nbl(ivar)
      if(nb.lt.2)return
      nmeas=nb*lbl(ivar) + lnew(ivar)

      av=zero
      do 10 ib=1,nb
      av=av + blksum(ivar,ib)
10    continue
      av=av/nb

      do 20 ib=1,nb
      d(ib)=blksum(ivar,ib) - av
      var5=var5 + d(ib)**2
20    continue
      if(var5 .le. zero)return
      var5=var5/nb
      gamvar=var5**2

      do 30 it=1,nb-1
      gam=zero
      do 40 ib=1,nb-it
      gam=gam + d(ib)*d(ib+it)
40    continue
      gam=gam/(nb-it)
      if( gam .le. sqrt(gamvar/(nb-it)) )goto 31
      var5=var5 + 2*gam
      gamvar=gamvar + 2*gam**2
30    continue
31    continue

      var5=(var5/nmeas)/lbl(ivar)
end function
! - - - - - - - - - - - - - - - - - - - - - - - - - -
!     compute elements of the covariance matrix
!           - sum off-diagonal gammas
!           - can violate positivity
!     better use covar5 !

function cov5(ivar,jvar)

      use stat5_data

      real(8) cov5
      real(8) var5,avi,avj,di,dj,gamij,gamji,gamii,gamjj,gamvar
      real(8) sgn,zero,one
      dimension di(nbmax),dj(nbmax)
      parameter(zero=0.,one=1.)

      if(ivar.lt.1 .or. ivar.gt.nvar) &
                  stop 'error in cov5: ivar out of range'
      if(jvar.lt.1 .or. jvar.gt.nvar) &
                  stop 'error in cov5: jvar out of range'

      if(ivar .eq. jvar)then
            cov5=var5(ivar)
            return
      endif

      cov5=zero
      nb=nbl(ivar)
      if(nb.lt.2)return
      nmeas=nb*lbl(ivar) + lnew(ivar)
      if(nmeas .ne. nbl(jvar)*lbl(jvar)+lnew(jvar) )then
            print*,'warning in cov5: mismatch of measurements'
            return
      endif

      avi=zero
      avj=zero
      do 10 ib=1,nb
      avi=avi + blksum(ivar,ib)
      avj=avj + blksum(jvar,ib)
10    continue
      avi=avi/nb
      avj=avj/nb

      gamii=zero
      gamjj=zero
      do 20 ib=1,nb
      di(ib)=blksum(ivar,ib) - avi
      dj(ib)=blksum(jvar,ib) - avj
      cov5=cov5 + di(ib)*dj(ib)
      gamii=gamii + di(ib)**2
      gamjj=gamjj + dj(ib)**2
20    continue
      cov5=cov5/nb
      sgn=sign(one,cov5)
      gamvar=gamii*gamjj/nb**2 + cov5**2

      do 30 it=1,nb-1
      gamij=zero
      gamji=zero
      gamii=zero
      gamjj=zero
      do 40 ib=1,nb-it
      gamij=gamij + di(ib+it)*dj(ib)
      gamji=gamji + dj(ib+it)*di(ib)
      gamii=gamii + di(ib)*di(ib+it)
      gamjj=gamjj + dj(ib)*dj(ib+it)
40    continue
      gamij=gamij/(nb-it)
      gamji=gamji/(nb-it)
      gamii=gamii/(nb-it)
      gamjj=gamjj/(nb-it)
      if( sgn*(gamij+gamji) .le. sqrt(2*gamvar/(nb-it)) )goto 31
      cov5=cov5 + gamij + gamji
      gamvar=gamvar + 2*(gamii*gamjj + gamij*gamji)
30    continue
31    continue

      cov5=(cov5/nmeas)/lbl(ivar)
end function
! - - - - - - - - - - - - - - - - - - - - - - - - - -
!     compute elements of the covariance matrix
!           - rescale non-diagonal elements
!                 with autocorrelation factors
!                 from the diagonal
!           - positive matrix

function covar5(ivar,jvar)

      use stat5_data

      real(8) covar5
      real(8) var5,avi,avj,di,dj,vari,varj,zero
      parameter(zero=0.)

      if(ivar.lt.1 .or. ivar.gt.nvar) &
                  stop 'error in covar5: ivar out of range'
      if(jvar.lt.1 .or. jvar.gt.nvar) &
                  stop 'error in covar5: jvar out of range'

      if(ivar .eq. jvar)then
            covar5=var5(ivar)
            return
      endif

      covar5=zero
      nb=nbl(ivar)
      if(nb.lt.2)return
      nmeas=nb*lbl(ivar) + lnew(ivar)

      if(nmeas .ne. nbl(jvar)*lbl(jvar)+lnew(jvar) )then
            print*,'warning in covar5: mismatch of measurements'
            return
      endif

      avi=zero
      avj=zero
      do 10 ib=1,nb
      avi=avi + blksum(ivar,ib)
      avj=avj + blksum(jvar,ib)
10    continue
      avi=avi/nb
      avj=avj/nb

      vari=zero
      varj=zero
      do 20 ib=1,nb
      di=blksum(ivar,ib) - avi
      dj=blksum(jvar,ib) - avj
      covar5=covar5 + di*dj
      vari=vari + di**2
      varj=varj + dj**2
20    continue
      if(vari.le.zero .or. varj.le.zero)return

      covar5=covar5 * sqrt( var5(ivar)*var5(jvar)/(vari*varj) )
end function
! - - - - - - - - - - - - - - - - - - - - - - - - - -
!     estimate integrated auto-correlations:
!           var(average) = var(single)/nmeas * rsq
!                    rsq = coth( 1/(2*tau) )
!                        = 2 * tauint

function tau5(ivar)

      use stat5_data

      real(8) tau5,rsq5,tauint5
      real(8) aver5,var5,var,rsq,zero,one,oneeps
      parameter(zero=0.,one=1.,oneeps=1.000001d0)

      if(ivar.lt.1 .or. ivar.gt.nvar) &
                  stop 'error in tau5: ivar out of range'

      tau5=zero

      nmeas=nbl(ivar)*lbl(ivar) + lnew(ivar)
      if(nmeas.lt.2) return

      var=sqsum(ivar)/nmeas - aver5(ivar)**2
      if(var.le.zero) return

      rsq=var5(ivar) / var * nmeas
      if(rsq.le.oneeps) return
      tau5=one/log( (rsq+one)/(rsq-one) )
return
! . . . . . . . . . . . . . . . . . . . . . . . . . .
entry rsq5(ivar)

      if(ivar.lt.1 .or. ivar.gt.nvar) &
                  stop 'error in rsq5: ivar out of range'

      rsq5=one

      nmeas=nbl(ivar)*lbl(ivar) + lnew(ivar)
      if(nmeas.lt.2) return

      var=sqsum(ivar)/nmeas - aver5(ivar)**2
      if(var.le.zero) return

      rsq5=var5(ivar) / var * nmeas
return
! . . . . . . . . . . . . . . . . . . . . . . . . . .
entry tauint5(ivar)

      if(ivar.lt.1 .or. ivar.gt.nvar) &
                  stop 'error in tauint5: ivar out of range'

      tauint5=.5

      nmeas=nbl(ivar)*lbl(ivar) + lnew(ivar)
      if(nmeas.lt.2) return

      var=sqsum(ivar)/nmeas - aver5(ivar)**2
      if(var.le.zero) return

      tauint5=.5 * var5(ivar) / var * nmeas
end function
! - - - - - - - - - - - - - - - - - - - - - - - - - -
!     compute jackknife blocks

!        ivar   : variable (input)
!        nb     : no. of blocks (output)
!        bj     : real(8) vector of jackknife blocks
!                 bj(ib), ib=1..nb (output)

subroutine jackout5(ivar,nb,bj)

      use stat5_data

      real(8) bj
      dimension bj(nbmax)
      real(8) bsum,zero,one
      parameter(zero=0.,one=1.)

      if(ivar.lt.1 .or. ivar.gt.nvar) &
                  stop 'error in jackout5: ivar out of range'

      nb=nbl(ivar)
      if(nb .lt. 2) stop 'error in jackout5: nb < 2'

      bsum=zero
      do 10 ib=1,nb
      bsum=bsum + blksum(ivar,ib)
10    continue

      do 20 ib=1,nb
      bj(ib)=(bsum - blksum(ivar,ib))/(lbl(ivar)*(nb-1))
20    continue
end subroutine
! - - - - - - - - - - - - - - - - - - - - - - - - - -
!     jackknife analysis for a vector of (function) values

!        nb     : number of jackknife values, nb > 1 (input)
!        fj     : real(8) vector of jackknife values,
!                 fj(ib), ib=1..nb (input)
!        aver   : function average (output)
!        sigma  : error estimate (output)

subroutine jackeval5(nb,fj,aver,sigma)

      real(8) fj,aver,sigma
      dimension fj(nb)
      real(8) bsum,d,var,gam,gamvar,zero,one
      dimension d(nb)
      parameter(zero=0.,one=1.)

      aver=zero
      sigma=zero
      if(nb.lt.2)return

      bsum=zero
      do 10 ib=1,nb
      bsum=bsum + fj(ib)
10    continue
      aver=bsum/nb

      gam=zero
      do 20 ib=1,nb
      d(ib)=fj(ib) - aver
      gam=gam + d(ib)**2
20    continue
      if(gam .le. zero)return
      gam=gam/nb

      var=gam
      gamvar=gam**2
      do 30 it=1,nb-1
      gam=zero
      do 40 ib=1,nb-it
      gam=gam + d(ib)*d(ib+it)
40    continue
      gam=gam/(nb-it)
      if( gam .le. sqrt(gamvar/(nb-it)) )goto 31
      var=var + 2*gam
      gamvar=gamvar + 2*gam**2
30    continue
31    continue

      sigma=(nb-1)*sqrt(var/nb)
end subroutine
! - - - - - - - - - - - - - - - - - - - - - - - - - -
!     jackknife evaluation - custom call

!        fct    : function of statistical variables (user-defined)
!                       function fct(nvar, a)
!                       real(8) a(nvar)
!                 with a(i), i=1..nvar : variables, as in stat5
!        aver   : function average (output)
!        sigma  : error estimate (output)

!     calls jackeval5

!     note: is is assumed that all (relevant) variables were accumulated
!           in sync, with ivar=1 as prototype.

subroutine jack5(fct,aver,sigma)

      use stat5_data

      real(8) fct,aver,sigma
      real(8) bsum,bj,fj,zero,one
      dimension bsum(nvar),bj(nvar),fj(nbmax)
      parameter(zero=0.,one=1.)
      external fct

      aver=zero
      sigma=zero
      nb=nbl(1)
      lb=lbl(1)
      if(nb.lt.2)return

      do 10 ivar=1,nvar
      bsum(ivar)=zero
      do 11 ib=1,nb
      bsum(ivar)=bsum(ivar) + blksum(ivar,ib)
11    continue
10    continue

      do 15 ib=1,nb
      do 16 ivar=1,nvar
      bj(ivar)=(bsum(ivar) - blksum(ivar,ib))/(lb*(nb-1))
16    continue
      fj(ib)=fct(nvar,bj)
15    continue

      call jackeval5(nb,fj,aver,sigma)
end subroutine
! - - - - - - - - - - - - - - - - - - - - - - - - - -
!     save and restore counters (unformatted/formatted)

subroutine save5(iunit)

      use stat5_data

      write(iunit)nvar,nbmax
      write(iunit)(nbl(i),lbl(i),lnew(i),i=1,nvar) &
            ,((blksum(i,ibl),ibl=1,nbmax),i=1,nvar) &
            ,(sqsum(i),i=1,nvar)
return

entry savef5(iunit)

      write(iunit,*)nvar,nbmax
      write(iunit,*)(nbl(i),lbl(i),lnew(i),i=1,nvar) &
            ,((blksum(i,ibl),ibl=1,nbmax),i=1,nvar) &
            ,(sqsum(i),i=1,nvar)
return

entry get5(iunit)
entry getst5(iunit)

      read(iunit)nvar1,nbmax1

      if(nvar1.lt.1)    stop 'error in get5: nvar is invalid'
      if(nbmax1.lt.2 .or. mod(nbmax1,2).ne.0) &
                        stop 'error in get5: nbmax is invalid'

      if (nvar1 /= nvar .or. nbmax1 /= nbmax) then 
         if (nvar > 0) then
            deallocate(nbl, lbl, lnew, blksum, sqsum, stat=ierror)
            if(ierror /= 0) stop 'error in get5: deallocate failed'
         endif
         allocate(nbl(nvar1), lbl(nvar1), lnew(nvar1), &
            blksum(nvar1,nbmax1), sqsum(nvar1), stat=ierror)
         if (ierror /= 0) stop 'error in get5: allocate failed'
      endif

      nvar=nvar1
      nbmax=nbmax1

      read(iunit)(nbl(i),lbl(i),lnew(i),i=1,nvar) &
            ,((blksum(i,ibl),ibl=1,nbmax),i=1,nvar) &
            ,(sqsum(i),i=1,nvar)
return

entry getf5(iunit)

      read(iunit,*)nvar1,nbmax1

      if(nvar1.lt.1)    stop 'error in getf5: nvar is invalid'
      if(nbmax1.lt.2 .or. mod(nbmax1,2).ne.0) &
                        stop 'error in getf5: nbmax is invalid'

      if (nvar1 /= nvar .or. nbmax1 /= nbmax) then 
         if (nvar > 0) then
            deallocate(nbl, lbl, lnew, blksum, sqsum, stat=ierror)
            if(ierror /= 0) stop 'error in getf5: deallocate failed'
         endif
         allocate(nbl(nvar1), lbl(nvar1), lnew(nvar1), &
            blksum(nvar1,nbmax1), sqsum(nvar1), stat=ierror)
         if (ierror /= 0) stop 'error in getf5: allocate failed'
      endif

      nvar=nvar1
      nbmax=nbmax1

      read(iunit,*)(nbl(i),lbl(i),lnew(i),i=1,nvar) &
            ,((blksum(i,ibl),ibl=1,nbmax),i=1,nvar) &
            ,(sqsum(i),i=1,nvar)
end subroutine
