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

    let deleteTaskSubject = PassthroughSubject<Int, Never>()
    
    var bag = Set<AnyCancellable>()
    
    @Published var isAddViewPresented = false
    @Published var tasks: [TodoTask] = []
        
    init() {
        TaskManager.shared.fetchTasks()
        
        setupTasksBinding()
        setupDeleteTaskSubject()
    }
    
    func setupTasksBinding() {
        TaskManager.shared.$tasks
            .receive(on: DispatchQueue.main)
            .assign(to: \.tasks, on: self)
            .store(in: &bag)
    }
    
    func setupDeleteTaskSubject() {
        deleteTaskSubject
            .sink { [weak self] index in
                let id = self?.tasks[index].id
                guard let id else { return }
                
                TaskManager.shared.delete(id: id)
            }
            .store(in: &bag)
    }
    
    //MARK: - sort functions
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
