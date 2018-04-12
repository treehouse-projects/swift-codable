import Foundation

let json = """
{
    "work": {
        "id": 2422333,
        "popularity": null,
        "sponsor": "Some Publisher, Inc.",
        "books_count": 222,
        "ratings_count": 860687,
        "text_reviews_count": 37786,
        "best_book": {
            "id": 375802,
            "title": "Ender's Game (Ender's Saga, #1)",
            "author": {
                "id": 589,
                "name": "Orson Scott Card"
            }
        },
        "candidates": [
            {
                "id": 44687,
                "title": "Enchanters' End Game (The Belgariad, #5)",
                "author": {
                    "id": 8732,
                    "name": "David Eddings"
                }
            },
            {
                "id": 22874150,
                "title": "The End Game",
                "author": {
                    "id": 6876994,
                    "name": "Kate  McCarthy"
                }
            },
            {
                "id": 7734468,
                "title": "Ender's Game: War of Gifts",
                "author": {
                    "id": 236462,
                    "name": "Jake Black"
                }
            }
        ]
    }
}
""".data(using: .utf8)!

struct SearchResult {
    let id: Int
    let booksCount: Int
    let ratingsCount: Int
    let textReviewsCount: Int
    let bestBook: Book
    let candidates: [Book]
    let popularity: Double?
    let sponsor: String?
    
    enum OuterCodingKeys: String, CodingKey {
        case work
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case booksCount
        case ratingsCount
        case textReviewsCount
        case bestBook
        case candidates
        case popularity
        case sponsor
    }
}

struct Author: Codable {
    let id: Int
    let name: String
}

struct Book: Codable {
    let id: Int
    let title: String
    let author: Author
}

extension SearchResult: Decodable {
    init(from decoder: Decoder) throws {
        let outerContainer = try decoder.container(keyedBy: OuterCodingKeys.self)
        let innerContainer = try outerContainer.nestedContainer(keyedBy: CodingKeys.self, forKey: .work)
        
        self.id = try innerContainer.decode(Int.self, forKey: .id)
        self.booksCount = try innerContainer.decode(Int.self, forKey: .booksCount)
        self.ratingsCount = try innerContainer.decode(Int.self, forKey: .ratingsCount)
        self.textReviewsCount = try innerContainer.decode(Int.self, forKey: .textReviewsCount)
        self.bestBook = try innerContainer.decode(Book.self, forKey: .bestBook)
        self.candidates = try innerContainer.decode([Book].self, forKey: .candidates)
        self.popularity = try innerContainer.decode(Double?.self, forKey: .popularity)
        self.sponsor = try innerContainer.decodeIfPresent(String.self, forKey: .sponsor)
    }
}

let decoder = JSONDecoder()
decoder.keyDecodingStrategy = .convertFromSnakeCase

let result = try! decoder.decode(SearchResult.self, from: json)
result.bestBook.title
result.bestBook.author.name
result.popularity

extension SearchResult: Encodable {
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: OuterCodingKeys.self)
        var innerContainer = container.nestedContainer(keyedBy: CodingKeys.self, forKey: .work)
        
        try innerContainer.encode(id, forKey: .id)
        try innerContainer.encode(booksCount, forKey: .booksCount)
        try innerContainer.encode(ratingsCount, forKey: .ratingsCount)
        try innerContainer.encode(textReviewsCount, forKey: .textReviewsCount)
        try innerContainer.encode(bestBook, forKey: .bestBook)
        try innerContainer.encode(candidates, forKey: .candidates)
        try innerContainer.encode(popularity, forKey: .popularity)
        try innerContainer.encodeIfPresent(sponsor, forKey: .sponsor)
    }
}

let encoder = JSONEncoder()
encoder.keyEncodingStrategy = .convertToSnakeCase
encoder.outputFormatting = .prettyPrinted

print(try! encoder.encode(result).stringDescription)

let candidatesJson = """
{
    "candidates": [
        {
            "id": 44687,
            "title": "Enchanters' End Game (The Belgariad, #5)",
            "author": {
                "id": 8732,
                "name": "David Eddings"
            }
        },
        {
            "id": 22874150,
            "title": "The End Game",
            "author": {
                "id": 6876994,
                "name": "Kate  McCarthy"
            }
        },
        {
            "id": 7734468,
            "title": "Ender's Game: War of Gifts",
            "author": {
                "id": 236462,
                "name": "Jake Black"
            }
        }
    ]
}
""".data(using: .utf8)!

let candidates = try! decoder.decode([String: [Book]].self, from: candidatesJson)
