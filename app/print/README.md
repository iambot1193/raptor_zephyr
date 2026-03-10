# Print (Hello World)

Essa é a aplicação base do desafio. Ela foca na exibição da mensagem principal utilizando **Zephyr RTOS**.

### O que faz:
- Inicializa o subsistema de log do kernel.
- Exibe a mensagem: "Hello World! This is Raptor!".
- Demonstra o uso de níveis de severidade (INFO) em sistemas embarcados.

### Por que usar LOG_INF em vez de printf?
1. Maior eficiência de uso de memória.
2. Permite filtrar mensagens (Erro, Aviso, Info) sem mudar o código.
3. É Seguro para uso com múltiplas threads.

### Configuração (prj.conf):
Para este app funcionar, habilitamos no arquivo de configuração:
- `CONFIG_LOG=y`: Liga o sistema de mensagens.
- `CONFIG_PRINTK=y`: Permite o envio de strings formatadas para o console.

### Como rodar:
```bash
west build -b qemu_x86 app/print
west build -t run
