#include <stdio.h>
#include <expat.h>

/* Start elemenent handler callback function. */
void startElementHandler(
    void *userData,
    const char *name,
    const char **atts
) {
    if (atts[0] != NULL && atts[1] != NULL) {
        printf("%s %s", atts[0], atts[1]);
    }
}

/* Character handler callback function. */
void characterDataHandler(
    void *userData,
    const char *s,
    int len
) {
    // Note that `s` is NOT NULL-terminated, so `len` has to be used
    printf("%.*s\n", len, s);
}

int main() {
    const char xml_string[] = "<str The=\"count of Numeria says \">one, two, three, four, five, the thing that comes after five. AAaahhh this happens everytimeee!!</str>";

    XML_Parser parser = XML_ParserCreate("utf-8");
    XML_SetElementHandler(parser, startElementHandler, NULL);
    XML_SetCharacterDataHandler(parser, characterDataHandler);

    // Note that it's 'size - 1', because of the NULL-termination character
    enum XML_Status status = XML_Parse(parser, xml_string, sizeof(xml_string) - 1, 1);
    if (status == XML_STATUS_ERROR) {
        enum XML_Error error = XML_GetErrorCode(parser);

        printf("XML parser returned with error status\n");
        printf("Parse error: %s\n", XML_ErrorString(error));
        printf("Line: %lu\n", XML_GetCurrentLineNumber(parser));
        printf("Column: %lu\n", XML_GetCurrentColumnNumber(parser));

        return 1;
    }

    XML_ParserFree(parser);
}
