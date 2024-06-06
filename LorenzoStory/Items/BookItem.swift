//
//  StoryItem.swift
//  LorenzoStory
//
//  Created by JWSScott777 on 5/31/24.
//

import SwiftUI

struct BookItem: View {
    var book: Book = books[0]
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            Image(book.logo)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .clipShape(RoundedRectangle(cornerRadius: 16.0 ))
                .frame(width: 50, height: 50)
                .padding()
                .zIndex(1)
            VStack(alignment: .leading, spacing: 4.0) {
                Spacer()
                HStack {
                    Spacer()
                    Image(book.imageName)
                        .resizable()
                    .aspectRatio(contentMode: .fit)
                    Spacer()
                }
                Text(book.title)
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
                Text(book.description)
                    .font(.footnote)
                    .foregroundStyle(.white)
            }
            .padding()
            .background(book.color)
            .clipShape(RoundedRectangle(cornerRadius:  25.0, style: .continuous))
        .shadow(color: book.color.opacity(0.3), radius: 20, x: 0, y: 10)
        } // Z
    }
}

#Preview {
    BookItem()
}


