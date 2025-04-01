//
//  Add.swift
//  Hrysiuk_Lab5
//
//  Created by Анастасія Грисюк on 01.04.2025.
//

import SwiftUI

struct EditTaskView: View {
    
    @State var task: TodoTask
    
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
            }
            .navigationTitle("Add Task")
            .navigationBarTitleDisplayMode(.inline)
            
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Save") {
                        
                    }
                    .disabled(task.name == "")
                }
            }
    }
}

#Preview {
    EditTaskView(task: RealmTodoTask(name: "To do", dueDate: Date(), notes: "fdfdf", isDone: false))
}
