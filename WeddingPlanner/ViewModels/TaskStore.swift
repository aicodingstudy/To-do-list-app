import Foundation
import UserNotifications
import SwiftUI

class TaskStore: ObservableObject {
    @Published var tasks: [Task] = [] {
        didSet { save() }
    }

    private let tasksKey = "WeddingPlannerTasks"

    init() {
        load()
        if tasks.isEmpty {
            tasks = TaskStore.defaultTasks
        }
        requestNotificationPermission()
    }

    static var defaultTasks: [Task] {
        [
            Task(title: "Book wedding venue"),
            Task(title: "Choose photographer"),
            Task(title: "Send invitations"),
            Task(title: "Order cake"),
            Task(title: "Pick wedding attire")
        ]
    }

    func add(title: String, dueDate: Date?) {
        let task = Task(title: title, dueDate: dueDate)
        tasks.append(task)
        if let due = dueDate {
            scheduleNotification(for: task, dueDate: due)
        }
    }

    func remove(at offsets: IndexSet) {
        offsets.map { tasks[$0] }.forEach(cancelNotification)
        tasks.remove(atOffsets: offsets)
    }

    func toggleCompletion(_ task: Task) {
        guard let index = tasks.firstIndex(where: { $0.id == task.id }) else { return }
        tasks[index].isCompleted.toggle()
    }

    var progress: Double {
        guard !tasks.isEmpty else { return 0 }
        let completed = tasks.filter { $0.isCompleted }.count
        return Double(completed) / Double(tasks.count)
    }

    // MARK: - Persistence

    private func save() {
        guard let data = try? JSONEncoder().encode(tasks) else { return }
        UserDefaults.standard.set(data, forKey: tasksKey)
    }

    private func load() {
        guard let data = UserDefaults.standard.data(forKey: tasksKey),
              let saved = try? JSONDecoder().decode([Task].self, from: data) else { return }
        tasks = saved
    }

    // MARK: - Notifications

    private func requestNotificationPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { _, _ in }
    }

    private func scheduleNotification(for task: Task, dueDate: Date) {
        let content = UNMutableNotificationContent()
        content.title = "Upcoming Task"
        content.body = task.title
        content.sound = .default

        let triggerDate = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: dueDate)
        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: false)
        let request = UNNotificationRequest(identifier: task.id.uuidString, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }

    private func cancelNotification(for task: Task) {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [task.id.uuidString])
    }
}
