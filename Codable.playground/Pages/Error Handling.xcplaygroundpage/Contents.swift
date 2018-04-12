import Foundation

let json = """
{
    "id": 10
}
""".data(using: .utf8)!

struct User: Codable {
    let id: Int
}

let decoder = JSONDecoder()

do {
    let user = try decoder.decode(User.self, from: json)
} catch let error as DecodingError {
    print(error.errorDescription)
    print(error.failureReason)
    print(error.helpAnchor)
    print(error.localizedDescription)
    print(error.recoverySuggestion)
}
