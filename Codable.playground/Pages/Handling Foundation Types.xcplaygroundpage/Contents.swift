import Foundation

let json = """
{
    "title": "Harry Potter and the sorcerer's stone",
    "url": "https:\\/\\/openlibrary.org\\/books\\/OL26331930M\\/Harry_Potter_and_the_sorcerer's_stone",
    "publish_date": "1997-06-26T00:00:00+0000",
    "text": "VGhpcyBpc24ndCByZWFsbHkgdGhlIGNvbnRlbnRzIG9mIHRoZSBib29r",
    "rating": 4.9
    
}
""".data(using: .utf8)!

struct Book: Codable {
    let title: String
    let url: String
    let publishDate: String
}

let decoder = JSONDecoder()
decoder.keyDecodingStrategy = .convertFromSnakeCase
let potter = try! decoder.decode(Book.self, from: json)

potter.title
potter.url
potter.publishDate
