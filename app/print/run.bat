@echo off
cls
echo ==========================================
echo    RAPTOR ZEPHYR - EXECUTANDO DE /PRINT
echo ==========================================

:: 1. Configurações de Caminhos
:: Como o BAT está em /print, precisamos subir pastas para achar o QEMU ou usar o caminho fixo
set QEMU_BIN=C:\msys64\ucrt64\bin\qemu-system-i386.exe

:: O kernel .elf geralmente fica na pasta /build na raiz do projeto. 
:: "..\" serve para "subir" uma pasta no Windows.
set KERNEL_ELF=..\..\..\build\zephyr\zephyr.elf

:: 2. Comando de Compilação
echo [1/2] Compilando...
:: O "." indica que o código fonte está na pasta atual onde o BAT está
call west build -b qemu_x86 .

if %errorlevel% neq 0 (
    echo.
    echo [ERRO] A compilacao falhou.
    pause
    exit /b
)

:: 3. Comando de Execução
echo.
echo [2/2] Iniciando Simulador...
echo (Para sair: CTRL+A e depois X)
echo.

:: Se o west build funcionou, ele criou uma pasta 'build' dentro de 'print'
:: Vamos tentar rodar o que foi gerado aqui agora
%QEMU_BIN% -m 32 -cpu qemu32,+nx,+pae -machine q35 -device isa-debug-exit,iobase=0xf4,iosize=0x04 -no-reboot -nographic -net none -chardev stdio,id=con,mux=on -serial chardev:con -mon chardev=con,mode=readline -kernel build\zephyr\zephyr.elf

pause