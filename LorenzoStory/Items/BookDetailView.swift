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
                            Image(book.imageName)
                                .resizable()
                            .aspectRatio(contentMode: .fit)
                            .visualEffect { content, proxy in
                                content
                                    .hueRotation(.degrees(hueAdjust ? 60  : 0))
                            }
                            .onAppear {
                                withAnimation(.easeInOut(duration: 17).delay(0.5).repeatForever(autoreverses: true)) {
                                    hueAdjust.toggle()
                                }
                            }
                            Text(book.title)
                                .font(.title)


                            Spacer()
                        }
                        .padding()
                        .background(book.color)
                        .clipShape(RoundedRectangle(cornerRadius: 25.0, style: .continuous))
                    .shadow(color: book.color.opacity(0.3), radius: 20, x: 0, y: 10)

                        VStack {
                            Image(book.logo)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .clipShape(RoundedRectangle(cornerRadius: 16.0 ))
                                .frame(width: 80, height: 80)
                                .padding()
                            Text(book.story)
                                .font(.system(size: fontSize))
                                .foregroundStyle(fontColor)
                        }
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
    }

    #Preview {
        NavigationStack {
            BookDetailView(book: books[0])
        }
    }
