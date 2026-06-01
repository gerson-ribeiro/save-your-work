@echo off

set SKILLS_DIR=%USERPROFILE%\.claude\skills
set SCRIPT_DIR=%~dp0

echo Installing save-your-work skills...

if not exist "%SKILLS_DIR%" mkdir "%SKILLS_DIR%"

copy /Y "%SCRIPT_DIR%skills\saving-progress.md" "%SKILLS_DIR%\saving-progress.md" >nul
copy /Y "%SCRIPT_DIR%skills\continue-progress.md" "%SKILLS_DIR%\continue-progress.md" >nul

echo.
echo Done! Two skills installed to %SKILLS_DIR%:
echo   /saving-progress   -- start a session with automatic progress checkpoints
echo   /continue-progress -- recover a crashed session from the last checkpoint
echo.
echo Run /saving-progress at the beginning of your next development session.
