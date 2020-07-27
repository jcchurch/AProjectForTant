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

    integer :: unit

    character (len=12) :: cStnid, cClouds, cUnknown, cUnknown2
    integer :: iCurYear, iCurMon, iCurDay, iCurHour, iRTime, iNewNLvls
    integer :: iLat, iLon, iElev

    read (unit,*) cStnid, iCurYear, iCurMon, iCurDay, iCurHour, iRTime, iNewNLvls, cClouds, &
                  cUnknown, iLat, cUnknown2

    call pull_records(unit, iNewNLvls)

    print *, cStnid
end subroutine pull_data_from_file

subroutine pull_records(unit, iNewNLvls)
    implicit none

    integer :: unit, iNewNLvls, i, x

    character (len=60) :: mystring
    character (len=3), dimension(iNewNLvls) :: cLvlTypes
    integer, dimension(iNewNLvls) :: iETimes, iPressures, &
              iHeights, iTemps, iRelHums, iDewDeps, iWDirs, iWSpeeds

    !          1         2         3         4         5
    ! 123456789012345678901234567890123456789012345678901234567890
    ! 10 -9999  92500   855A  158A-9999   170    80    93

    do i = 1, iNewNLvls
        read (unit, '(A)') mystring

        !x = parse_substring(mystring, 4, 8)
        cLvlTypes(i) = mystring(1:2)
        !iETimes(i) = parse_substring(mystring, 4, 8)
        !iPressures(i) = parse_substring(mystring, 11, 15)
        !iHeights(i) = parse_substring(mystring, 16, 21)
        !iTemps(i) = parse_substring(mystring, 23, 27)
        !iRelHums(i) = parse_substring(mystring, 29, 33)
        !iDewDeps(i) = parse_substring(mystring, 34, 39)
        !iWDirs(i) = parse_substring(mystring, 40, 45)
        !iWSpeeds(i) = parse_substring(mystring, 46, 51)
    end do
end subroutine pull_records

integer function parse_substring(mystring, start, end)
    implicit none

    character (len=60) :: mystring, substr
    integer :: start, end, ans

    substr = mystring(start, end)
    read (substr, *) ans
    parse_substring = ans
end function parse_substring

end program for_tant
