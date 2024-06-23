//
// ARMainView.swift
// LorenzoStory
// Created on 6/22/24
// 5.0
// JWSScott777
// jwsscott777
// LorenzoStory
//

import SwiftUI
import ARKit
import RealityKit

struct ARMainView: View {
    @State private var selectedAudio: Audio?
    @State private var showAudioView = false
    @State private var showAudioButton = false
    @State private var currentEntity: ModelEntity?
    @ObservedObject var dataManager = DataManager()
    

    var body: some View {
        ZStack {
            ARViewContainer(selectedAudio: $selectedAudio, showAudioView: $showAudioView, showAudioButton: $showAudioButton, currentEntity: $currentEntity)
                .ignoresSafeArea()
                .sheet(isPresented: $showAudioView, onDismiss: {
                    withAnimation(.easeInOut) {
                        showAudioButton = false
                        currentEntity?.removeFromParent()
                        currentEntity = nil
                    }
                }) {
                    if let selectedAudio = selectedAudio, let book = getBook(for: selectedAudio) {
                        AudioView(book: book, audio: selectedAudio)
                            .presentationDetents([.medium])
                    }
                }

            if showAudioButton {
                Button(action: {
                    showAudioView = true

                }) {
                    Text("Play Audio")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding()
                .transition(.opacity)
            }
        }
    }

    func getBook(for audio: Audio) -> Book! {
        return dataManager.categories.flatMap { $0.books }.first { book in
                    book.audios.contains(where: { $0.bookTitle == audio.bookTitle })
        }
    }
}

extension UIApplication {

    var keyWindow: UIWindow? {
        // Get connected scenes
        return self.connectedScenes
            // Keep only active scenes, onscreen and visible to the user
           // .filter { $0.activationState == .foregroundActive }
            // Keep only the first `UIWindowScene`
            .first(where: { $0 is UIWindowScene })
            // Get its associated windows
            .flatMap({ $0 as? UIWindowScene })?.windows
            // Finally, keep only the key window
            .first(where: \.isKeyWindow)
    }

}
