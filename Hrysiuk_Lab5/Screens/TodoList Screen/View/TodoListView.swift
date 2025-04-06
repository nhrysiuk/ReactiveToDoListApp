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
            if viewModel.tasks.isEmpty && !viewModel.isLoading {
                EmptyListView(isModalPresented: $viewModel.isAddViewPresented)
            } else if viewModel.isLoading {
                ProgressView("Fetching the tasks...")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else {
                List {
                    ForEach(viewModel.searchResults, id: \.id) { task in
                        NavigationLink(value: task) {
                            TodoListCellView(task: task)
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
                        Menu("", systemImage: "arrow.up.arrow.down"){
                            Button("By date", action: viewModel.sortByDate)
                            Button("By priority", action: viewModel.sortByPriority)
                            Button("By default", action: viewModel.sortByDefault)
                        }
                    }
                    
                    ToolbarItem(placement: .topBarTrailing) {
                        Button("", systemImage: "plus") {
                            viewModel.isAddViewPresented = true
                        }
                    }
                }
                .navigationTitle("📌To do")
            }
        }
        .sheet(isPresented: $viewModel.isAddViewPresented) {
            AddTaskView()
        }
        
    }
}
