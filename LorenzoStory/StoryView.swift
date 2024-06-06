//
//  StoryView.swift
//  LorenzoStory
//
//  Created by JWSScott777 on 5/31/24.
//

import SwiftUI

struct StoryView: View {
    
    @State private var screenSize: CGSize = .zero
        var isIpad: Bool {
            UIDevice.current.userInterfaceIdiom == .pad
        }

        var geometryReader: some View {
            GeometryReader { proxy in
                Color.clear
                    .onAppear {
                        screenSize = proxy.size
                    }
                    .onChange(of: proxy.size) { oldValue, newValue in
                        screenSize = newValue
                    }
            }
        }

    private var bookmark: some View {
        Button(action: {

        }, label: {
            Image(systemName: "pawprint").bold().foregroundStyle(.primary)
                .frame(width: 55, height: 55)
                .background(.ultraThinMaterial, in: Circle())
        })
    }

        var body: some View {
            NavigationStack {
                ScrollView {
                    if isIpad {
                        ipadView
                    } else {
                        iosView
                    }
               }
                .scrollTargetBehavior(.viewAligned)
                .overlay(geometryReader)
                .navigationTitle("Lorenzo the Beast")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        bookmark
                    }
                }
            }

        }
    }

    #Preview {
        StoryView()
    }



    @ViewBuilder var ipadView: some View {
        VStack(spacing: 60) {
            ForEach(books) { book in
                NavigationLink(destination: BookDetailView(book: book)){
                    BookItem(book: book)
                        .scrollTransition { content, phase in
                            content
                                .scaleEffect(phase.isIdentity ? 0.9 : 0.8)
                                .blur(radius: phase.isIdentity ? 0 : 5)
                                .rotationEffect(.degrees(phase.isIdentity ? 0 : -30))
                                .rotation3DEffect(.degrees(phase.isIdentity ? 0 : 60), axis: (x: -1, y: 1, z: 0))
                               .offset(x: phase.isIdentity ? 0 : -200)
                    }
                }
            }
        }
        .padding()
        .scrollTargetLayout()
    }

    @ViewBuilder var iosView: some View {
        VStack(spacing: 60) {
                           ForEach(books) { book in
                               NavigationLink(destination: BookDetailView(book: book)) {
                                   BookItem(book: book)
                                       .scrollTransition { content, phase in
                                           content
                                               .scaleEffect(phase.isIdentity ? 1 : 0.8)
                                               .blur(radius: phase.isIdentity ? 0 : 5)
                                               .rotationEffect(.degrees(phase.isIdentity ? 0 : -30))
                                               .rotation3DEffect(.degrees(phase.isIdentity ? 0 : 60), axis: (x: -1, y: 1, z: 0))
                                               .offset(x: phase.isIdentity ? 0 : -200)
                                   }
                               }
                           }
                       }
        .padding()
        .scrollTargetLayout()
    }
