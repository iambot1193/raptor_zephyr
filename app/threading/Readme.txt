Threading (Multitarefa)
Esta aplicação demonstra a criação e o gerenciamento de threads independentes utilizando o escalonador do Zephyr RTOS. O foco é a execução periódica e o controle de tempo real.

O que faz:
Define uma estrutura de pilha (Stack) e prioridade para uma thread secundária.

Utiliza a macro K_THREAD_DEFINE para inicialização automática da tarefa.

Executa um loop infinito que monitora o tempo de atividade (Uptime) do sistema.

Controla o intervalo de execução utilizando k_msleep.

Por que usar Threads e k_msleep?
Multitarefa Real: Permite que o processador execute outras funções enquanto uma thread está aguardando.

Eficiência Energética: O uso de k_msleep coloca a thread em estado de espera (Wait), liberando recursos do kernel.

Determinismo: Garante que tarefas críticas tenham prioridades definidas (Priority 7) em relação a tarefas de fundo.

Configuração (prj.conf):
Para o gerenciamento de threads e logs precisos, habilitamos:

CONFIG_LOG_MODE_IMMEDIATE=y: Garante que o log seja enviado ao console no momento exato do evento, evitando atrasos de buffer.

CONFIG_QEMU_ICOUNT=y: Sincroniza o contador de instruções do simulador com o relógio do hospedeiro.

CONFIG_MINIMAL_LIBC=y: Otimiza o uso de bibliotecas C para sistemas embarcados de baixa memória.