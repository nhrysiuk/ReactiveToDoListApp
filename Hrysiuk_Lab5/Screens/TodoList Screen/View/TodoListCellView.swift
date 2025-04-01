//
//  TodoListCellView.swift
//  Hrysiuk_Lab5
//
//  Created by Анастасія Грисюк on 31.03.2025.
//

import SwiftUI

struct TodoListCellView: View {
    
    @Binding var task: RealmTodoTask
    
    var body: some View {
        HStack {
            Image(systemName: task.isDone ? "checkmark.square.fill" : "square")
            Text(task.name)
            Spacer()
        }
        .padding()
    }
}

