//
//  EmptyListView.swift
//  Hrysiuk_Lab5
//
//  Created by Анастасія Грисюк on 01.04.2025.
//

import SwiftUI

struct EmptyListView: View {
    
    @Binding var isModalPresented: Bool
    
    var body: some View {
        VStack {
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
    }
}
