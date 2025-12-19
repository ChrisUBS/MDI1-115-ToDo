//
//  TaskModels.swift
//  MDI1-114-ToDo
//
//  Created by Christian Bonilla on 09/12/25.
//

import Foundation

struct TaskItem: Identifiable, Hashable, Codable {
    var id = UUID()
    var title: String
    var isCompleted: Bool = false
}

struct TaskGroup: Identifiable, Hashable, Codable {
    var id = UUID()
    var title: String
    var symbolName: String
    var tasks: [TaskItem]
    var createdAt: Date = Date()
}

// MARK: - MOCK DATA
extension TaskGroup {
    static let sampleData: [TaskGroup] = [
        TaskGroup(
            title: "Groceries",
            symbolName: "storefront.circle.fill",
            tasks: [
                TaskItem(title: "Buy Apples"),
                TaskItem(title: "Buy Milk")
            ]
        ),
        TaskGroup(
            title: "Home",
            symbolName: "house.fill",
            tasks: [
                TaskItem(title: "Walk the dog", isCompleted: true),
                TaskItem(title: "Clean the kitchen")
            ]
        )
    ]
}
