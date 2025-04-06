//
//  Untitled.swift
//  Hrysiuk_Lab5
//
//  Created by Анастасія Грисюк on 05.04.2025.
//

import SwiftUI
import Realm

enum Priority: String, Comparable {
    
    case low
    case medium
    case high
    
    var image: (name: String, color: Color) {
        switch self {
        case .high:
            return ("exclamationmark.3", .red)
        case .medium:
            return ("exclamationmark.2", .yellow)
        case .low:
            return ("exclamationmark", .green)
        }
    }
    
    var number: Int {
        switch self {
        case .high:
            return 1
        case .medium:
            return 2
        case .low:
            return 3
        }
    }
    
    static func < (lhs: Priority, rhs: Priority) -> Bool {
        lhs.number > rhs.number
    }
}
