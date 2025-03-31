//
//  TodoListView.swift
//  Hrysiuk_Lab5
//
//  Created by Анастасія Грисюк on 31.03.2025.
//

import SwiftUI

struct TodoListView: View {
    
    @State private var tasks: [RealmTodoTask] = []
    @StateObject var viewModel = TodoListViewModel()
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button("Add Task", systemImage: "plus") {
                    
                }
            }
            .padding(.trailing)
            
            ScrollView {
                LazyVStack {
                    ForEach(tasks, id: \.self) { task in
                        TodoListCellView(for: task)
                    }
                }
            }
            .onAppear {
                viewModel.addMockTodo()
                tasks = viewModel.fetchTasks()
            }
        }
        .sheet(isPresented: $viewModel.isModalPresented) {
           
        }
    }
}

#Preview {
    TodoListView()
}
