#include <zephyr/kernel.h>
#include <zephyr/logging/log.h>

LOG_MODULE_REGISTER(raptor_app, LOG_LEVEL_INF);

int main(void)
{
    LOG_INF("Hello World! This is Raptor!");
    return 0;
}