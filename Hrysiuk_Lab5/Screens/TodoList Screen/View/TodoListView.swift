//
//  TodoListView.swift
//  Hrysiuk_Lab5
//
//  Created by Анастасія Грисюк on 31.03.2025.
//

import SwiftUI

struct TodoListView: View {
    
    @StateObject var viewModel = TodoListViewModel()
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.tasks, id: \.self) { task in
                    NavigationLink(value: task) {
                        TodoListCellView(for: task)
                    }
                }
            }
            .navigationDestination(for: RealmTodoTask.self) { task in
                EditTaskView(task: task)
            }
            .listStyle(.sidebar)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("", systemImage: "plus") {
                        viewModel.isAddViewPresented = true
                    }
                }
            }
            .sheet(isPresented: $viewModel.isAddViewPresented) {
                AddTaskView()
            }
            .onAppear {
                viewModel.addMockTodo()
            }
        }
    }
}

#Preview {
    TodoListView()
}
