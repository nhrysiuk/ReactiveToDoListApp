//
//  TodoListViewModel.swift
//  Hrysiuk_Lab5
//
//  Created by Анастасія Грисюк on 31.03.2025.
//

import Foundation
import Combine

class TodoListViewModel: ObservableObject {
    
    @Published var searchText: String = ""
    var searchResults: [TodoTask] {
           if searchText.isEmpty {
               return tasks
           } else {
               return tasks.filter { $0.name.contains(searchText) }
           }
       }
    
    let addTaskSubject = PassthroughSubject<TodoTask, Never>()
    let deleteTaskSubject = PassthroughSubject<Int, Never>()
    let editTaskSubject = PassthroughSubject<TodoTask, Never>()
    
    var bag = Set<AnyCancellable>()
    
    @Published var isAddViewPresented = false
    @Published var tasks: [TodoTask] = []
    
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
            .map { realmTasks in
                realmTasks.map { TodoTask(from: $0) }
            }
            .sink { [weak self] tasks in
                self?.tasks = tasks
            }
            .store(in: &bag)
    }
    
    func addTask(task: TodoTask) {
        realmManager.addTask(name: task.name, dueDate: task.dueDate, notes: task.notes, priority: task.priority)
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
    
    func sortByDate() {
        tasks.sort(by: { $0.dueDate < $1.dueDate })
    }
    
    func sortByPriority() {
        tasks.sort(by: { $0.priority > $1.priority })
    }
    
    typealias AreInIncreasingOrder = (TodoTask, TodoTask) -> Bool
    
    func sortByDefault() {
        tasks.sort(by: { (lhs, rhs) in
            let predicates: [AreInIncreasingOrder] = [
                { $0.isDone && !$1.isDone },
                { $0.priority > $1.priority},
                { $0.dueDate < $1.dueDate },
                { $0.name < $1.name },
            ]
            
            for predicate in predicates {
                if !predicate(lhs, rhs) && !predicate(rhs, lhs) {
                    continue
                }
                
                return predicate(lhs, rhs)
            }
            
            return false
        })
    }
}
