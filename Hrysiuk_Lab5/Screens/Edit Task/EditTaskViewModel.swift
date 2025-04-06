//
//  EditTaskViewModel.swift
//  Hrysiuk_Lab5
//
//  Created by Анастасія Грисюк on 06.04.2025.
//

import Foundation
import Combine

final class EditTaskViewModel: ObservableObject {

    let editTaskSubject = PassthroughSubject<TodoTask, Never>()
    var bag = Set<AnyCancellable>()
    
    init() {
        setupEditTaskSubject()
    }
    
    func setupEditTaskSubject() {
        editTaskSubject
            .sink { task in
                TaskManager.shared.update(task: task)
            }
            .store(in: &bag)
    }
}
