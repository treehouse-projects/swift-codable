import Foundation

let json = """
{
    "name": "Pasan",
    "id": 1,
    "role": "Teacher"
}
""".data(using: .utf8)!

struct Employee: Decodable {
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

extension Employee: Encodable {
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(id, forKey: .id)
        try container.encode(role, forKey: .role)
    }
}

let encoder = JSONEncoder()
let encodedEmployee = try encoder.encode(employee)

print(encodedEmployee.stringDescription)
