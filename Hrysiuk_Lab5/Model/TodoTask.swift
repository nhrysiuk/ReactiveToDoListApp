//
//  TodoTask.swift
//  Hrysiuk_Lab5
//
//  Created by Анастасія Грисюк on 01.04.2025.
//

import Foundation

struct TodoTask {
    
    init() {}
    
    init(from task: RealmTodoTask) {
        self.id = task.id
        self.name = task.name
        self.dueDate = task.dueDate
        self.notes = task.notes ?? ""
        self.isDone = task.isDone
    }
    
    var id = UUID()
    var name: String = ""
    var dueDate: Date = Date()
    var notes: String = ""
    var isDone: Bool = false
}
