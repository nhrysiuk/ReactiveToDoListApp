//
//  EditTaskViewModel.swift
//  Hrysiuk_Lab5
//
//  Created by Анастасія Грисюк on 06.04.2025.
//

import Foundation
import Combine

final class AddTaskViewModel: ObservableObject {

    let addTaskSubject = PassthroughSubject<TodoTask, Never>()
    private var bag = Set<AnyCancellable>()
    
    init() {
        setupAddTaskSubject()
    }
    
    func setupAddTaskSubject() {
        addTaskSubject
            .sink { task in
                TaskManager.shared.add(task: task)
            }
            .store(in: &bag)
    }
}
