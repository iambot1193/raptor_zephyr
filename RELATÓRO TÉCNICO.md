RELATÓRIO TÉCNICO: PROJETO RAPTOR ZEPHYR
Candidato: Felipe Gonçalves Lopes
Data: 10 de Março de 2026

Projeto: Implementação de Mensagem e Multithreading em Ambiente de Virtualização

1. Objetivo
O objetivo principal deste projeto foi cumprir o desafio técnico de validar o Zephyr RTOS em ambiente virtualizado (QEMU), realizando a exibição da mensagem institucional: "Hello World! This is Raptor!".
Como um extra, implementei como funcionalidade extra um sistema de multitarefa (multithreading) com gerenciamento de tempo.

2. Ambiente de Desenvolvimento
Para a execução e validação do teste, as seguintes ferramentas foram configuradas e utilizadas:

Sistemas Operacionais: Windows 10 e Windows 11 (validação em duas estações).
IDE: Visual Studio Code.
Versionamento: GitHub.
Toolchain: Zephyr SDK 0.17.4, Python 3.12, CMake e Ninja.
Compilador Host: TDM-GCC (MinGW64).
Emulador: QEMU (Arquitetura x86).

3. Implementação Técnica
A aplicação foi desenvolvida respeitando a arquitetura do Zephyr, com as seguintes especificações:

Configuração de Kernel (prj.conf):
CONFIG_LOG=y: Ativação do subsistema de logs.
CONFIG_PRINTK=y: Habilitação de saída formatada para o console.
Funcionalidade Principal:
Implementação de saída de texto via LOG_INF para garantir a exibição da mensagem: "Hello World! This is Raptor!".

Funcionalidade Adicional (Threading):
Criação de uma thread secundária para monitoramento de sistema.
Controle de Fluxo: Implementação da API k_msleep para limitar a frequência de saída das mensagens. Isso evitou o transbordamento do console (buffer overflow) e permitiu que o sistema rodasse de forma estável, imprimindo um timestamp apenas em intervalos definidos (1 segundo), em vez de inundar o terminal a cada ciclo de processamento.

Compilação:

Comando utilizado: west build -p always -b qemu_x86 raptor_zephyr/app/print

4. Resultados Obtidos
Virtualização: O binário zephyr.elf foi gerado e executado com sucesso no QEMU.
Estabilidade: A implementação do controle de tempo nas threads garantiu que a mensagem principal e os logs de tempo coexistissem sem travar o simulador.
Gestão de Recursos: O sistema apresentou baixo consumo de memória (~98 KB de RAM), demonstrando a eficiência da arquitetura proposta.

5. Dificuldades Encontradas e Soluções
Configuração de Ambiente: A etapa inicial de instalação da toolchain e configuração de variáveis de ambiente (PATH) foi o maior desafio técnico. Solução: Mapeamento manual dos binários e configuração do ZEPHYR_BASE para garantir que o West localizasse todos os componentes nos dois PCs de teste.

Erros de Localidade e Drivers: Foram resolvidos erros de compilação relacionados à arquitetura POSIX no Windows através da migração do alvo para qemu_x86.
Incompatibilidade de Flags no QEMU: O erro invalid option -no-acpi foi contornado com a criação de um script de automação (run.bat) que executa o comando de simulação de forma personalizada para o ambiente Windows.