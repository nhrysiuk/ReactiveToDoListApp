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
    let deleteTaskSubject = PassthroughSubject<Int, Never>()
    let editTaskSubject = PassthroughSubject<TodoTask, Never>()

    var bag = Set<AnyCancellable>()
    
    @Published var isAddViewPresented = false
    @Published var tasks: [RealmTodoTask] = []
    
    let realmManager = RealmManager()
    
    init() {
        getTasks()
        setupAddTaskSubject()
        setupDeleteTaskSubject()
        setupEditTaskSubject()
    }
    
    func setupAddTaskSubject() {
        addTaskSubject
            .sink { [weak self] task in
                self?.addTask(task: task)
            }
            .store(in: &bag)
    }
    
    func setupEditTaskSubject() {
        editTaskSubject
            .sink { [weak self] task in
                self?.editTask(task: task)
            }
            .store(in: &bag)
    }
    
    func setupDeleteTaskSubject() {
        deleteTaskSubject
            .sink { [weak self] index in
                self?.deleteTask(at: index)
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
    
    func deleteTask(at index: Int) {
        let task = tasks[index]
        
        realmManager.deleteTask(task)
            .sink { [weak self] in
                self?.getTasks()
            }
            .store(in: &bag)
    }

    func editTask(task: TodoTask) {
        realmManager.editTask(task)
            .sink { [weak self] in
                self?.getTasks()
            }
            .store(in: &bag)
    }
}
