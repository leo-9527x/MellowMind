import SwiftUI
import AVKit

class AudioPlayerManager: ObservableObject {
    var player: AVPlayer?

    init(soundURL: URL) {
        let playerItem = AVPlayerItem(url: soundURL)
        player = AVPlayer(playerItem: playerItem)
    }
}

struct SoundButton: View {
    let soundURL: URL
    let label: String
    @ObservedObject var timerManager: GlobalTimerManager

    @StateObject private var audioPlayerManager: AudioPlayerManager
    @State private var isPlaying = false
    @State private var volumeLevel: Double = 0.5

    init(soundURL: URL, label: String, timerManager: GlobalTimerManager) {
        self.soundURL = soundURL
        self.label = label
        self.timerManager = timerManager
        _audioPlayerManager = StateObject(wrappedValue: AudioPlayerManager(soundURL: soundURL))
    }

    var body: some View {
        VStack {
            Button(action: {
                toggleSound()
            }) {
                Image(systemName: isPlaying ? "pause.circle.fill" : "play.circle.fill") // Changed to use system icons
                    .resizable()
                    .foregroundColor(.white) // Set the color to white
                    .frame(width: 40, height: 40) // Adjust size as necessary
            }
            Slider(value: $volumeLevel, in: 0...1)
                .padding(.horizontal)
                .accentColor(.white)
                .frame(width: 200)
        }
        .onChange(of: volumeLevel) { newValue in
            audioPlayerManager.player?.volume = Float(newValue)
        }
        .onChange(of: timerManager.isBreakTime) { isNowBreakTime in
            if !isNowBreakTime && timerManager.wasMusicPlayingBeforeBreak && timerManager.currentlyPlayingSound == soundURL {
                playSound()
            } else if isNowBreakTime && timerManager.currentlyPlayingSound == soundURL {
                pauseSound()
            }
        }
        .onChange(of: timerManager.wasMusicPlayingBeforeBreak) { wasPlayingBeforeBreak in
            if !wasPlayingBeforeBreak && timerManager.currentlyPlayingSound == soundURL {
                playSound()
            }
        }

    }

    private func toggleSound() {
        if isPlaying {
            pauseSound()
        } else {
            playSound()
            timerManager.currentlyPlayingSound = soundURL
        }
    }

    private func playSound() {
        if timerManager.currentlyPlayingSound == soundURL || timerManager.currentlyPlayingSound == nil {
            audioPlayerManager.player?.play()
            isPlaying = true
        }
    }

    private func pauseSound() {
        if timerManager.currentlyPlayingSound == soundURL {
            audioPlayerManager.player?.pause()
            isPlaying = false
        }
    }

}
