@echo off
setlocal

cd /d "%~dp0"
cd ..\..

echo === Build e execucao: app/print ===

where west >nul 2>nul
if errorlevel 1 (
    echo [ERRO] O comando WEST nao foi encontrado no PATH.
    echo Verifique a instalacao do ambiente Zephyr.
    pause
    exit /b 1
)

west build -b qemu_x86 app/print -p always
if errorlevel 1 (
    echo [ERRO] Falha na compilacao.
    pause
    exit /b 1
)

if not exist "build\zephyr\zephyr.elf" (
    echo [ERRO] O arquivo build\zephyr\zephyr.elf nao foi gerado.
    pause
    exit /b 1
)

west build -t run
if errorlevel 1 (
    echo [ERRO] Falha ao executar no QEMU.
    pause
    exit /b 1
)

endlocal
