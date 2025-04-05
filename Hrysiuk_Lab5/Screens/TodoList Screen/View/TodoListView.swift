//
//  TodoListView.swift
//  Hrysiuk_Lab5
//
//  Created by Анастасія Грисюк on 31.03.2025.
//

import SwiftUI

struct TodoListView: View {
    
    @EnvironmentObject var viewModel: TodoListViewModel
    
    var body: some View {
        NavigationStack {
            if viewModel.tasks.isEmpty {
                EmptyListView()
            }
            List {
                ForEach(viewModel.searchResults.indices, id: \.self) { index in
                    NavigationLink(value: viewModel.tasks[index]) {
                        TodoListCellView(task: $viewModel.tasks[index])
                    }
                }
                .onDelete { indexSet in
                    guard let index = indexSet.first else { return }
                    viewModel.deleteTaskSubject
                        .send(index)
                }
            }
            .navigationDestination(for: TodoTask.self) { task in
                EditTaskView(task: task)
            }
            .searchable(text: $viewModel.searchText)
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
        }
    }
}

#Preview {
    TodoListView()
}
