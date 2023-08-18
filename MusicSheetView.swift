//
//  MusicSheetView.swift
//  lofi-soundboard
//
//  Created by Robert Liu on 8/17/23.
//

import SwiftUI

struct MusicSheetView: View {
    @ObservedObject var timerManager: GlobalTimerManager
    let soundData = [
        (soundURL: Bundle.main.url(forResource: "jazz", withExtension: "mp3")!, label: "Jazz"),
        (soundURL: Bundle.main.url(forResource: "fireplace", withExtension: "mp3")!, label: "Fireplace"),
        (soundURL: Bundle.main.url(forResource: "chatter", withExtension: "mp3")!, label: "Chatter"),
        (soundURL: Bundle.main.url(forResource: "rain", withExtension: "mp3")!, label: "Rain")
    ]
    
    var body: some View {
        VStack {
            Spacer(minLength: 20)
            Text("Background Music")
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
            
            Spacer(minLength: 20)
            
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 150), spacing: 20)], spacing: 20) {
                    VStack {
                        Text("Jazz")
                            .italic()
                            .foregroundColor(.white)
                        SoundButton(soundURL: soundData[0].soundURL, label: soundData[0].label, timerManager: timerManager)
                    }

                    VStack {
                        Text("Fireplace")
                            .italic()
                            .foregroundColor(.white)
                        SoundButton(soundURL: soundData[1].soundURL, label: soundData[1].label, timerManager: timerManager)
                    }

                    VStack {
                        Text("Chatter")
                            .italic()
                            .foregroundColor(.white)
                        SoundButton(soundURL: soundData[2].soundURL, label: soundData[2].label, timerManager: timerManager)
                    }

                    VStack {
                        Text("Rain")
                            .italic()
                            .foregroundColor(.white)
                        SoundButton(soundURL: soundData[3].soundURL, label: soundData[3].label, timerManager: timerManager)
                    }
                }
                .padding()
            }
            
            Spacer()
        }
        .background(Color("lofi-orange").opacity(0.5).edgesIgnoringSafeArea(.all)) // Set the background of the entire VStack
    }
}


