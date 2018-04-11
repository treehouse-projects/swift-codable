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
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case id = "id"
        case role = "role"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.id = try container.decode(Int.self, forKey: .id)
        self.role = try container.decode(String.self, forKey: .role)
    }
}

let decoder = JSONDecoder()

let employee = try! decoder.decode(Employee.self, from: json)
employee.name
employee.id
