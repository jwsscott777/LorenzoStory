//
//  ActionView.swift
//  LorenzoStory
//
//  Created by JWSScott777 on 5/31/24.
//

import SwiftUI

struct ActionView: View {
    @ObservedObject var dataManager = DataManager()
    var body: some View {
        NavigationStack {
            ZStack {
                ScrollView {
                    VStack {
                        Text("Action")
                            .font(.largeTitle)
                            .bold()
                            .frame(maxWidth: .infinity)
                            .padding()
                        if let actionCategory = dataManager.categories.first(where: { $0.name == "Action" }) {
                            LazyVGrid(columns: [GridItem(.adaptive(minimum: 160), spacing: 16)], spacing: 16) {
                                ForEach(actionCategory.books) { book in
                                    NavigationLink(destination: BookDetailView(book: book)) {
                                        BookItem(book: book)
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    ActionView()
}
