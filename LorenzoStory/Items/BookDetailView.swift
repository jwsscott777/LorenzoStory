//
//  StoryDetailView.swift
//  LorenzoStory
//
//  Created by JWSScott777 on 5/31/24.
//

import SwiftUI

struct BookDetailView: View {
    @State private var hueAdjust = false
    @State private var fontSize: CGFloat = 20
    @State private var fontColor: Color = .white
    @State private var isShowingTextStyleAdjustmentView = false
    private var backButton: some View {
        Button(action: {
            isShowingTextStyleAdjustmentView.toggle()
        }, label: {
            Image(systemName: "pawprint").bold().foregroundStyle(.primary)
                .frame(width: 55, height: 55)
                .background(.ultraThinMaterial, in: Circle())
        })
    }
    var book: Book
    var body: some View {
        NavigationStack {
            progressTraker {
                ScrollView {
                    VStack {
                        imageSection
                        titleSection
                        Spacer()
                    }
                    .padding()
                    .background(book.color)
                    .clipShape(RoundedRectangle(cornerRadius: 25.0, style: .continuous))
                    .shadow(color: book.color.opacity(0.3), radius: 20, x: 0, y: 10)
                    VStack {
                       logoSection
                        storySection
                    }// Vstack
                }
                .edgesIgnoringSafeArea(.all)
                .sheet(isPresented: $isShowingTextStyleAdjustmentView, content: {
                    TextStyleAdjustmentView(fontSize: $fontSize, fontColor: $fontColor)
                        .presentationDetents([ .medium])
                        .presentationBackground(.ultraThinMaterial)
                })
            }
        }
        .navigationTitle(book.title)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                backButton
            }
        }
    }

    private var imageSection: some View {
        Image(book.imageName)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .visualEffect { content, proxy in
                content
                    .hueRotation(.degrees(hueAdjust ? 30  : 0))
                    .opacity(hueAdjust ? 0.95 : 1)
                    .contrast(hueAdjust ? 1.05 : 1)
                    .saturation(hueAdjust ? 1.1 : 1)
            }
            .onAppear {
                withAnimation(.easeInOut(duration: 17).delay(0.5).repeatForever(autoreverses: true)) {
                    hueAdjust.toggle()
                }
            }
    }
    private var titleSection: some View {
        Text(book.title)
            .font(.title)
    }
    private var logoSection: some View {
        HStack {
            Image(book.logo)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .clipShape(RoundedRectangle(cornerRadius: 16.0 ))
                .frame(width: 80, height: 80)
                .padding()

            ForEach(book.audios) { audio in
                NavigationLink(destination: AudioView(book: book, audio: audio)) {
                    Text("Prefer to Listen?")
                        .font(.callout)
                        .fontWeight(.bold)
                        .foregroundStyle(.white)
                        .padding()
                        .background {
                            Capsule()
                                .fill(Color.accentColor.gradient)
                        }
                }//
            }
        }
    }
    private var storySection: some View {
        Text(book.story)
            .font(.system(size: fontSize))
            .foregroundStyle(fontColor)
    }
}

    #Preview {
        NavigationStack {
            BookDetailView(book: books[0])
        }
    }
