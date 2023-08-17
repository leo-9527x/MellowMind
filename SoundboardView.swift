import SwiftUI

struct SoundboardView: View {
    @Binding var focusTime: TimeInterval
    @Binding var breakTime: TimeInterval
    @Binding var showSoundboard: Bool
    @ObservedObject var timerManager: GlobalTimerManager

    let soundData = [
        (soundURL: Bundle.main.url(forResource: "jazz", withExtension: "mp3")!, label: "Sound 1"),
        (soundURL: Bundle.main.url(forResource: "rain", withExtension: "mp3")!, label: "Sound 2"),
        (soundURL: Bundle.main.url(forResource: "chatter", withExtension: "mp3")!, label: "Sound 3"),
        (soundURL: Bundle.main.url(forResource: "fireplace", withExtension: "mp3")!, label: "Sound 4")
    ]
    
    var maxValue: TimeInterval {
        return timerManager.isBreakTime ? breakTime : focusTime
    }

    var body: some View {
        ZStack {
            Color("lofi-orange")
                .edgesIgnoringSafeArea(.all)
            VStack {
                Text("Mellow Mind")
                    .font(.custom("DancingScript-Regular", size: 40))
                    .foregroundColor(.white)
                    .padding()

                CircleProgressView(value: $timerManager.currentTime, maxValue: maxValue)
                    .padding()

                ScrollView {
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 150), spacing: 20)], spacing: 20) {
                        ForEach(soundData, id: \.label) { sound in
                            SoundButton(soundURL: sound.soundURL, label: sound.label, timerManager: timerManager)
                        }

                    }
                    .padding()
                }


                Button(action: {
                    self.showSoundboard.toggle()
                }) {
                    Image(systemName: "arrow.left.circle")
                        .resizable()
                        .foregroundColor(Color(.white))
                        .frame(width: 40, height: 40)
                }
                .padding()
            }
        }
        .onAppear {
            timerManager.startTimer(focusTime: self.focusTime, breakTime: self.breakTime)
        }
        .onDisappear {
            timerManager.pause()
        }
    }
}
