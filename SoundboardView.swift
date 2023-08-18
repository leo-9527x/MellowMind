import SwiftUI

struct SoundboardView: View {
    @Binding var focusTime: TimeInterval
    @Binding var breakTime: TimeInterval
    @Binding var showSoundboard: Bool
    @State private var isSheetShown: Bool = false
    @ObservedObject var timerManager: GlobalTimerManager

    let soundData = [
        (soundURL: Bundle.main.url(forResource: "Next-door-music", withExtension: "mp3")!, label: "Sound 1"),
        (soundURL: Bundle.main.url(forResource: "Jazz-music", withExtension: "mp3")!, label: "Sound 2"),
        (soundURL: Bundle.main.url(forResource: "Crescent-Moon-music", withExtension: "mp3")!, label: "Sound 3")
    ]
    
    var maxValue: TimeInterval {
        return timerManager.isBreakTime ? breakTime : focusTime
    }
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.red.opacity(0.6), Color.purple.opacity(0.6)]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            VStack {
                Text("Mellow Mind")
                    .font(.custom("DancingScript-Regular", size: 40))
                    .foregroundColor(.white)
                    .padding()

                CircleProgressView(value: $timerManager.currentTime, maxValue: maxValue)
                    .padding()

                ScrollView {
                    VStack(spacing: 20) {
                        Text("Next-door-music")
                            .italic()
                            .foregroundColor(.white)
                        SoundButton(soundURL: soundData[0].soundURL, label: soundData[0].label, timerManager: timerManager)

                        Text("Jazz-music")
                            .italic()
                            .foregroundColor(.white)
                        SoundButton(soundURL: soundData[1].soundURL, label: soundData[1].label, timerManager: timerManager)

                        Text("Crescent-Moon-music")
                            .italic()
                            .foregroundColor(.white)
                        SoundButton(soundURL: soundData[2].soundURL, label: soundData[2].label, timerManager: timerManager)
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
        
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Button(action: {
                        self.isSheetShown.toggle()
                    }) {
                        Image(systemName: "arrow.up.circle")
                            .resizable()
                            .foregroundColor(Color(.white))
                            .frame(width: 40, height: 40)
                    }
                    .sheet(isPresented: $isSheetShown) {
                        // This is where the MusicSheetView is presented as a sheet
                        MusicSheetView(timerManager: timerManager)
                    }
                    .padding()
                }
            }
        }
        .onAppear {
            timerManager.startTimer(focusTime: self.focusTime, breakTime: self.breakTime)
        }
        .onDisappear {
            timerManager.pause()
        }
        // Here's the sheet modifier that displays the MusicSheetView when isSheetShown is true.
        .sheet(isPresented: $isSheetShown) {
            MusicSheetView(timerManager: timerManager)
        }
    }
}
