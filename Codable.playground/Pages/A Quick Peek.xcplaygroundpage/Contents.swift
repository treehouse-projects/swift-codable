import Foundation

let json = """
{
    "name": "Pasan",
    "id": 1,
    "role": "Teacher",
    "start_date": "April 2012"
}
""".data(using: .utf8)!

struct Employee: Codable {
    let name: String
    let id: Int
    let role: String
    let startDate: String
}

let decoder = JSONDecoder()
decoder.keyDecodingStrategy = .convertFromSnakeCase

let employee = try! decoder.decode(Employee.self, from: json)
employee.name
employee.id

let encoder = JSONEncoder()
encoder.keyEncodingStrategy = .convertToSnakeCase

let encodedEmployee = try encoder.encode(employee)

print(encodedEmployee.stringDescription)
