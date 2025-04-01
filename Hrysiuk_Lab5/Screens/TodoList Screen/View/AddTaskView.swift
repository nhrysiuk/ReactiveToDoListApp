//
//  Add.swift
//  Hrysiuk_Lab5
//
//  Created by Анастасія Грисюк on 01.04.2025.
//

import SwiftUI

struct AddTaskView: View {
    
    @Environment(\.dismiss) private var dismiss
    
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
