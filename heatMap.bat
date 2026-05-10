@echo off
title GitHub Backdated Empty Commit Generator

echo ==========================================
echo    GitHub Backdated Contribution Maker
echo ==========================================
echo.

set /p repoPath=Enter full repository path: 
cd /d "%repoPath%"

set /p startDate=Enter start date (YYYY-MM-DD): 
set /p totalDays=Enter number of days to generate commits: 
set /p commitsPerDay=Enter commits per day: 

echo.
echo Generating commits...
echo.

for /L %%d in (0,1,%totalDays%-1) do (

    for /f %%i in ('powershell -Command "(Get-Date '%startDate%').AddDays(%%d).ToString(\"yyyy-MM-dd\")"') do (
        set currentDate=%%i

        call :makeCommits
    )
)

echo.
echo ==========================================
echo Completed Successfully!
echo ==========================================
echo.
echo Now push using:
echo git push origin test-c
pause
exit /b


:makeCommits

for /L %%c in (1,1,%commitsPerDay%) do (

    set hour=1%%c
    set minute=2%%c

    call git commit --allow-empty -m "Contribution %%c on %currentDate%" --date="%currentDate%T!hour!:!minute!:00"

)

exit /b