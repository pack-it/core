#include <stdio.h>
#include <string.h>
#include <json-c/json.h>

int main() {
    const char json_string[] = "{\"name\": \"Gerda32\", \"Meme\": true, \"age\": 32}";

    // Parse a JSON string into a JSON object
    struct json_object *parsed = json_tokener_parse(json_string);
    if (parsed == NULL) {
        printf("Test failed: failed to parse the JSON string\n");
        return 1;
    }

    // Read a string field from the parsed object
    struct json_object *name;
    if (!json_object_object_get_ex(parsed, "name", &name)) {
        printf("Test failed: the parsed JSON object does not contain the 'name' field\n");
        json_object_put(parsed);
        return 1;
    }

    if (strcmp(json_object_get_string(name), "Gerda32") != 0) {
        printf("Test failed: the 'name' field contains '%s' instead of 'Gerda32'\n", json_object_get_string(name));
        json_object_put(parsed);
        return 1;
    }

    // Read an integer field from the parsed object
    struct json_object *age;
    if (!json_object_object_get_ex(parsed, "age", &age)) {
        printf("Test failed: the parsed JSON object does not contain the 'age' field\n");
        json_object_put(parsed);
        return 1;
    }

    if (json_object_get_int(age) != 32) {
        printf("Test failed: the 'age' field contains '%d' instead of '32'\n", json_object_get_int(age));
        json_object_put(parsed);
        return 1;
    }

    json_object_put(parsed);
    return 0;
}
