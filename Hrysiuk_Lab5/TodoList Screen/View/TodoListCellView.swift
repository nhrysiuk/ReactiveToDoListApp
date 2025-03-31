//
//  TodoListCellView.swift
//  Hrysiuk_Lab5
//
//  Created by Анастасія Грисюк on 31.03.2025.
//

import SwiftUI

struct TodoListCellView: View {
    
    @State private var task: RealmTodoTask
    
    init(for task: RealmTodoTask) {
        self.task = task
    }
    
    var body: some View {
        HStack {
            Button("", systemImage: "checkmark") {
                
            }
            Text(task.name)
            Spacer()
        }
        .padding()
    }
}

#Preview {
    TodoListCellView(for: RealmTodoTask.mockTodo)
}
