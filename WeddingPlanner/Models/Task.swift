import Foundation

struct Task: Identifiable, Codable {
    let id: UUID
    var title: String
    var dueDate: Date?
    var isCompleted: Bool

    init(id: UUID = UUID(), title: String, dueDate: Date? = nil, isCompleted: Bool = false) {
        self.id = id
        self.title = title
        self.dueDate = dueDate
        self.isCompleted = isCompleted
    }
}
