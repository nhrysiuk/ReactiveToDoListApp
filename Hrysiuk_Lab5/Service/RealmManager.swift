//
//  RealmManager.swift
//  Hrysiuk_Lab5
//
//  Created by Анастасія Грисюк on 31.03.2025.
//

import Foundation
import RealmSwift
import Combine

final class RealmManager {
    
    private let realm = try! Realm()
    
    func getTasks() -> AnyPublisher<[RealmTodoTask], Never> {
        return Future() { [weak self] promise in
            let result = self?.realm.objects(RealmTodoTask.self).toArray(ofType: RealmTodoTask.self)
            promise(Result.success(result ?? []))
        }.eraseToAnyPublisher()
    }
     
    @discardableResult
    func addTask(name: String, dueDate: Date, notes: String) -> AnyPublisher<Void, Never> {
        return Future() { [weak self] promise in
            let dbTask = RealmTodoTask(name: name, dueDate: dueDate, notes: notes, isDone: false)
            try! self?.realm.write {
                self?.realm.add(dbTask)
            }
            promise(Result.success(()))
        }.eraseToAnyPublisher()
    }
    
//    func deleteTask(task: RealmTodoTask) {
//        try! realm.write {
//            realm.delete(task)
//        }
//    }
//    
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
        
        array.reverse()
        return array
    }
}
