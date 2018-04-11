import Foundation

let json = """
10
""".data(using: .utf8)!

struct User: Codable {
    let id: Int
}

let decoder = JSONDecoder()
