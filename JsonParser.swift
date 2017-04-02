class JsonParser {
    func parse(_ input: String) -> Any? {
        /* IMPLEMENT ME */
        
        let replacedString = input.replacingOccurrences(of: " ", with: "")
        if let data = replacedString.data(using: .utf8) {
            do {
                if replacedString.range(of:":") != nil{
                    return try JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary
                } else {
                    return try JSONSerialization.jsonObject(with: data, options: []) as? NSArray
                }
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
}

func main() {
    let jp = JsonParser()

    print("First Step")
    if let result = jp.parse(" [ 10, 20, 30.1 ] ") as? [Double] {
        for value in result {
            print(value)
        }
    }

    print("\nSecond Step")
    if let result = jp.parse(" [ 10 , 20, \"hello\", 30.1 ] ") as? [Any] {
        for value in result {
            print(value)
        }
    }

    print("\nThird Step")
    if let result = jp.parse("{" +
        " \"hello\": \"world\"," +
        " \"key1\": 20," +
        " \"key2\": 20.3," +
        " \"foo\": \"bar\"" +
        "}") as? [String: Any] {
        for (key, value) in result {
            print(key, value)
        }
    }

    print("\nFourth Step")
    if let result = jp.parse("{" +
        " \"hello\" : \"world\"," +
        " \"key1\" : 20, " +
        " \"key2\": 20.3, " +
        " \"foo\": {" +
        "             \"hello1\": \"world1\"," +
        "             \"key3\": [200, 300]" +
        "          }" +
        "}") as? [String: Any] {
        for (key, value) in result {
            if key == "foo", let nestedDictionary = result[key] as? [String: Any] {
                for (key2, value2) in nestedDictionary {
                    print(key2, value2)
                }
            } else {
                print(key, value)
            }
        }
    }
}

main()
