//
//  Add.swift
//  Hrysiuk_Lab5
//
//  Created by Анастасія Грисюк on 01.04.2025.
//

import SwiftUI

struct EditTaskView: View {
    
    @Environment(\.dismiss) private var dismiss
    @State var task: TodoTask
    @EnvironmentObject private var viewModel: TodoListViewModel

    init(task: RealmTodoTask) {
        self.task = TodoTask(from: task)
    }
    
    var body: some View {
        Form {
            Section {
                HStack {
                    Text("Name")
                    TextField("Enter name...", text: $task.name)
                }
            }
            
            Section {
                HStack(alignment: .top) {
                    Text("Notes")
                    TextField("Enter notes...", text: $task.notes, axis: .vertical)
                        .lineLimit(2...7)
                }
                HStack {
                    Text("Due date")
                    DatePicker("", selection: $task.dueDate)
                }
            }
            
            Section {
                Toggle("Is done", isOn: $task.isDone)
            }
        }
        .navigationTitle(task.name)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("Save") {
                    viewModel.editTaskSubject.send(task)
                    dismiss()
                }
                .disabled(task.name == "")
            }
        }
    }
}
