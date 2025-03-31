//
//  RealmTodoTask.swift
//  Hrysiuk_Lab5
//
//  Created by Анастасія Грисюк on 31.03.2025.
//

import Foundation
import RealmSwift

final class RealmTodoTask: Object {
    
    @Persisted(primaryKey: true) var id = UUID()
    @Persisted var name: String
    @Persisted var dueDate: Date
    @Persisted var notes: String
    @Persisted var isDone: Bool
    
    convenience init(name: String, dueDate: Date, notes: String, isDone: Bool) {
        self.init()
        
        self.name = name
        self.dueDate = dueDate
        self.notes = notes
        self.isDone = isDone
    }
    
    
    static let mockTodo = RealmTodoTask(name: "Mock Todo", dueDate: Date(), notes: "Important!", isDone: false)
}

