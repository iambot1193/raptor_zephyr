#include <zephyr/kernel.h>
#include <zephyr/logging/log.h>

// Registra o módulo de log para este arquivo
LOG_MODULE_REGISTER(raptor_logs, LOG_LEVEL_INF);

// Definição da pilha e prioridade da thread
#define STACK_SIZE 1024
#define PRIORITY   7

void thread_timer_entry(void *p1, void *p2, void *p3)
{
    while (1) {
        // Pega o tempo atual do sistema para mostrar no print
        int64_t uptime = k_uptime_get();
        
        LOG_INF("Thread Ativa | Uptime real: %lld ms", uptime);

        // Faz a thread dormir por 2 segundos de tempo real
        k_msleep(2000);
    }
}

// Define e inicia a thread automaticamente
K_THREAD_DEFINE(timer_thread_id, STACK_SIZE, thread_timer_entry, 
                NULL, NULL, NULL, PRIORITY, 0, 0);

int main(void)
{
    LOG_INF("Sistema Raptor OS iniciado. Monitorando a cada 2s...");
    return 0;
}