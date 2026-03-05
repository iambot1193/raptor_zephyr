#include <zephyr/kernel.h>
#include <zephyr/logging/log.h>

LOG_MODULE_REGISTER(raptor_threads, LOG_LEVEL_INF);

#define STACK_SIZE 2048
#define PRIORITY   7
#define PERIOD_MS  5000

static void thread_raptor(void *a, void *b, void *c)
{
    ARG_UNUSED(a);
    ARG_UNUSED(b);
    ARG_UNUSED(c);

    /* Mantém periodicidade estável (sem “drift”) */
    int64_t next = k_uptime_get() + PERIOD_MS;

    while (1) {
        int64_t now = k_uptime_get();

        LOG_INF("Thread em funcionamento! uptime_ms=%lld", now);

        int64_t wait = next - now;
        next += PERIOD_MS;

        if (wait > 0) {
            k_msleep((int32_t)wait);
        } else {
            /* Atrasou (sem dormir), mas mantém o ritmo */
            k_yield();
        }
    }
}

/* Cria/inicia a thread no boot */
K_THREAD_DEFINE(raptor_tid, STACK_SIZE, thread_raptor,
                NULL, NULL, NULL,
                PRIORITY, 0, 0);

int main(void)
{
    LOG_INF("Testes com Threading!");
    return 0;
}