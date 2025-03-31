//
//  RealmManager.swift
//  Hrysiuk_Lab5
//
//  Created by Анастасія Грисюк on 31.03.2025.
//

import Foundation
import RealmSwift

final class RealmManager {
    
    private let realm = try! Realm()
    
    func getTasks() -> [RealmTodoTask] {
        
        let result = realm.objects(RealmTodoTask.self).toArray(ofType: RealmTodoTask.self)
        
        return Array(result)
    }
    
    func addTask(name: String, dueDate: Date, notes: String) -> UUID? {
        let dbTask = RealmTodoTask(name: name, dueDate: dueDate, notes: notes, isDone: false)
        try! realm.write {
            realm.add(dbTask)
        }
        return dbTask.id
    }
    
    func addMockTasks() {
        let dbTask = RealmTodoTask(name: "Task 1", dueDate: Date(), notes: "notes", isDone: false)
        let dbTask2 = RealmTodoTask(name: "Task 2", dueDate: Date(), notes: "notes2", isDone: false)
        try! realm.write {
            realm.add(dbTask)
            realm.add(dbTask2)
        }
    }
    
    func deleteTask(task: RealmTodoTask) {
        try! realm.write {
            realm.delete(task)
        }
    }
    
//    func editTask(task: RealmTodoTask) {
//        try! realm.write {
//            
//        }
//    }
}

extension Results {
    func toArray<T>(ofType: T.Type) -> [T] {
        var array = [T]()
        for i in 0 ..< count {
            if let result = self[i] as? T {
                array.append(result)
            }
        }
        
        return array
    }
}
