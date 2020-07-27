program for_tant
    implicit none

    integer :: i
    character (len=32) :: file

    do i = 1, iargc()
        call getarg(i, file)
        open(unit=2, file=file)
        call pull_data_from_file(2)
        close(2)
    end do

contains

subroutine pull_data_from_file(unit)
    implicit none

    integer :: unit, reason, i

    character (len=12) :: cStnid, cClouds, cUnknown, cUnknown2
    integer :: iCurYear, iCurMon, iCurDay, iCurHour, iRTime, iNewNLvls
    integer :: iLat, iLon, iElev

    i = 1

    do 
        read (unit,*,IOSTAT=reason) cStnid, iCurYear, iCurMon, iCurDay, &
                                    iCurHour, iRTime, iNewNLvls

        print *, iNewNLvls, cUnknown2
 
        if (reason < 0) then
            print *, "Finished program execution."
            exit
        else 
            call pull_records(unit, iNewNLvls)
            print *, i, "Finished looking at ", cStnid
            i = i + 1
        end if
    end do

end subroutine pull_data_from_file

subroutine pull_records(unit, iNewNLvls)
    implicit none

    integer :: unit, iNewNLvls, i

    character (len=100) :: mystring
    character (len=3), dimension(iNewNLvls) :: cLvlTypes
    integer, dimension(iNewNLvls) :: iETimes, iPressures, &
              iHeights, iTemps, iRelHums, iDewDeps, iWDirs, iWSpeeds

    !          1         2         3         4         5
    ! 123456789012345678901234567890123456789012345678901234567890
    ! 21 -9999  99500A-9999   132A-9999    70   360    15
    ! 10 -9999  92500   855A  158A-9999   170    80    93

    do i = 1, iNewNLvls
        read (unit, '(A)') mystring

        cLvlTypes(i) = mystring(1:2)
        iETimes(i) = read_substring(mystring, 4, 8)
        iPressures(i) = read_substring(mystring, 11, 15)
        iHeights(i) = read_substring(mystring, 17, 21)
        iTemps(i) = read_substring(mystring, 23, 27)
        iRelHums(i) = read_substring(mystring, 29, 33)
        iDewDeps(i) = read_substring(mystring, 34, 39)
        iWDirs(i) = read_substring(mystring, 40, 45)
        iWSpeeds(i) = read_substring(mystring, 46, 51)
    end do
end subroutine pull_records

integer function read_substring(mystring, start, end)
    implicit none

    character (len=100) :: mystring, substr
    integer :: start, end, ans

    substr = mystring(start:end)
    read (substr, *) ans
    read_substring = ans
end function read_substring

end program for_tant
