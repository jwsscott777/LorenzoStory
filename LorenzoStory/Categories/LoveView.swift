//
//  LoveView.swift
//  LorenzoStory
//
//  Created by JWSScott777 on 5/31/24.
//

import SwiftUI

struct LoveView: View {
    @ObservedObject var dataManager = DataManager()
    var body: some View {
        NavigationStack {
            ZStack {
                ScrollView {
                    VStack {
                        Text("Love")
                            .font(.largeTitle)
                            .bold()
                            .frame(maxWidth: .infinity)
                            .padding()
                        if let loveCategory = dataManager.categories.first(where: { $0.name == "Love" }) {
                            LazyVGrid(columns: [GridItem(.adaptive(minimum: 160), spacing: 16)], spacing: 16) {
                                ForEach(loveCategory.books) { book in
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
    LoveView()
}
