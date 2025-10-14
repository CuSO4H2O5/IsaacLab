@echo off
REM Set proxy settings
@REM set "http_proxy=http://10.101.10.6:7890"
@REM set "https_proxy=http://10.101.10.6:7890"

REM Isaac Sim root directory
set "ISAAC_LIB_DIR=%CD%"
set "ISAAC_SIM_DIR=%ISAAC_LIB_DIR%\IsaacSim"

REM Call the Windows setup script
call "%~dp0scripts\setup\windows\setIsaacEnv.bat"
