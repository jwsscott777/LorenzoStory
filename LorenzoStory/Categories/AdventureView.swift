//
//  AdventureView.swift
//  LorenzoStory
//
//  Created by JWSScott777 on 5/31/24.
//

import SwiftUI

struct AdventureView: View {
    @ObservedObject var dataManager = DataManager()
    var body: some View {
        NavigationStack {
            ZStack {
                ScrollView {
                    VStack {
                        Text("Adventure")
                            .font(.largeTitle)
                            .bold()
                            .frame(maxWidth: .infinity)
                            .padding()
                        if let adventureCategory = dataManager.categories.first(where: { $0.name == "Mystery" }) {
                            LazyVGrid(columns: [GridItem(.adaptive(minimum: 160), spacing: 16)], spacing: 16) {
                                ForEach(adventureCategory.books) { book in
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
    AdventureView()
}
