@echo off
setlocal

:: 1. Navega para a raiz do projeto (subindo dois níveis de app/threading)
cd /d "%~dp0"
cd ..\..

echo --- Iniciando Limpeza e Build do Threading ---

:: 2. Mata processos travados do QEMU para não dar erro de "permissão negada" no arquivo
taskkill /IM qemu-system-i386.exe /F 2>nul

:: 3. Limpa a pasta build antiga (Garante que não tenha lixo de outros projetos)
if exist build (
    echo Removendo build antigo...
    rmdir /s /q build
)

:: 4. Compila o projeto especifico de threading
:: O caminho 'app/threading' deve ser o caminho relativo a partir da raiz
echo Compilando app/threading...
call west build -b qemu_x86 app/threading
if %errorlevel% neq 0 (
    echo.
    echo [ERRO] A compilacao falhou! Verifique as mensagens acima.
    pause
    exit /b %errorlevel%
)

echo.
echo --- Iniciando o simulador QEMU ---

:: 5. Executa o QEMU com as flags de tempo real que voce ja usa
qemu-system-i386.exe -m 32 -cpu qemu32,+nx,+pae -machine q35 ^
  -device isa-debug-exit,iobase=0xf4,iosize=0x04 ^
  -no-reboot -nographic -net none -pidfile qemu.pid ^
  -chardev stdio,id=con,mux=on -serial chardev:con ^
  -mon chardev=con,mode=readline ^
  -icount shift=auto,align=off,sleep=on -rtc clock=host ^
  -kernel build/zephyr/zephyr.elf

echo.
echo -------------------------------------------------------
echo O simulador parou. Verifique as mensagens acima.
pause
endlocal