@echo off

set SKILLS_DIR=%USERPROFILE%\.claude\skills
set SCRIPT_DIR=%~dp0

echo Installing save-your-work skills...

if not exist "%SKILLS_DIR%" mkdir "%SKILLS_DIR%"

copy /Y "%SCRIPT_DIR%skills\checkpoint.md" "%SKILLS_DIR%\checkpoint.md" >nul
copy /Y "%SCRIPT_DIR%skills\resume.md" "%SKILLS_DIR%\resume.md" >nul

echo.
echo Done! Two skills installed to %SKILLS_DIR%:
echo   /checkpoint  -- start a session with automatic progress checkpoints
echo   /resume      -- recover a crashed session from the last checkpoint
echo.
echo Run /checkpoint at the beginning of your next development session.
