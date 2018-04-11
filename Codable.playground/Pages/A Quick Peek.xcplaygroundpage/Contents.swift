import Foundation

let json = """
{
    "name": "Pasan",
    "id": 1,
    "role": "Teacher"
}
""".data(using: .utf8)!

struct Employee {
    let name: String
    let id: Int
    let role: String
}
