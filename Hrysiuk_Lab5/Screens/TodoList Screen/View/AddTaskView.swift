//
//  Add.swift
//  Hrysiuk_Lab5
//
//  Created by Анастасія Грисюк on 01.04.2025.
//

import SwiftUI
import Combine

struct AddTaskView: View {
    
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var viewModel: TodoListViewModel
    
    @State var task = TodoTask()
    
    var body: some View {
        NavigationStack {
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
            }
            .navigationTitle("Add Task")
            .navigationBarTitleDisplayMode(.inline)
            
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Save") {
                        viewModel.addTaskSubject.send(task)
                        dismiss()
                    }
                    .disabled(task.name == "")
                }
            }
        }
    }
}

#Preview {
    AddTaskView()
}
