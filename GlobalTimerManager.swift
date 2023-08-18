import Foundation
import Combine

class GlobalTimerManager: ObservableObject {
    
    var timer: AnyCancellable?
    
    @Published var isPlaying = false
    @Published var isBreakTime = false
    @Published var wasMusicPlayingBeforeBreak = false
    @Published var currentlyPlayingSound: URL?
    @Published var wasMusicPlayingBeforeClosingSheet = false
    
    var focusTime: TimeInterval = 0
    var breakTime: TimeInterval = 0
    @Published var currentTime: TimeInterval = 0
    
    func startTimer(focusTime: TimeInterval, breakTime: TimeInterval) {
        self.focusTime = focusTime
        self.breakTime = breakTime
        self.currentTime = focusTime
        start()
    }
    
    func start() {
        isPlaying = true
        
        timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
            .sink { _ in
                if self.isPlaying {
                    if self.currentTime == 0 && !self.isBreakTime {
                        self.isBreakTime = true
                        self.currentTime = self.breakTime
                        
                        // Store the fact that music was playing when the break started
                        self.wasMusicPlayingBeforeBreak = true
                    } else if self.currentTime == 0 && self.isBreakTime {
                        self.isBreakTime = false
                        self.currentTime = self.focusTime
                        
                        if self.wasMusicPlayingBeforeBreak {
                            // Resume the music if it was playing before the break
                            self.wasMusicPlayingBeforeBreak = false
                        }
                    } else {
                        self.currentTime -= 1
                    }
                }
            }
    }
    
    func pause() {
        isPlaying = false
    }
    
    func reset() {
        isPlaying = false
        currentTime = 0
        isBreakTime = false
    }
    
    deinit {
        timer?.cancel()
    }
}





//import Foundation
//import Combine
//
//class GlobalTimerManager: ObservableObject {
//
//    var timer: AnyCancellable?
//
//    @Published var isPlaying = false
//    @Published var isBreakTime = false
//    @Published var wasMusicPlayingBeforeBreak = false
//
//    var focusTime: TimeInterval = 0
//    var breakTime: TimeInterval = 0
//    @Published var currentTime: TimeInterval = 0
//
//    func startTimer(focusTime: TimeInterval, breakTime: TimeInterval) {
//        self.focusTime = focusTime
//        self.breakTime = breakTime
//        self.currentTime = focusTime
//        start()
//    }
//
//    func start() {
//        isPlaying = true
//
//        timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
//            .sink { _ in
//                if self.isPlaying {
//                    if self.currentTime == 0 && !self.isBreakTime {
//                        self.isBreakTime = true
//                        self.currentTime = self.breakTime
//                    } else if self.currentTime == 0 && self.isBreakTime {
//                        self.isBreakTime = false
//                        self.currentTime = self.focusTime
//                    } else {
//                        self.currentTime -= 1
//                    }
//                }
//            }
//    }
//
//    func pause() {
//        isPlaying = false
//    }
//
//    func reset() {
//        isPlaying = false
//        currentTime = 0
//        isBreakTime = false
//    }
//
//    deinit {
//        timer?.cancel()
//    }
//}
