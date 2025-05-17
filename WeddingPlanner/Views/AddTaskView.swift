import SwiftUI

struct AddTaskView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var store: TaskStore

    @State private var title: String = ""
    @State private var dueDate: Date? = nil
    @State private var includeDueDate: Bool = false

    var body: some View {
        NavigationView {
            Form {
                TextField("Task Title", text: $title)

                Toggle("Add due date", isOn: $includeDueDate.animation())

                if includeDueDate {
                    DatePicker("Due Date", selection: Binding(get: {
                        dueDate ?? Date()
                    }, set: { newDate in
                        dueDate = newDate
                    }), displayedComponents: [.date, .hourAndMinute])
                }
            }
            .navigationTitle("New Task")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") { dismiss() }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Add") {
                        store.add(title: title, dueDate: includeDueDate ? dueDate : nil)
                        dismiss()
                    }
                    .buttonStyle(ThemedButtonStyle())
                    .disabled(title.trimmingCharacters(in: .whitespaces).isEmpty)
                }
            }
            .tint(.bobaGreen)
        }
    }
}

struct AddTaskView_Previews: PreviewProvider {
    static var previews: some View {
        AddTaskView(store: TaskStore())
    }
}
