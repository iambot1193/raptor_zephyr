@echo off
setlocal

:: Navega para a pasta onde o.bat está e depois sobe dois níveis para a raiz do projeto
cd /d "%~dp0"
cd..\..

echo --- Iniciando o script de build e execucao para 'app/print' ---

:: --- 1. Matar qualquer processo QEMU antigo para liberar o zephyr.elf ---
echo Tentando matar processos QEMU antigos...
taskkill /IM qemu-system-i386.exe /F 2>nul
taskkill /IM qemu-system-x86_64.exe /F 2>nul
timeout /t 1 /nobreak >nul

:: --- 2. Limpar o build antigo (agressivamente) ---
echo Limpando a pasta build...
rmdir /s /q build >nul 2>&1
for /f "delims=" %%i in ('dir /b /s /a build\zephyr\zephyr.elf') do (
    attrib -r "%%i" >nul 2>&1
    del "%%i" >nul 2>&1
)
rmdir /s /q build >nul 2>&1

:: --- 3. Compilar o projeto 'print' ---
echo Compilando 'app/print'...
west build -b qemu_x86 app/print || (echo ERRO: Falha na compilacao. Verifique o log acima. && pause && exit /b 1)

:: --- 4. Executar o QEMU com o comando ESPECIFICO que voce forneceu ---
echo Executando o simulador QEMU com o comando especificado...

:: O caminho completo para o executavel QEMU
set "QEMU_FULL_PATH=D:\testezyphjer\raptor_zephyr\tools\msys2\mingw64\bin\qemu-system-i386.exe"
:: O caminho para o kernel compilado
set "KERNEL_ELF_PATH=build\zephyr\zephyr.elf"

:: Verificação se o arquivo zephyr.elf existe antes de tentar rodar
if not exist "%KERNEL_ELF_PATH%" (
    echo [ERRO] O arquivo %KERNEL_ELF_PATH% nao foi encontrado apos a compilacao!
    echo Certifique-se de que voce rodou 'west build' com sucesso.
    pause
    exit /b 1
)

:: Executa o QEMU com o comando exato, apontando para o binario compilado
"%QEMU_FULL_PATH%" -m 32 -cpu qemu32,+nx,+pae -machine q35 -device isa-debug-exit,iobase=0xf4,iosize=0x04 -no-reboot -nographic -net none -pidfile qemu.pid -chardev stdio,id=con,mux=on -serial chardev:con -mon chardev=con,mode=readline -icount shift=5,align=off,sleep=off -rtc clock=vm -kernel "%KERNEL_ELF_PATH%"

echo.
echo --- Simulador encerrado. ---
pause
endlocal