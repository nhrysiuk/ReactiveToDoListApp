//
//  DateFormatter ext.swift
//  Hrysiuk_Lab5
//
//  Created by Анастасія Грисюк on 06.04.2025.
//

import Foundation

extension DateFormatter {
    
    static let dateAndTime: DateFormatter = {
         let formatter = DateFormatter()
         formatter.dateFormat = "dd.MM.yyyy HH:mm"
         return formatter
     }()
}
