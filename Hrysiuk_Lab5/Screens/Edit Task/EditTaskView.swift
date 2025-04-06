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
    @StateObject private var viewModel = EditTaskViewModel()
    
    init(task: TodoTask) {
        self.task = task
    }
    
    var body: some View {
        Form {
            Section {
                HStack {
                    TextField("Name", text: $task.name)
                }
                HStack(alignment: .top) {
                    TextField("Notes", text: $task.notes, axis: .vertical)
                        .lineLimit(2...7)
                }
            }
            
            Section {
                HStack(alignment: .top) {
                    Picker("Priority", selection: $task.priority) {
                        Text("Low").tag(Priority.low)
                        Text("Medium").tag(Priority.medium)
                        Text("High").tag(Priority.high)
                    }
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
