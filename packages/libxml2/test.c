#include <stdio.h>
#include <stdlib.h>
#include <libxml/parser.h>
#include <libxml/tree.h>

int main() {
    // Open test.txt file
    FILE *file = fopen("test.xml", "rb");
    if (file == NULL) {
        printf("Test failed: failed to open test.xml\n");
        return 1;
    }

    // Get file length
    fseek(file, 0, SEEK_END);
    long file_length = ftell(file);
    rewind(file);

    // Create input buffer
    size_t input_size = (size_t)file_length;
    char *input = malloc(input_size);
    if (input == NULL) {
        printf("Test failed: failed to allocate input buffer\n");
        fclose(file);
        return 1;
    }

    // Read file into buffer
    if (fread(input, 1, input_size, file) != input_size) {
        printf("Test failed: failed to read test.txt\n");
        free(input);
        fclose(file);
        return 1;
    }
    fclose(file);

    // Parse xml
    xmlDocPtr document = xmlReadMemory(input, input_size, "test.xml", NULL, 0);
    free(input);
    if (document == NULL) {
        printf("Test failed: failed to parse test.xml\n");
        xmlFreeDoc(document);
        xmlCleanupParser();
        return 1;
    }

    // Get root element
    xmlNodePtr root = xmlDocGetRootElement(document);
    if (root == NULL) {
        printf("Test failed: failed to get root of document\n");
        xmlFreeDoc(document);
        xmlCleanupParser();
        return 1;
    }

    // Check root name
    if (xmlStrcmp(root->name, (const xmlChar *) "root") != 0) {
        printf("Test failed: name of root note is not 'root'\n");
        xmlFreeDoc(document);
        xmlCleanupParser();
        return 1;
    }

    // Get and check 'test' node
    xmlNodePtr test_node = xmlFirstElementChild(root);
    if (test_node == NULL) {
        printf("Test failed: failed to get 'test' node of document\n");
        xmlFreeDoc(document);
        xmlCleanupParser();
        return 1;
    }
    if (xmlStrcmp(test_node->name, (const xmlChar *) "test") != 0) {
        printf("Test failed: name of 'test' note is %s instead of 'test'\n", test_node->name);
        xmlFreeDoc(document);
        xmlCleanupParser();
        return 1;
    }

    // Get 'important' attribute of 'test' node
    xmlChar *important_attr = xmlGetProp(test_node, (const xmlChar *)"important");
    if (important_attr == NULL) {
        printf("Test failed: failed to get 'important' attribute of 'test' node\n");
        xmlFreeDoc(document);
        xmlCleanupParser();
        return 1;
    }
    if (xmlStrcmp(important_attr, (const xmlChar *) "yes") != 0) {
        printf("Test failed: name of 'important' attribute is %s instead of 'yes'\n", important_attr);
        xmlFreeDoc(document);
        xmlCleanupParser();
        xmlFree(important_attr);
        return 1;
    }
    xmlFree(important_attr);

    // Get and check 'important' node
    xmlNodePtr important_node = xmlNextElementSibling(test_node);
    if (important_node == NULL) {
        printf("Test failed: failed to get 'important' node of document\n");
        xmlFreeDoc(document);
        xmlCleanupParser();
        return 1;
    }
    if (xmlStrcmp(important_node->name, (const xmlChar *) "important") != 0) {
        printf("Test failed: name of 'important' note is %s instead of 'test'\n", important_node->name);
        xmlFreeDoc(document);
        xmlCleanupParser();
        return 1;
    }

    xmlFreeDoc(document);
    xmlCleanupParser();
    return 0;
}
