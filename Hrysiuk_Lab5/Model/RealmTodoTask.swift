//
//  RealmTodoTask.swift
//  Hrysiuk_Lab5
//
//  Created by Анастасія Грисюк on 31.03.2025.
//

import Foundation
import RealmSwift

final class RealmTodoTask: Object, Identifiable {
    
    @Persisted(primaryKey: true) var id = UUID()
    @Persisted var name: String
    @Persisted var dueDate: Date
    @Persisted var notes: String?
    @Persisted var isDone: Bool
    @Persisted var priority: String
    
    convenience init(name: String, dueDate: Date, notes: String?, isDone: Bool, priority: String) {
        self.init()
        
        self.name = name
        self.dueDate = dueDate
        self.notes = notes
        self.isDone = isDone
        self.priority = priority
    }
    
    convenience init(from todoTask: TodoTask) {
        self.init()
        
        self.id = todoTask.id
        self.isDone = todoTask.isDone
        self.name = todoTask.name
        self.dueDate = todoTask.dueDate
        self.notes = todoTask.notes
        self.priority = todoTask.priority.rawValue
    }
}
