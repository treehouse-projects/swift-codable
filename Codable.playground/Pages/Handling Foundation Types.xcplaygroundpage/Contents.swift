import Foundation

let json = """
{
    "title": "Harry Potter and the sorcerer's stone",
    "url": "https:\\/\\/openlibrary.org\\/books\\/OL26331930M\\/Harry_Potter_and_the_sorcerer's_stone",
    "publish_date": "June 26, 1997",
    "text": "VGhpcyBpc24ndCByZWFsbHkgdGhlIGNvbnRlbnRzIG9mIHRoZSBib29r",
    "rating": "NaN"
    
}
""".data(using: .utf8)!

struct Book: Codable {
    let title: String
    let url: URL
    let publishDate: Date
    private let text: Data
    let rating: Double
    
    var contents: String {
        return text.stringDescription
    }
}

let decoder = JSONDecoder()
decoder.keyDecodingStrategy = .convertFromSnakeCase
//decoder.dateDecodingStrategy = .iso8601

let formatter = DateFormatter()
formatter.dateFormat = "MMMM dd, yyyy"
decoder.dateDecodingStrategy = .formatted(formatter)
decoder.dataDecodingStrategy = .base64
decoder.nonConformingFloatDecodingStrategy = .convertFromString(positiveInfinity: "+Infinity", negativeInfinity: "-Infinity", nan: "NaN")

let potter = try! decoder.decode(Book.self, from: json)

potter.title
potter.url
potter.publishDate
potter.contents
potter.rating
