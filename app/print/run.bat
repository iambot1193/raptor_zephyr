@echo off
cls
echo --- Iniciando Build e Execucao: raptor_zephyr ---

:: 1. Limpa a pasta de build anterior para evitar conflitos
if exist build (
    echo Limpando pasta de build antiga...
    rmdir /s /q build
)

:: 2. Tenta compilar o projeto
echo Compilando app/print...
west build -b native_sim raptor_zephyr/app/print

:: 3. Verifica se a compilacao deu certo antes de tentar rodar
if %errorlevel% neq 0 (
    echo.
    echo [ERRO] Falha na compilacao. Verifique o log acima.
    pause
    exit /b
)

:: 4. Executa o programa
echo.
echo --- Executando Aplicativo ---
west build -t run

echo.
echo --- Processo Finalizado ---
pause
