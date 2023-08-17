import SwiftUI

struct ContentView: View {
    @State private var showSoundboard = false
    @State private var focusTime: TimeInterval = 0
    @State private var breakTime: TimeInterval = 0
    private var timerManager = GlobalTimerManager()

    var body: some View {
        if showSoundboard {
            SoundboardView(focusTime: $focusTime, breakTime: $breakTime, showSoundboard: $showSoundboard, timerManager: timerManager)
        } else {
            ZStack {
                Color("lofi-orange") // Orange background
                    .edgesIgnoringSafeArea(.all)
                VStack {
                    Text("Mellow Mind")
                        .font(.custom("DancingScript-Regular", size: 50))
                        .foregroundColor(.white)
                        .padding()

                    // Time Picker for Focus Time
                    VStack {
                        Text("Focus Time")
                            .foregroundColor(.white)
                        TimeSetterView(totalSeconds: $focusTime)
                    }
                    .padding()

                    // Time Picker for Break Time
                    VStack {
                        Text("Break Time")
                            .foregroundColor(.white)
                        TimeSetterView(totalSeconds: $breakTime)
                    }
                    .padding()

                    Button(action: {
                        self.showSoundboard.toggle()
                    }) {
                        Image(systemName: "arrow.right.circle")
                            .resizable()
                            .foregroundColor(Color(.white))
                            .frame(width: 40, height: 40)
                    }
                    .padding()
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
