```bat
@echo off
setlocal EnableExtensions

:: =========================================================
:: Nvidia Settings Helper
:: RTX 3060 / RTX 4070 / RTX 5070
:: =========================================================

net session >nul 2>&1
if %errorlevel% neq 0 (
    cls
    mode con: cols=100 lines=40
    echo ==========================================
    echo       ERROR: NOT RUN AS ADMINISTRATOR
    echo ==========================================
    echo.
    echo Right-click this file and choose:
    echo.
    echo "Run as administrator"
    echo.
    pause
    exit /b
)

title Nvidia Settings Helper
color 0A
mode con: cols=100 lines=40

goto menu


:: =========================================================
:: MAIN MENU
:: =========================================================

:menu
cls
mode con: cols=100 lines=40

echo ==========================================
echo        Nvidia Settings Helper
echo ==========================================
echo.
echo Detected GPU:

if defined GPU_NAME (
    echo %GPU_NAME%
) else (
    echo NVIDIA GPU not automatically detected
)

echo.
echo Active GPU profile:

if defined GPU_PROFILE (
    echo RTX %GPU_PROFILE%
) else (
    echo NONE
)

echo.
echo ==========================================
echo.
echo 1. AUTO SELECT GPU
echo 2. MANUAL SELECT GPU
echo 3. CLEAN SYSTEM (Temp + Cache)
echo 4. LOW LATENCY MODE
echo 5. FPS BOOST MODE
echo 6. EXIT
echo.
set /p choice=Select option: 

if "%choice%"=="1" goto detectgpu
if "%choice%"=="2" goto gpuselect
if "%choice%"=="3" goto clean
if "%choice%"=="4" goto latency
if "%choice%"=="5" goto fps
if "%choice%"=="6" exit /b

goto menu


:: =========================================================
:: AUTO GPU DETECTION
:: =========================================================

:detectgpu

set "GPU_NAME="
set "GPU_PROFILE="

for /f "tokens=*" %%G in ('powershell -NoProfile -Command "(Get-CimInstance Win32_VideoController | Where-Object {$_.Name -match 'NVIDIA'} | Select-Object -First 1 -ExpandProperty Name)" 2^>nul') do (
    set "GPU_NAME=%%G"
)

if /i "%GPU_NAME%"=="NVIDIA GeForce RTX 3060" set "GPU_PROFILE=3060"
if /i "%GPU_NAME%"=="NVIDIA GeForce RTX 3060 Laptop GPU" set "GPU_PROFILE=3060"

if /i "%GPU_NAME%"=="NVIDIA GeForce RTX 4070" set "GPU_PROFILE=4070"
if /i "%GPU_NAME%"=="NVIDIA GeForce RTX 4070 Laptop GPU" set "GPU_PROFILE=4070"

if /i "%GPU_NAME%"=="NVIDIA GeForce RTX 5070" set "GPU_PROFILE=5070"
if /i "%GPU_NAME%"=="NVIDIA GeForce RTX 5070 Laptop GPU" set "GPU_PROFILE=5070"

if not defined GPU_PROFILE (
    cls
    mode con: cols=100 lines=40
    echo ==========================================
    echo       GPU DETECTION FAILED
    echo ==========================================
    echo.
    echo Detected GPU:

    if defined GPU_NAME (
        echo %GPU_NAME%
    ) else (
        echo No supported NVIDIA GPU detected.
    )

    echo.
    echo Supported profiles:
    echo.
    echo RTX 3060
    echo RTX 4070
    echo RTX 5070
    echo.
    pause
    goto menu
)

if "%GPU_PROFILE%"=="3060" goto gpu3060
if "%GPU_PROFILE%"=="4070" goto gpu4070
if "%GPU_PROFILE%"=="5070" goto gpu5070

goto menu


:: =========================================================
:: MANUAL GPU SELECTION
:: =========================================================

:gpuselect

cls
mode con: cols=100 lines=40

echo ==========================================
echo          MANUAL SELECT GPU
echo ==========================================
echo.
echo Detected GPU:

if defined GPU_NAME (
    echo %GPU_NAME%
) else (
    echo Not detected yet
)

echo.
echo Choose the GPU profile:
echo.
echo 1. RTX 3060
echo 2. RTX 4070
echo 3. RTX 5070
echo 4. BACK
echo.

set /p gpuchoice=Select option: 

if "%gpuchoice%"=="1" (
    set "GPU_PROFILE=3060"
    set "GPU_NAME=NVIDIA GeForce RTX 3060"
    goto gpu3060
)

if "%gpuchoice%"=="2" (
    set "GPU_PROFILE=4070"
    set "GPU_NAME=NVIDIA GeForce RTX 4070"
    goto gpu4070
)

if "%gpuchoice%"=="3" (
    set "GPU_PROFILE=5070"
    set "GPU_NAME=NVIDIA GeForce RTX 5070"
    goto gpu5070
)

if "%gpuchoice%"=="4" goto menu

goto gpuselect


:: =========================================================
:: OPEN SETTINGS
:: =========================================================

:opensettings

echo.
echo Opening Windows Advanced Display...
start "" ms-settings:display-advanced

timeout /t 1 /nobreak >nul

echo Opening NVIDIA Control Panel...

if exist "%ProgramFiles%\NVIDIA Corporation\Control Panel Client\nvcplui.exe" (
    start "" "%ProgramFiles%\NVIDIA Corporation\Control Panel Client\nvcplui.exe"
) else (
    start "" control.exe /name NVIDIA.ControlPanel
)

timeout /t 1 /nobreak >nul

echo Opening NVIDIA App...

if exist "%ProgramFiles%\NVIDIA Corporation\NVIDIA App\NVIDIA App.exe" (
    start "" "%ProgramFiles%\NVIDIA Corporation\NVIDIA App\NVIDIA App.exe"
)

if exist "%ProgramFiles%\NVIDIA Corporation\NVIDIA app\CEF\NVIDIA App.exe" (
    start "" "%ProgramFiles%\NVIDIA Corporation\NVIDIA app\CEF\NVIDIA App.exe"
)

timeout /t 2 /nobreak >nul

goto :eof


:: =========================================================
:: GPU PROFILE ENTRY
:: =========================================================

:gpu3060
call :opensettings
goto guide3060

:gpu4070
call :opensettings
goto guide4070

:gpu5070
call :opensettings
goto guide5070


:: =========================================================
:: RTX 3060 - PAGE 1
:: =========================================================

:guide3060

cls
mode con: cols=100 lines=40

echo ==========================================
echo      GPU SETTINGS GUIDE - RTX 3060
echo ==========================================
echo.
echo DISPLAY:
echo - Go to Advanced Display
echo - Select your monitor
echo - Under "Choose a refresh rate"
echo - Set the HIGHEST available Hz
echo - When done, close the Display Window
echo.
echo NVIDIA PERFORMANCE:
echo - Go to NVIDIA App
echo - System tab ^> Performance
echo - Voltage: MAX %%
echo - Power: MAX %%
echo.
echo NVIDIA SETTINGS:
echo - Go to Graphics tab
echo - Select Global Settings
echo.
choice /c N /n /m "Press N for the next page..."
goto guide3060p2


:: =========================================================
:: RTX 3060 - PAGE 2
:: =========================================================

:guide3060p2

cls
mode con: cols=100 lines=40

echo ==========================================
echo      RTX 3060 SETTINGS - PAGE 2
echo ==========================================
echo.
echo DLSS OVERRIDE - MODEL PRESETS:
echo - Press the Pencil icon
echo - Choose the Custom TAB
echo - Frame Generation: NOT AVAILABLE
echo - Super Resolution: K
echo - Ray Reconstruction: F
echo.
echo DLSS OVERRIDE - FRAME GENERATION MODE:
echo - Use 3D Application Setting
echo.
echo DLSS OVERRIDE - SUPER RESOLUTION MODE:
echo - Quality
echo - 67%%
echo.
echo SMOOTH MOTION:
echo - OFF
echo.
echo LOW LATENCY:
echo - ON
echo.
echo CUDA SYSTEM FALLBACK:
echo - Prefer no fallback
echo.
echo DSR - FACTORS:
echo - Factors: 2.00x
echo - Smoothness: 33%%
echo.
echo GPU APP ASSIGNMENT:
echo - RTX 3060
echo.
choice /c N /n /m "Press N for the next page..."
goto guide3060p3


:: =========================================================
:: RTX 3060 - PAGE 3
:: =========================================================

:guide3060p3

cls
mode con: cols=100 lines=40

echo ==========================================
echo      RTX 3060 SETTINGS - PAGE 3
echo ==========================================
echo.
echo IMAGE SCALING:
echo - OFF
echo - Sharpen: 50%%
echo - Render Resolution: 77%%
echo.
echo MAX FRAME RATE:
echo - 165 FPS
echo.
echo MONITOR TECHNOLOGY:
echo - G-SYNC Compatible
echo.
echo OPENGL GDI COMPATIBILITY:
echo - Auto
echo.
echo POWER MANAGEMENT MODE:
echo - Prefer maximum performance
echo.
echo RTX DYNAMIC VIBRANCE:
echo - ON
echo.
echo RTX HDR:
echo - OFF
echo.
choice /c N /n /m "Press N for the next page..."
goto guide3060p4


:: =========================================================
:: RTX 3060 - PAGE 4
:: =========================================================

:guide3060p4

cls
mode con: cols=100 lines=40

echo ==========================================
echo      RTX 3060 SETTINGS - PAGE 4
echo ==========================================
echo.
echo SHADER CACHE:
echo - ON
echo - 10 GB recommended
echo.
echo VERTICAL SYNC:
echo - OFF
echo.
echo VIRTUAL REALITY - VARIABLE RATE SUPER SAMPLING:
echo - OFF for normal monitor gaming
echo - ON if VR glasses/headset are available and being used
echo.
echo VULKAN / OPENGL PRESENT METHOD:
echo - Prefer layered on DXGI Swapchain
echo.
echo LEGACY SETTINGS:
echo - Enable
echo.
choice /c N /n /m "Press N for the next page..."
goto guide3060p5


:: =========================================================
:: RTX 3060 - PAGE 5
:: =========================================================

:guide3060p5

cls
mode con: cols=100 lines=40

echo ==========================================
echo      RTX 3060 SETTINGS - PAGE 5
echo ==========================================
echo.
echo ANISOTROPIC FILTERING:
echo - 16x
echo.
echo ANTIALIASING - FXAA:
echo - ON
echo.
echo ANTIALIASING - TRANSPARENCY:
echo - 8x
echo.
echo BACKGROUND APPLICATION MAX FRAME RATE:
echo - OFF
echo.
echo MULTI-FRAME SAMPLED AA (MFAA):
echo - ON
echo.
echo PHYSX:
echo - Auto
echo.
choice /c N /n /m "Press N for the next page..."
goto guide3060p6


:: =========================================================
:: RTX 3060 - PAGE 6
:: =========================================================

:guide3060p6

cls
mode con: cols=100 lines=40

echo ==========================================
echo      RTX 3060 SETTINGS - PAGE 6
echo ==========================================
echo.
echo TEXTURE FILTERING - ANISOTROPIC SAMPLE OPTIMIZATION:
echo - ON
echo.
echo TEXTURE FILTERING - NEGATIVE LOD BIAS:
echo - Clamp
echo.
echo TEXTURE FILTERING - QUALITY:
echo - High Performance
echo.
echo TEXTURE FILTERING - TRILINEAR OPTIMIZATION:
echo - ON
echo.
echo RESIZABLE BAR:
echo - CHECK STATUS IN THE PROGRAM SETTINGS
echo.
choice /c N /n /m "Press N for the next page..."
goto guide3060p7


:: =========================================================
:: RTX 3060 - PAGE 7
:: =========================================================

:guide3060p7

cls
mode con: cols=100 lines=40

echo ==========================================
echo      RTX 3060 SETTINGS - PAGE 7
echo ==========================================
echo.
echo COLOR SETTINGS:
echo - Go to System tab ^> Display
echo - Scroll down to Display settings
echo - Select Display 1
echo - Scroll down to Color
echo - Choose NVIDIA color settings
echo - Output color format: RGB
echo - Output dynamic range: Full
echo - Color Accuracy Mode
echo - Override to Reference Mode
echo - Repeat for your other monitor
echo.
echo AUTO TUNING:
echo - System tab ^> Performance
echo - Click the Green slider to activate Enable Automatic Tuning
echo - Takes approximately 30-45 minutes
echo - Do not use your PC during tuning
echo.
choice /c N /n /m "Press N for the final page..."
goto guide3060final


:: =========================================================
:: RTX 3060 - FINAL
:: =========================================================

:guide3060final

cls
mode con: cols=100 lines=40

echo ==========================================
echo      RTX 3060 SETTINGS - FINAL
echo ==========================================
echo.
echo AUTO TUNING:
echo - Let Automatic Tuning finish completely.
echo - Do not use the PC while tuning.
echo.
echo NOTE:
echo - When Automatic Tuning is finished,
echo   you can close all NVIDIA windows.
echo.
echo ==========================================
echo        RTX 3060 GUIDE COMPLETE
echo ==========================================
echo.
pause
goto menu


:: =========================================================
:: RTX 4070 - PAGE 1
:: =========================================================

:guide4070

cls
mode con: cols=100 lines=40

echo ==========================================
echo      GPU SETTINGS GUIDE - RTX 4070
echo ==========================================
echo.
echo DISPLAY:
echo - Go to Advanced Display
echo - Select your monitor
echo - Under "Choose a refresh rate"
echo - Set the HIGHEST available Hz
echo - When done, close the Display Window
echo.
echo NVIDIA PERFORMANCE:
echo - Go to NVIDIA App
echo - System tab ^> Performance
echo - Voltage: MAX %%
echo - Power: MAX %%
echo.
echo NVIDIA SETTINGS:
echo - Go to Graphics tab
echo - Select Global Settings
echo.
choice /c N /n /m "Press N for the next page..."
goto guide4070p2


:: =========================================================
:: RTX 4070 - PAGE 2
:: =========================================================

:guide4070p2

cls
mode con: cols=100 lines=40

echo ==========================================
echo      RTX 4070 SETTINGS - PAGE 2
echo ==========================================
echo.
echo DLSS OVERRIDE - MODEL PRESETS:
echo - Press the Pencil icon
echo - Choose the Custom TAB
echo - Frame Generation: B
echo - Super Resolution: M
echo - Ray Reconstruction: F
echo.
echo DLSS OVERRIDE - FRAME GENERATION MODE:
echo - Fixed
echo - Multiplier: 2X
echo.
echo DLSS OVERRIDE - SUPER RESOLUTION MODE:
echo - Quality
echo - 67%%
echo.
echo SMOOTH MOTION:
echo - ON
echo.
echo LOW LATENCY:
echo - ON
echo.
echo CUDA SYSTEM FALLBACK:
echo - Prefer no fallback
echo.
echo DSR - FACTORS:
echo - Factors: 2.00x
echo - Smoothness: 33%%
echo.
echo GPU APP ASSIGNMENT:
echo - RTX 4070
echo.
choice /c N /n /m "Press N for the next page..."
goto guide4070p3


:: =========================================================
:: RTX 4070 - PAGE 3
:: =========================================================

:guide4070p3

cls
mode con: cols=100 lines=40

echo ==========================================
echo      RTX 4070 SETTINGS - PAGE 3
echo ==========================================
echo.
echo IMAGE SCALING:
echo - OFF
echo - Sharpen: 50%%
echo - Render Resolution: 77%%
echo.
echo MAX FRAME RATE:
echo - 165 FPS
echo.
echo MONITOR TECHNOLOGY:
echo - G-SYNC Compatible
echo.
echo OPENGL GDI COMPATIBILITY:
echo - Auto
echo.
echo POWER MANAGEMENT MODE:
echo - Prefer maximum performance
echo.
echo RTX DYNAMIC VIBRANCE:
echo - ON
echo.
echo RTX HDR:
echo - OFF
echo.
choice /c N /n /m "Press N for the next page..."
goto guide4070p4


:: =========================================================
:: RTX 4070 - PAGE 4
:: =========================================================

:guide4070p4

cls
mode con: cols=100 lines=40

echo ==========================================
echo      RTX 4070 SETTINGS - PAGE 4
echo ==========================================
echo.
echo SHADER CACHE:
echo - ON
echo - 10 GB recommended
echo.
echo VERTICAL SYNC:
echo - OFF
echo.
echo VIRTUAL REALITY - VARIABLE RATE SUPER SAMPLING:
echo - OFF for normal monitor gaming
echo - ON if VR glasses/headset are available and being used
echo.
echo VULKAN / OPENGL PRESENT METHOD:
echo - Prefer layered on DXGI Swapchain
echo.
echo LEGACY SETTINGS:
echo - Enable
echo.
choice /c N /n /m "Press N for the next page..."
goto guide4070p5


:: =========================================================
:: RTX 4070 - PAGE 5
:: =========================================================

:guide4070p5

cls
mode con: cols=100 lines=40

echo ==========================================
echo      RTX 4070 SETTINGS - PAGE 5
echo ==========================================
echo.
echo ANISOTROPIC FILTERING:
echo - 16x
echo.
echo ANTIALIASING - FXAA:
echo - ON
echo.
echo ANTIALIASING - TRANSPARENCY:
echo - 8x
echo.
echo BACKGROUND APPLICATION MAX FRAME RATE:
echo - OFF
echo.
echo MULTI-FRAME SAMPLED AA (MFAA):
echo - ON
echo.
echo PHYSX:
echo - Auto
echo.
choice /c N /n /m "Press N for the next page..."
goto guide4070p6


:: =========================================================
:: RTX 4070 - PAGE 6
:: =========================================================

:guide4070p6

cls
mode con: cols=100 lines=40

echo ==========================================
echo      RTX 4070 SETTINGS - PAGE 6
echo ==========================================
echo.
echo TEXTURE FILTERING - ANISOTROPIC SAMPLE OPTIMIZATION:
echo - ON
echo.
echo TEXTURE FILTERING - NEGATIVE LOD BIAS:
echo - Clamp
echo.
echo TEXTURE FILTERING - QUALITY:
echo - High Performance
echo.
echo TEXTURE FILTERING - TRILINEAR OPTIMIZATION:
echo - ON
echo.
echo RESIZABLE BAR:
echo - CHECK STATUS IN THE PROGRAM SETTINGS
echo.
choice /c N /n /m "Press N for the next page..."
goto guide4070p7


:: =========================================================
:: RTX 4070 - PAGE 7
:: =========================================================

:guide4070p7

cls
mode con: cols=100 lines=40

echo ==========================================
echo      RTX 4070 SETTINGS - PAGE 7
echo ==========================================
echo.
echo COLOR SETTINGS:
echo - Go to System tab ^> Display
echo - Scroll down to Display settings
echo - Select Display 1
echo - Scroll down to Color
echo - Choose NVIDIA color settings
echo - Output color format: RGB
echo - Output dynamic range: Full
echo - Color Accuracy Mode
echo - Override to Reference Mode
echo - Repeat for your other monitor
echo.
echo AUTO TUNING:
echo - System tab ^> Performance
echo - Click the Green slider to activate Enable Automatic Tuning
echo - Takes approximately 30-45 minutes
echo - Do not use your PC during tuning
echo.
choice /c N /n /m "Press N for the final page..."
goto guide4070final


:: =========================================================
:: RTX 4070 - FINAL
:: =========================================================

:guide4070final

cls
mode con: cols=100 lines=40

echo ==========================================
echo      RTX 4070 SETTINGS - FINAL
echo ==========================================
echo.
echo AUTO TUNING:
echo - Let Automatic Tuning finish completely.
echo - Do not use the PC while tuning.
echo.
echo NOTE:
echo - When Automatic Tuning is finished,
echo   you can close all NVIDIA windows.
echo.
echo ==========================================
echo        RTX 4070 GUIDE COMPLETE
echo ==========================================
echo.
pause
goto menu


:: =========================================================
:: RTX 5070 - PAGE 1
:: =========================================================

:guide5070

cls
mode con: cols=100 lines=40

echo ==========================================
echo      GPU SETTINGS GUIDE - RTX 5070
echo ==========================================
echo.
echo DISPLAY:
echo - Go to Advanced Display
echo - Select your monitor
echo - Under "Choose a refresh rate"
echo - Set the HIGHEST available Hz
echo - When done, close the Display Window
echo.
echo NVIDIA PERFORMANCE:
echo - Go to NVIDIA App
echo - System tab ^> Performance
echo - Voltage: MAX %%
echo - Power: MAX %%
echo.
echo NVIDIA SETTINGS:
echo - Go to Graphics tab
echo - Select Global Settings
echo.
choice /c N /n /m "Press N for the next page..."
goto guide5070p2


:: =========================================================
:: RTX 5070 - PAGE 2
:: =========================================================

:guide5070p2

cls
mode con: cols=100 lines=40

echo ==========================================
echo      RTX 5070 SETTINGS - PAGE 2
echo ==========================================
echo.
echo DLSS OVERRIDE - MODEL PRESETS:
echo - Press the Pencil icon
echo - Choose the Custom TAB
echo - Frame Generation: B
echo - Super Resolution: M
echo - Ray Reconstruction: F
echo.
echo DLSS OVERRIDE - FRAME GENERATION MODE:
echo - Dynamic
echo - Target FPS: Max Refresh Rate
echo - Multiplier: Up to 6X
echo.
echo DLSS OVERRIDE - SUPER RESOLUTION MODE:
echo - Ultra Performance
echo - 33%%
echo.
echo SMOOTH MOTION:
echo - OFF
echo.
echo LOW LATENCY:
echo - ON
echo.
echo CUDA SYSTEM FALLBACK:
echo - Prefer no fallback
echo.
echo DSR - FACTORS:
echo - Factors: 1.78x
echo - Smoothness: 33%%
echo.
echo GPU APP ASSIGNMENT:
echo - RTX 5070
echo.
choice /c N /n /m "Press N for the next page..."
goto guide5070p3


:: =========================================================
:: RTX 5070 - PAGE 3
:: =========================================================

:guide5070p3

cls
mode con: cols=100 lines=40

echo ==========================================
echo      RTX 5070 SETTINGS - PAGE 3
echo ==========================================
echo.
echo IMAGE SCALING:
echo - ON
echo - Render Resolution: 77%%
echo - Resolution: 1969 x 1108
echo - Sharpen: 85%%
echo.
echo MAX FRAME RATE:
echo - 165 FPS
echo.
echo MONITOR TECHNOLOGY:
echo - G-SYNC Compatible
echo.
echo OPENGL GDI COMPATIBILITY:
echo - Auto
echo.
echo POWER MANAGEMENT MODE:
echo - Prefer maximum performance
echo.
echo RTX DYNAMIC VIBRANCE:
echo - ON
echo.
echo RTX HDR:
echo - OFF
echo.
choice /c N /n /m "Press N for the next page..."
goto guide5070p4


:: =========================================================
:: RTX 5070 - PAGE 4
:: =========================================================

:guide5070p4

cls
mode con: cols=100 lines=40

echo ==========================================
echo      RTX 5070 SETTINGS - PAGE 4
echo ==========================================
echo.
echo SHADER CACHE:
echo - ON
echo - 10 GB recommended
echo.
echo VERTICAL SYNC:
echo - OFF
echo.
echo VIRTUAL REALITY - VARIABLE RATE SUPER SAMPLING:
echo - OFF for normal monitor gaming
echo - ON if VR glasses/headset are available and being used
echo.
echo VULKAN / OPENGL PRESENT METHOD:
echo - Prefer layered on DXGI Swapchain
echo.
echo LEGACY SETTINGS:
echo - Enable
echo.
choice /c N /n /m "Press N for the next page..."
goto guide5070p5


:: =========================================================
:: RTX 5070 - PAGE 5
:: =========================================================

:guide5070p5

cls
mode con: cols=100 lines=40

echo ==========================================
echo      RTX 5070 SETTINGS - PAGE 5
echo ==========================================
echo.
echo ANISOTROPIC FILTERING:
echo - 16x
echo.
echo ANTIALIASING - FXAA:
echo - ON
echo.
echo ANTIALIASING - TRANSPARENCY:
echo - 8x
echo.
echo BACKGROUND APPLICATION MAX FRAME RATE:
echo - OFF
echo.
echo MULTI-FRAME SAMPLED AA (MFAA):
echo - ON
echo.
echo PHYSX:
echo - Auto
echo.
choice /c N /n /m "Press N for the next page..."
goto guide5070p6


:: =========================================================
:: RTX 5070 - PAGE 6
:: =========================================================

:guide5070p6

cls
mode con: cols=100 lines=40

echo ==========================================
echo      RTX 5070 SETTINGS - PAGE 6
echo ==========================================
echo.
echo TEXTURE FILTERING - ANISOTROPIC SAMPLE OPTIMIZATION:
echo - ON
echo.
echo TEXTURE FILTERING - NEGATIVE LOD BIAS:
echo - Clamp
echo.
echo TEXTURE FILTERING - QUALITY:
echo - High Performance
echo.
echo TEXTURE FILTERING - TRILINEAR OPTIMIZATION:
echo - ON
echo.
echo RESIZABLE BAR:
echo - CHECK STATUS IN THE PROGRAM SETTINGS
echo.
choice /c N /n /m "Press N for the next page..."
goto guide5070p7


:: =========================================================
:: RTX 5070 - PAGE 7
:: =========================================================

:guide5070p7

cls
mode con: cols=100 lines=40

echo ==========================================
echo      RTX 5070 SETTINGS - PAGE 7
echo ==========================================
echo.
echo COLOR SETTINGS:
echo - Go to System tab ^> Display
echo - Scroll down to Display settings
echo - Select Display 1
echo - Scroll down to Color
echo - Choose NVIDIA color settings
echo - Output color format: RGB
echo - Output dynamic range: Full
echo - Color Accuracy Mode
echo - Override to Reference Mode
echo - Repeat for your other monitor
echo.
echo AUTO TUNING:
echo - System tab ^> Performance
echo - Click the Green slider to activate Enable Automatic Tuning
echo - Takes approximately 30-45 minutes
echo - Do not use your PC during tuning
echo.
choice /c N /n /m "Press N for the final page..."
goto guide5070final


:: =========================================================
:: RTX 5070 - FINAL
:: =========================================================

:guide5070final

cls
mode con: cols=100 lines=40

echo ==========================================
echo      RTX 5070 SETTINGS - FINAL
echo ==========================================
echo.
echo AUTO TUNING:
echo - Let Automatic Tuning finish completely.
echo - Do not use the PC while tuning.
echo.
echo NOTE:
echo - When Automatic Tuning is finished,
echo   you can close all NVIDIA windows.
echo.
echo ==========================================
echo        RTX 5070 GUIDE COMPLETE
echo ==========================================
echo.
pause
goto menu


:: =========================================================
:: CLEAN SYSTEM
:: =========================================================

:clean

cls
mode con: cols=100 lines=40

echo ==========================================
echo           SYSTEM CLEAN
echo ==========================================
echo.

echo Clearing user temporary files...
del /q /f /s "%temp%\*" >nul 2>&1

echo.
echo Clearing Windows temporary files...
del /q /f /s "C:\Windows\Temp\*" >nul 2>&1

echo.
echo Flushing DNS...
ipconfig /flushdns >nul

echo.
echo ==========================================
echo          SYSTEM CLEANED
echo ==========================================
echo.

pause
goto menu


:: =========================================================
:: LOW LATENCY MODE
:: =========================================================

:latency

cls
mode con: cols=100 lines=40

echo ==========================================
echo          LOW LATENCY MODE
echo ==========================================
echo.

echo Flushing DNS...
ipconfig /flushdns >nul

echo.
echo Resetting network configuration...
netsh int ip reset >nul

echo.
echo Resetting Winsock...
netsh winsock reset >nul

echo.
echo ==========================================
echo          LATENCY OPTIMIZED
echo ==========================================
echo.
echo Restart the PC for the network reset
echo to take full effect.
echo.

pause
goto menu


:: =========================================================
:: FPS BOOST MODE
:: =========================================================

:fps

cls
mode con: cols=100 lines=40

echo ==========================================
echo          FPS BOOST MODE
echo ==========================================
echo.

echo Closing background apps...

taskkill /F /IM OneDrive.exe >nul 2>&1
taskkill /F /IM Teams.exe >nul 2>&1
taskkill /F /IM Discord.exe >nul 2>&1
taskkill /F /IM XboxApp.exe >nul 2>&1

echo.
echo Setting High Performance power mode...

powercfg -setactive SCHEME_MIN

echo.
echo Clearing temporary files...

del /q /f /s "%temp%\*" >nul 2>&1

echo.
echo ==========================================
echo          FPS BOOST ACTIVE
echo ==========================================
echo.

pause
goto menu
```
