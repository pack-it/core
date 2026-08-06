#include <uv.h>
#include <stdlib.h>
#include <stdio.h>

/* Timer callback */
void on_timer(uv_timer_t* timer) {
    timer->data = "Hello everything is completely fine!";

    uv_timer_stop(timer);
    uv_close((uv_handle_t*)timer, NULL);
}

int main() {
    uv_loop_t *loop = uv_default_loop();
    if (loop == NULL) {
        printf("Failed to create uv loop\n");
        return 1;
    }

    // Create timer
    uv_timer_t timer;
    uv_timer_init(loop, &timer);

    char data[] = "Hello everything is VERY WRONG";
    timer.data = &data;

    // Only wait for 1ms for quick test
    uv_timer_start(&timer, on_timer, 1, 0);
    uv_run(loop, UV_RUN_DEFAULT);

    if (strcmp(timer.data, "Hello everything is completely fine!")) {
        printf("Timer wasn't triggered");
        return 1;
    }

    uv_loop_close(loop);

    return 0;
}
