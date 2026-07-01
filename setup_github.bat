@echo off
echo ========================================
echo CloudOps Sentinel - GitHub Setup
echo ========================================
echo.

cd /d "%~dp0"

echo Running backdated commit script...
powershell -ExecutionPolicy Bypass -File backdate_commits.ps1

if %ERRORLEVEL% NEQ 0 (
    echo.
    echo Error occurred during commit creation!
    pause
    exit /b 1
)

echo.
echo ========================================
echo Ready to push to GitHub!
echo ========================================
echo.

set /p PROCEED="Do you want to add remote and push now? (y/n): "

if /i "%PROCEED%"=="y" (
    echo.
    echo Adding GitHub remote...
    git remote add origin https://github.com/Krushna-a/CloudOps-Sentinel-Copilot.git
    
    echo.
    echo Pushing to GitHub...
    git push -u origin main --force
    
    if %ERRORLEVEL% EQU 0 (
        echo.
        echo ========================================
        echo Success! Your code is now on GitHub!
        echo July 2026 will show green on your contribution graph.
        echo ========================================
    ) else (
        echo.
        echo Push failed. You may need to:
        echo 1. Check your GitHub authentication
        echo 2. Verify the repository exists
        echo 3. Use: git push -u origin main --force
    )
) else (
    echo.
    echo Skipped push. Run these commands manually:
    echo   git remote add origin https://github.com/Krushna-a/CloudOps-Sentinel-Copilot.git
    echo   git push -u origin main --force
)

echo.
pause
