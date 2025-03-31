//
//  TodoListViewModel.swift
//  Hrysiuk_Lab5
//
//  Created by Анастасія Грисюк on 31.03.2025.
//

import Foundation

class TodoListViewModel: ObservableObject {
    
    @Published var isModalPresented = false
    
    let realmManager = RealmManager()
    
    func addMockTodo() {
        realmManager.addMockTasks()
    }
    
    func fetchTasks() -> [RealmTodoTask] {
        realmManager.getTasks()
    }
}
