//
//  PhotoHome.swift
//  LorenzoStory
//
//  Created by JWSScott777 on 6/1/24.
//

import SwiftUI

struct PhotoHome: View {
    @Environment(UICoordinator.self) private var coordinator
    var body: some View {
        NavigationStack {
            ScrollView(.vertical) {
                LazyVGrid(columns: Array(repeating: GridItem(spacing: 3), count: 3), spacing: 3) {
                    ForEach(coordinator.items) { item in
                        GridImageView(item)
                            .onTapGesture {
                                coordinator.selectedItem = item
                            }
                    }
                }
                .padding(.vertical, 15)
            }
            .navigationTitle("Lorenzo's Gallery")
            .navigationBarTitleDisplayMode(.inline)
        }// nav
        
    }

    // Image view for grid
    @ViewBuilder
    func GridImageView(_ item: Item) -> some View {
        GeometryReader {
            let size = $0.size
            Rectangle()
                .fill(.clear)
                .anchorPreference(key: HeroKey.self, value: .bounds, transform: { anchor in
                    return [item.id + "SOURCE": anchor]
                })
            if let previewImage = item.previewImage {
                Image(uiImage: previewImage)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: size.width, height: size.height)
                    .clipped()
                    .opacity(coordinator.selectedItem?.id == item.id ? 0 : 1)
            }
        }
        .frame(height: 130)
        .contentShape(.rect(cornerRadius: 25))
    }
}

#Preview {
    ContentView()
}
