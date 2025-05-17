import SwiftUI

struct ContentView: View {
    @StateObject private var store = TaskStore()
    @State private var showingAdd = false

    var body: some View {
        NavigationStack {
            List {
                ProgressHeaderView(store: store)
                ForEach(store.tasks) { task in
                    TaskRowView(task: task) {
                        store.toggleCompletion(task)
                    }
                }
                .onDelete(perform: store.remove)
            }
            .listRowSeparatorTint(.bobaGreen)
            .background(Color.bobaBackground)
            .navigationTitle("Wedding Tasks")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { showingAdd = true }) {
                        Image(systemName: "plus")
                    }
                    .buttonStyle(ThemedButtonStyle())
                }
            }
            .sheet(isPresented: $showingAdd) {
                AddTaskView(store: store)
            }
        }
        .preferredColorScheme(.dark)
        .tint(.bobaGreen)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
