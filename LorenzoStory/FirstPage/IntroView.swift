//
//  IntroView.swift
//  LorenzoStory
//
//  Created by JWSScott777 on 6/1/24.
//

import SwiftUI

struct IntroView: View {
    var book: Book = books[0]
    var safeArea: EdgeInsets
    var size: CGSize
    @State private var showAboutView = false
    var body: some View {
        NavigationStack {
            ScrollView(.vertical, showsIndicators: false) {
                VStack {
                    ArtWork()

                    GeometryReader { proxy in
                        let minY = proxy.frame(in: .named("SCROLL")).minY - safeArea.top
                        Button {
                            showAboutView = true
                        } label: {
                            Text("I'm Lorenzo")
                                .font(.callout)
                                .fontWeight(.bold)
                                .foregroundStyle(.white)
                                .padding(.horizontal, 45)
                                .padding(.vertical, 12)
                                .background {
                                    Capsule()
                                        .fill(Color("PC").gradient)
                                }
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .offset(y: minY < 50 ? -(minY - 50) : 0)
                    }
                    .frame(height: 50)
                    .padding(.top, -34)
                    .zIndex(1)

                    VStack {
                        Text("Here's My Stories")
                            .fontWeight(.heavy)

                        // Story View
                        StoryListView()
                    }
                    .padding(.top, 10)
                    .zIndex(0)
                }
                .overlay(alignment: .top) {
                    HeaderView()
                }
            }
            .coordinateSpace(name: "SCROLL")
            .ignoresSafeArea()
            .sheet(isPresented: $showAboutView, content: {
                NavigationStack {
                    AboutView()
                }
            })
        } // navstack
    }
    @ViewBuilder
    func ArtWork() -> some View {
        let height = size.height * 0.45
        GeometryReader { proxy in
            let size = proxy.size
            let minY = proxy.frame(in: .named("SCROLL")).minY
            let progress = minY / (height * (minY > 0 ? 0.5 : 0.8))
            Image("Beast-BW")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: size.width, height: size.height + (minY > 0 ? minY : 0))
                .clipped()
                .overlay(content: {
                    ZStack(alignment: .bottom) {
                        Rectangle()
                            .fill(
                                .linearGradient(colors: [
                                    .black.opacity(0 - progress),
                                    .black.opacity(0.1 - progress),
                                    .black.opacity(0.3 - progress),
                                    .black.opacity(0.5 - progress),
                                    .black.opacity(0.8 - progress),
                                    .black.opacity(1),
                                ], startPoint: .top, endPoint: .bottom)
                            )
                    }
                })
                .offset(y: -minY)
        }
        .frame(height: height + safeArea.top)
    }

    @ViewBuilder
    func StoryListView() -> some View {
        VStack(spacing: 25) {
            ForEach(books) { book in
                NavigationLink(destination: BookDetailView(book: book)) {
                    HStack(spacing: 25) {
                        Image(systemName: "book.fill")
                            .font(.callout)
                            .fontWeight(.semibold)
                            .foregroundStyle(.gray)
                        VStack(alignment: .leading, spacing: 6) {
                            Text(book.title)
                                .fontWeight(.semibold)
                                .foregroundStyle(.white)
                            Text("Short Story")
                                .font(.caption)
                                .foregroundStyle(.gray)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Image(systemName: "pawprint")
                            .foregroundStyle(.gray)
                    }
                }
            }
        }
        .padding(15)
    }

    @ViewBuilder
    func HeaderView() -> some View {
        GeometryReader { proxy in
            let minY = proxy.frame(in: .named("SCROLL")).minY
            let height = size.height * 0.45
            let progress = minY / (height * (minY > 0 ? 0.5 : 0.8))
            let titleProgress = minY / height
            HStack(spacing: 15) {
                Text("Bulldog")
                    .font(.caption)
                    .foregroundStyle(.white)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 6)
                    .border(.white, width: 1.5)
                    .opacity(1 + progress)
                Spacer(minLength: 0)
                Text("Stories")
                    .font(.caption)
                    .fontWeight(.semibold)
                    .foregroundStyle(.white)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 6)
                    .border(.white, width: 1.5)
                    .opacity(1 + progress)
            }
            .overlay(content: {
                Text("Lorenzo the Bulldog")
                    .fontWeight(.semibold)
                    .offset(y: -titleProgress > 0.75 ? 0 : 45)
                    .clipped()
                    .animation(.easeInOut(duration: 0.25), value: -titleProgress > 0.75)
            })
            .padding(.top, safeArea.top + 10)
            .padding([.horizontal, .bottom], 15)
            .background(content: {
                Color.black
                    .opacity(-progress > 1 ? 1 : 0)
            })
            .offset(y: -minY)
        }
        .frame(height: 35)
    }
}

#Preview {
    ContentView()
}
