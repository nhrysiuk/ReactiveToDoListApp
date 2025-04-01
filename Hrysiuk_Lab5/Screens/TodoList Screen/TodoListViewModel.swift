//
//  TodoListViewModel.swift
//  Hrysiuk_Lab5
//
//  Created by Анастасія Грисюк on 31.03.2025.
//

import Foundation

class TodoListViewModel: ObservableObject {
    
    @Published var isAddViewPresented = false
    @Published var tasks: [RealmTodoTask] = []

    
    let realmManager = RealmManager()
    
    func addMockTodo() {
        realmManager.addMockTasks()
        tasks = fetchTasks()
    }
    
    func fetchTasks() -> [RealmTodoTask] {
        realmManager.getTasks()
    }
}
