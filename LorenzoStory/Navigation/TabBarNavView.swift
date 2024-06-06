//
//  TabBarNavView.swift
//  LorenzoStory
//
//  Created by JWSScott777 on 5/31/24.
//

import SwiftUI

struct TabBarNavView: View {
    var coordinator: UICoordinator = .init()
    var body: some View {
        TabView {
                IntroPage()
                .tabItem {
                    Label("Intro", systemImage: "list.bullet.rectangle.portrait")
                    
                }
            NavigationStack {
                PhotoHome()
                    .environment(coordinator)
                    .allowsHitTesting(coordinator.selectedItem == nil)
            }
            // add
            .overlay {
                Rectangle()
                    .fill(.background)
                    .ignoresSafeArea()
                    .opacity(coordinator.animateView ? 1 : 0)
            }
            .overlay {
                if coordinator.selectedItem != nil {
                    PhotoDetail()
                        .environment(coordinator)
                        .allowsHitTesting(coordinator.showDetailView)
                }
            }
            .overlayPreferenceValue(HeroKey.self) { value in
                if let selectedItem = coordinator.selectedItem,
                    let sAnchor = value[selectedItem.id + "SOURCE"],
                   let dAnchor = value[selectedItem.id + "DEST"] {
                    HeroLayer(item: selectedItem, sAnchor: sAnchor, dAnchor: dAnchor)
                        .environment(coordinator)
                }

            }
                    .tabItem {
                        Label("Gallery", systemImage: "photo")
            }
            StoryView()
                .tabItem {
                    Label("Stories", systemImage: "book.closed")
                }
            Sidebar()
                .tabItem {
                    Label("Categories", systemImage: "list.bullet")
                }
        }
    }
}

#Preview {
    TabBarNavView()
}


