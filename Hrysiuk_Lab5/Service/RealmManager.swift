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
    
    private func getTasksNormal() -> [RealmTodoTask] {
        return realm.objects(RealmTodoTask.self).toArray(ofType: RealmTodoTask.self)
    }
    
    func getTasks() -> AnyPublisher<[RealmTodoTask], Never> {
        return Future() { [weak self] promise in
            let result = self?.realm.objects(RealmTodoTask.self).toArray(ofType: RealmTodoTask.self)
            promise(Result.success(result ?? []))
        }.eraseToAnyPublisher()
    }
    
    @discardableResult
    func addTask(name: String, dueDate: Date, notes: String) -> AnyPublisher<Void, Never> {
        return Future() { [weak self] promise in
            let dbTask = RealmTodoTask()
            dbTask.name = name
            dbTask.dueDate = dueDate
            dbTask.notes = notes
            dbTask.isDone = false
            
            try! self?.realm.write {
                self?.realm.add(dbTask)
            }
            promise(Result.success(()))
        }.eraseToAnyPublisher()
    }
    
    func deleteTask(_ task: TodoTask) -> AnyPublisher<Void, Never>  {
        return Future() { [weak self] promise in
            guard let realmTask = self?.getTasksNormal().first(where: {$0.id == task.id}) else { return }
            try! self?.realm.write {
                self?.realm.delete(realmTask)
            }
            promise(Result.success(()))
        }.eraseToAnyPublisher()
    }
    
    func editTask(_ task: TodoTask) -> AnyPublisher<Void, Never> {
        return Future() { [weak self] promise in
            let realmTask = self?.realm.objects(RealmTodoTask.self).first(where: { $0.id == task.id})
            guard let realmTask else { return }
            try! self?.realm.write {
                realmTask.name = task.name
                realmTask.isDone = task.isDone
                realmTask.dueDate = task.dueDate
                realmTask.notes = task.notes
                realmTask.priority = task.priority.rawValue
            }
            promise(Result.success(()))
        }.eraseToAnyPublisher()
    }
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
