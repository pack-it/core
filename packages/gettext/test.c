#include <stdio.h>
#include <locale.h>
#include <libintl.h>

int main() {
    setlocale(LC_ALL, "");

    // Bind a missing domain
    bindtextdomain("missing", "./missing");
    textdomain("missing");

    // Try to get text, expected result is the fallback text
    printf(gettext("The translation for this text is missing, if you see this, the fallback works fine!\n"));

    return 0;
}
