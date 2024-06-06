//
//  Sidebar.swift
//  LorenzoStory
//
//  Created by JWSScott777 on 5/31/24.
//

import SwiftUI

struct Sidebar: View {
    var body: some View {
        NavigationStack {
            VStack {


                    List {
                        Section(header: Text("Categories")) {
                            NavigationLink(destination: StoryView()) {
                                Label("All", systemImage: "book.closed")
                            }
                            NavigationLink(destination: MysteryView()) {
                                Label("Mystery", systemImage: "book.closed")
                            }
                            NavigationLink(destination: LoveView()) {
                                Label("Love", systemImage: "book.closed")
                            }
                            NavigationLink(destination: ActionView()) {
                                Label("Action", systemImage: "book.closed")
                            }
                            NavigationLink(destination: AdventureView()) {
                                Label("Adventure", systemImage: "book.closed")
                            }
                        }
                        Section(header: Text("About")) {
                            NavigationLink {
                                AboutView()
                            } label: {
                                Label("About Lorenzo", systemImage: "pawprint")
                            }

                        }
                    }
                    .listStyle(.sidebar)
                Image("Beast-BW")
                    .resizable()
                    .aspectRatio(contentMode: .fit)

                }
                .navigationTitle("Categories")
                .navigationBarTitleDisplayMode(.inline)
              //  .ignoresSafeArea()
        }
    }
}

#Preview {
    Sidebar()
}


