import SwiftUI

struct TaskRowView: View {
    var task: Task
    var toggle: () -> Void

    private var dueDateText: String? {
        if let due = task.dueDate {
            let formatter = DateFormatter()
            formatter.dateStyle = .short
            formatter.timeStyle = .short
            return formatter.string(from: due)
        }
        return nil
    }

    var body: some View {
        HStack {
            Button(action: toggle) {
                Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "circle")
                    .foregroundStyle(task.isCompleted ? .green : .gray)
            }
            .buttonStyle(.plain)

            VStack(alignment: .leading) {
                Text(task.title)
                    .strikethrough(task.isCompleted)
                if let due = dueDateText {
                    Text(due)
                        .font(.caption2)
                        .foregroundStyle(.secondary)
                }
            }
        }
    }
}

struct TaskRowView_Previews: PreviewProvider {
    static var previews: some View {
        TaskRowView(task: Task(title: "Test", dueDate: Date()), toggle: {})
    }
}
