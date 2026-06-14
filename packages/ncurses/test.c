#include <ncurses.h>

int main() {
    WINDOW *w = initscr();
    if(!w) {
        return 1;
    }

    printw("ncurses works, no curses are needed anymore now. Phew!");
    refresh();

    // Wait for q to exit
    int ch;
    while((ch = getch()) != 'q') {}

    endwin();
    return 0;
}
