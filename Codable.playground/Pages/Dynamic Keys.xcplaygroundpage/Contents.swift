import Foundation

let json = """
{
  "languages": {
    "python": {
      "designer": [
        "Guido van Rossum"
      ],
      "released": "20 February 1991"
    },
    "java": {
      "designer": [
        "James Gosling"
      ],
      "released": "May 23, 1995"
    },
    "swift": {
      "designer": [
        "Chris Lattner",
        "Apple Inc"
      ],
      "released": "June 2, 2014"
    },
    "ruby": {
      "designer": [
        "Yukihiro Matsumoto"
      ],
      "released": "1995"
    }
  }
}
""".data(using: .utf8)!

struct Language {
    let name: String
    let designer: [String]
    let releaseDate: String
}

struct Library {
    let languages: [Language]
    
    struct LibraryCodingKeys: CodingKey {
        var stringValue: String
        
        init?(stringValue: String) {
            self.stringValue = stringValue
        }
        
        var intValue: Int? { return nil }
        init?(intValue: Int) { return nil }
        
        static let languages = LibraryCodingKeys(stringValue: "languages")!
    }
    
    enum LanguageCodingKeys: String, CodingKey {
        case designer
        case released
    }
}

let decoder = JSONDecoder()

extension Library: Decodable {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: LibraryCodingKeys.self)
        let languagesContainer = try container.nestedContainer(keyedBy: LibraryCodingKeys.self, forKey: .languages)
        
        self.languages = try languagesContainer.allKeys.map { key in
            let languageContainer = try languagesContainer.nestedContainer(keyedBy: LanguageCodingKeys.self, forKey: key)
            
            let languageName = key.stringValue
            let designer = try languageContainer.decode([String].self, forKey: .designer)
            let releaseDate = try languageContainer.decode(String.self, forKey: .released)
            
            return Language(name: languageName, designer: designer, releaseDate: releaseDate)
        }
        
    }
}

let library = try! decoder.decode(Library.self, from: json)

for language in library.languages {
    print(language.name)
}
