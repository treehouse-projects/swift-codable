import Foundation

let json = """
{
    "name": "Pasan",
    "id": 1,
    "role": "Teacher"
}
""".data(using: .utf8)!

struct Employee: Codable {
    let name: String
    let id: Int
    let role: String
}

let decoder = JSONDecoder()

let employee = try! decoder.decode(Employee.self, from: json)
employee.name
employee.id
