#include <iostream>
#include <string>
#include <string_view>
#include <simdjson.h>

int main() {
    simdjson::padded_string json = simdjson::padded_string::load("test.json");
    simdjson::ondemand::parser parser;
    simdjson::ondemand::document document = parser.iterate(json);

    std::string_view content = simdjson::to_json_string(document["content"]);
    if (content != "\"I smell smoke, because I burned my cheese\"") {
        std::cout << "HERE" << std::endl;
        return 1;
    }

    std::string_view burn_level = simdjson::to_json_string(document["burn-level"]);
    if (burn_level != "100") {
        std::cout << burn_level << std::endl;
        return 1;
    }

    return 0;
}
