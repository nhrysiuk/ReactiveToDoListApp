//
//  ViewModelService.swift
//  Hrysiuk_Lab5
//
//  Created by Анастасія Грисюк on 06.04.2025.
//

import Foundation
import Combine

final class TaskManager: ObservableObject {
    
    @Published var tasks: [TodoTask] = []
    
    static let shared = TaskManager()
    
    private var bag = Set<AnyCancellable>()
    
    private init() {}
    
    func fetchTasks() {
        RealmManager.shared.getTasks()
            .map { realmTasks in
                realmTasks.map { TodoTask(from: $0) }
            }
            .sink { [weak self] tasks in
                self?.tasks = tasks
            }
            .store(in: &bag)
    }
    
    func add(task: TodoTask) {
        RealmManager.shared.addTask(name: task.name, dueDate: task.dueDate, notes: task.notes, priority: task.priority)
            .sink { [weak self] in
                self?.fetchTasks()
            }
            .store(in: &bag)
    }
    
    func update(task: TodoTask) {
        RealmManager.shared.editTask(task)
            .sink { [weak self] in
                self?.fetchTasks()
            }
            .store(in: &bag)
    }
    
    func delete(id: UUID) {
        RealmManager.shared.deleteTask(id)
            .sink { [weak self] tasks in
                self?.fetchTasks()
            }
            .store(in: &bag)
    }
}
