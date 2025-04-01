//
//  EmptyListView.swift
//  Hrysiuk_Lab5
//
//  Created by Анастасія Грисюк on 01.04.2025.
//

import SwiftUI

struct EmptyListView: View {
    
    @State private var isModalPresented = false
    @EnvironmentObject var viewModel: TodoListViewModel
    var body: some View {
        VStack {
            Spacer()
            Image(systemName: "figure.snowboarding")
                .resizable()
                .scaledToFit()
                .padding(.horizontal, 130)
                .padding(.bottom, 16)
                .foregroundStyle(.gray)
            Text("Seems like you have nothing to do")
                .font(.headline)
                .foregroundStyle(.gray)
                .padding(.bottom, 5)
            Text("You'd better fix that...")
                .foregroundStyle(.gray)
                .padding(.bottom, 5)
            Button("Add Task") {
                isModalPresented = true
            }
        }
        .sheet(isPresented: $isModalPresented) {
            AddTaskView()
        }
        .background(.clear)
    }
}

#Preview {
    EmptyListView()
}
