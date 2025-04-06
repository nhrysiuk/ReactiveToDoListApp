//
//  TodoListViewModel.swift
//  Hrysiuk_Lab5
//
//  Created by Анастасія Грисюк on 31.03.2025.
//

import Foundation
import Combine

class TodoListViewModel: ObservableObject {
    
    @Published var isLoading = true
    
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
    
    private var sortType: SortType = .additionDate
    
    init() {
        TaskManager.shared.fetchTasks()
        setupTasksBinding()
        setupDeleteTaskSubject()
        DispatchQueue.main.async { [weak self] in
            self?.isLoading = false
        }
        
    }
    
    func setupTasksBinding() {
        TaskManager.shared.$tasks
            .receive(on: DispatchQueue.main)
            .map { [weak self] tasks in
                return self?.sortIfNeeded(tasks: tasks) ?? tasks
            }
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
    
    typealias AreInIncreasingOrder = (TodoTask, TodoTask) -> Bool
    
    private func sortTasks(using predicate: @escaping AreInIncreasingOrder, sortType: SortType) {
        tasks.sort(by: predicate)
        self.sortType = sortType
    }
    
    func sortByDate() {
        sortTasks(using: { $0.dueDate < $1.dueDate }, sortType: .dueDate)
    }
    
    func sortByPriority() {
        sortTasks(using: { $0.priority > $1.priority }, sortType: .priority)
    }
    
    func sortByDefault() {
        sortTasks(using: sortDefaultPredicate, sortType: .default)
    }
    
    private func sortIfNeeded(tasks: [TodoTask]) -> [TodoTask] {
        switch sortType {
        case .default:
            return tasks.sorted(by: sortDefaultPredicate)
        case .priority:
            return tasks.sorted(by: { $0.priority > $1.priority })
        case .dueDate:
            return tasks.sorted(by: { $0.dueDate < $1.dueDate })
        case .additionDate:
            return tasks 
        }
    }
    
    private var sortDefaultPredicate: AreInIncreasingOrder {
        return { lhs, rhs in
            let predicates: [AreInIncreasingOrder] = [
                { $0.isDone && !$1.isDone },
                { $0.priority > $1.priority },
                { $0.dueDate < $1.dueDate },
                { $0.name < $1.name },
            ]
            
            for predicate in predicates {
                if predicate(lhs, rhs) { return true }
                if predicate(rhs, lhs) { return false }
            }
            
            return false
        }
    }
}
