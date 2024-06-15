//
//  AudioView.swift
//  LorenzoStory
//
//  Created by JWSScott777 on 6/12/24.
//

import SwiftUI
import AVKit

struct AudioView: View {
    var book: Book
    var audio: Audio
   // let audioFile: String

    @State private var player: AVAudioPlayer?
    @State private var isPlaying = false
    @State private var totalTime: TimeInterval = 0.0
    @State private var currentTime: TimeInterval = 0.0
    var body: some View {
        VStack {
            ZStack {
                HStack {
                    NavigationLink {
                        //
                    } label: {
                        ModifiedButtonView(image: "arrow.left")
                    }

                    Spacer()
                    NavigationLink {
                        AboutView()
                    } label: {
                        ModifiedButtonView(image: "pawprint")
                    }

                }
                Text("Now Playing")
                    .fontWeight(.bold)
                .foregroundStyle(.black.opacity(0.8))
            }
            .padding(.all)

            Image(book.imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding(.horizontal, 55)
                .clipShape(Circle())
                .padding(.all, 8)
                .background(Color(#colorLiteral(red: 0.8980392157, green: 0.9333333333, blue: 1, alpha: 1)))
                .clipShape(Circle())
                .shadow(color: Color.black.opacity(0.8), radius: 8, x: 8, y: 8)
                .shadow(color: .white, radius: 10, x: -10, y: -10)
                .padding(.top, 35)

            Text(book.title)
                .font(.title)
                .fontWeight(.bold)
                .foregroundStyle(.black.opacity(0.8))
                .padding(.top, 25)

            Text(book.description)
                .font(.caption)
                .fontWeight(.bold)
                .foregroundStyle(.black.opacity(0.8))
                .padding(.top, 2)

            VStack {
                HStack {
                    Text(timeString(time: currentTime))
                    Spacer()
                    Text(timeString(time: totalTime))
                }
                .font(.caption)
                .foregroundStyle(.black)
                .padding([.top, .trailing, .leading], 20)
                Slider(value: Binding(get: {
                    currentTime
                }, set: { newValue in
                    audioTime(to: newValue)
                }), in: 0...totalTime)
                .padding()
            }
            HStack(spacing: 20) {
                Button(action: {
                    moveBackward()
                }, label: {
                    ModifiedButtonView(image: "backward.fill")
                })
                Button {
                    isPlaying ? stopAudio() : playAudio()
                } label: {
                    Image(systemName: isPlaying ? "pause.fill" : "play.fill")
                        .font(.system(size: 14, weight: .bold))
                        .padding(.all, 25)
                        .foregroundStyle(.black.opacity(0.8))
                        .background(
                            ZStack {
                                Color(#colorLiteral(red: 0.7608050100, green: 0.8164883852, blue: 0.9259157777, alpha: 1))
                                Circle()
                                    .foregroundStyle(.white)
                                    .blur(radius: 4)
                                    .offset(x: -8, y: -8)
                                Circle()
                                    .fill(LinearGradient(gradient: Gradient(colors: [Color(red: 231, green: 238, blue: 253), Color.white]), startPoint: .topLeading, endPoint: .bottomTrailing))
                                    .padding(2)
                                    .blur(radius: 2)
                            }
                                .clipShape(Circle())
                                .shadow(radius: 10)
                        )
//                        .onTapGesture {
//                            isPlaying ? stopAudio() : playAudio()
//                        }
                }
                Button(action: {
                    moveForward()
                }, label: {
                    ModifiedButtonView(image: "forward.fill")
                })
            }
            .padding(.top, 25)

            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(#colorLiteral(red: 0.8980392157, green: 0.9333333333, blue: 1, alpha: 1)))
        .onAppear(perform: {
            setupAudio()
        })
        .onReceive(Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()) { _ in
            updateProgress()
        }
    }
    // New func
    func currentLocalization() -> String {
        return Locale.current.language.languageCode?.identifier ?? "en"
    }

    private func setupAudio() {
        let localization = currentLocalization()
                let audioFile = localization == "es" ? audio.spanishAudioFile : audio.englishAudioFile
        guard let url = Bundle.main.url(forResource: audioFile, withExtension: "mp3") else {
            print("Audio file not found")
            return
        }
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.prepareToPlay()
            totalTime = player?.duration ?? 0.0
        } catch {
            print(error.localizedDescription)
        }
    }
    private func playAudio() {
        player?.play()
        isPlaying = true
    }
    private func stopAudio() {
        player?.stop()
        isPlaying = false
    }
    private func updateProgress() {
        guard let player = player else { return }
        currentTime = player.currentTime
    }
    private func audioTime(to time: TimeInterval) {
        player?.currentTime = time
    }
    private func timeString(time: TimeInterval) -> String {
        let minute = Int(time) / 60
        let seconds = Int(time) % 60
        return String(format: "%02d:%02d", minute, seconds)
    }
    private func moveBackward() {
        guard let player = player else { return }
        player.currentTime = max(player.currentTime - 10, 0)
        currentTime = player.currentTime
    }
    private func moveForward() {
        guard let player = player else { return }
        player.currentTime = min(player.currentTime + 10, player.duration)
        currentTime = player.currentTime
    }
}

#Preview {
    AudioView(book: books[0], audio: Audio(bookTitle: "The Phantom Squirrel", englishAudioFile: "Audio20", spanishAudioFile: "Audio20"))
}

struct ModifiedButtonView: View {
    var image: String
    var body: some View {
            Image(systemName: image)
                .font(.system(size: 14, weight: .bold))
                .padding(.all, 25)
                .foregroundStyle(.black.opacity(0.8))
                .background(
                    ZStack {
                        Color(#colorLiteral(red: 0.7608050100, green: 0.8164883852, blue: 0.9259157777, alpha: 1))
                        Circle()
                            .foregroundStyle(.white)
                            .blur(radius: 4)
                            .offset(x: -8, y: -8)
                        Circle()
                            .fill(LinearGradient(gradient: Gradient(colors: [Color(red: 231, green: 238, blue: 253), Color.white]), startPoint: .topLeading, endPoint: .bottomTrailing))
                            .padding(2)
                            .blur(radius: 2)
                    }
                        .clipShape(Circle())
                        .shadow(radius: 10)
                )
    }
}

