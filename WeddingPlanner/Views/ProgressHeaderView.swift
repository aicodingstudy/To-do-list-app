import SwiftUI

struct ProgressHeaderView: View {
    @ObservedObject var store: TaskStore

    var body: some View {
        VStack(alignment: .leading) {
            Text("Progress")
                .font(.caption)
                .foregroundStyle(.secondary)
            ProgressView(value: store.progress)
                .tint(.green)
        }
        .padding(.vertical, 4)
    }
}

struct ProgressHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        ProgressHeaderView(store: TaskStore())
    }
}
