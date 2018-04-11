import Foundation

let json = """
{
    "work": {
        "id": 2422333,
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
        }
    }
}
""".data(using: .utf8)!

struct SearchResult {
    let id: Int
    let booksCount: Int
    let ratingsCount: Int
    let textReviewsCount: Int
}

let decoder = JSONDecoder()
decoder.keyDecodingStrategy = .convertFromSnakeCase
