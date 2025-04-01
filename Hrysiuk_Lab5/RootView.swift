//
//  ContentView.swift
//  Hrysiuk_Lab5
//
//  Created by Анастасія Грисюк on 28.03.2025.
//

import SwiftUI

struct RootView: View {
    
    @StateObject var viewModel = TodoListViewModel()
    
    var body: some View {
        TodoListView()
            .environmentObject(viewModel)
    }
}

#Preview {
    RootView()
}
