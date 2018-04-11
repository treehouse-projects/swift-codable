import Foundation

extension Data {
    public var stringDescription: String {
        return String(data: self, encoding: .utf8)!
    }
}
