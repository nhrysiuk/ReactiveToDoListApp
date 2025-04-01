//
//  TodoListViewModel.swift
//  Hrysiuk_Lab5
//
//  Created by Анастасія Грисюк on 31.03.2025.
//

import Foundation
import Combine

class TodoListViewModel: ObservableObject {
    
    let addTaskSubject = PassthroughSubject<TodoTask, Never>()
    var bag = Set<AnyCancellable>()
    
    @Published var isAddViewPresented = false
    @Published private(set) var tasks: [RealmTodoTask] = []
    
    let realmManager = RealmManager()
    
    init() {
        getTasks()
        setupAddTaskSubject()
    }
    
    func setupAddTaskSubject() {
        addTaskSubject
            .sink { [weak self] task in
                self?.addTask(task: task)
            }
            .store(in: &bag)
    }
    
    func getTasks() {
        realmManager.getTasks()
            .sink { [weak self] tasks in
                self?.tasks = tasks
            }
            .store(in: &bag)
    }
    
    func addTask(task: TodoTask) {
        realmManager.addTask(name: task.name, dueDate: task.dueDate, notes: task.notes)
            .sink { [weak self] in
                self?.getTasks()
            }
            .store(in: &bag)
    }
}
