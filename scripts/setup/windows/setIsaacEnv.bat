@echo off
REM Isaac Sim root directory
set "ISAAC_BUILD_DIR=_build\windows-x86_64\release"
set "ISAACSIM_PATH=%ISAAC_SIM_DIR%\%ISAAC_BUILD_DIR%"

echo Beginning setup...

set REBUILD=0
if "%*"=="" (
    echo No arguments provided.
) else (
    for %%i in (%*) do (
        if "%%i"=="--rb" set REBUILD=1
        if "%%i"=="--rebuild" set REBUILD=1
    )
)
if %REBUILD%==1 (
    rd /s /q "%ISAACSIM_PATH%" 2>nul
    echo "Isaac Sim build directory removed."
)

if not exist "%ISAACSIM_PATH%" (
    echo Error: Isaac Sim build directory not found at %ISAACSIM_PATH%
    echo Building...
    call "%ISAAC_SIM_DIR%\build.bat"
)

REM Isaac Sim python executable
set "ISAACSIM_PYTHON_EXE=%ISAACSIM_PATH%\python.bat"

REM Create symbolic link (requires admin privileges)
if not exist "_isaac_sim" (
    mklink /D "_isaac_sim" "%ISAACSIM_PATH%"
)

REM Generate a conda environment named env_isaaclab
call isaaclab.bat --conda

REM Check if conda is available
where conda >nul 2>nul
if %ERRORLEVEL% EQU 0 (
    echo conda initialized
) else (
    echo conda uninitialized, initializing...
    call conda init --all
    echo Please restart your terminal to apply conda changes.
)

REM Activate the conda environment
call conda activate env_isaaclab

REM Install all dependencies (no apt on Windows, assuming dependencies are handled differently)
call isaaclab.bat --install
