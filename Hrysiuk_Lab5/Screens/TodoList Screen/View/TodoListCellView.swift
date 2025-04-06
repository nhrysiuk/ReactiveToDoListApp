//
//  TodoListCellView.swift
//  Hrysiuk_Lab5
//
//  Created by Анастасія Грисюк on 31.03.2025.
//

import SwiftUI

struct TodoListCellView: View {
    
    @Binding var task: TodoTask
    
    var body: some View {
        HStack {
            Image(systemName: task.isDone ? "checkmark.square.fill" : "square")
            Text(task.name)
            Spacer()
            Text(DateFormatter.dateAndTime.string(from: task.dueDate))
                .foregroundStyle(task.dueDate > Date() ? .green : .red)
            Image(systemName: task.priority.image.name)
                .foregroundStyle(task.priority.image.color)
        }
        .padding()
    }
}
