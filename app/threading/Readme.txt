# Threading (Multitarefa)

Esta aplicação demonstra a criação e o gerenciamento de threads independentes utilizando o escalonador do **Zephyr RTOS**. O foco está na execução periódica de tarefas e no controle de tempo em sistemas embarcados.

### O que faz:
- Define pilha (**stack**) e prioridade para uma thread secundária.
- Utiliza a macro `K_THREAD_DEFINE` para inicialização automática da tarefa.
- Executa um loop infinito que monitora o tempo de atividade (**uptime**) do sistema.
- Controla o intervalo de execução com `k_msleep`.

### Por que usar Threads e `k_msleep`?
1. **Multitarefa real:** permite que o processador execute outras tarefas enquanto uma thread está em espera.
2. **Eficiência no uso de recursos:** o `k_msleep` coloca a thread em estado de espera, liberando o processador para outras execuções.
3. **Controle de prioridade:** permite definir a prioridade das tarefas, ajudando no comportamento previsível do sistema.

### Como rodar:
Antes de executar a aplicação, configure no seu computador as ferramentas necessárias:
- QEMU
- West
- Zephyr
- CMake
- Python
- Git

Depois disso:
1. Crie um workspace do Zephyr.
2. Coloque este projeto dentro da pasta do workspace.
3. Acesse a pasta da aplicação correspondente.
4. Execute o arquivo `run.bat`.

Esse script será responsável por compilar e rodar a aplicação.
