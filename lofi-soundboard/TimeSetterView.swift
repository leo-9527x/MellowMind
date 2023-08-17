import SwiftUI

struct TimeSetterView: View {
    @Binding var totalSeconds: TimeInterval

    let maxHours = 23
    let maxMinutesAndSeconds = 59

    @State private var hours: Int = 0
    @State private var minutes: Int = 0
    @State private var seconds: Int = 0

    var body: some View {
        HStack {
            Picker("Hours", selection: $hours) {
                ForEach(0...maxHours, id: \.self) {
                    Text("\($0)h")
                }
            }
            .labelsHidden()
            .pickerStyle(WheelPickerStyle())
            .frame(width: 80, height: 150)

            Picker("Minutes", selection: $minutes) {
                ForEach(0...maxMinutesAndSeconds, id: \.self) {
                    Text("\($0)m")
                }
            }
            .labelsHidden()
            .pickerStyle(WheelPickerStyle())
            .frame(width: 80, height: 150)

            Picker("Seconds", selection: $seconds) {
                ForEach(0...maxMinutesAndSeconds, id: \.self) {
                    Text("\($0)s")
                }
            }
            .labelsHidden()
            .pickerStyle(WheelPickerStyle())
            .frame(width: 80, height: 150)
        }
        .onChange(of: hours) { _ in updateTotalSeconds() }
        .onChange(of: minutes) { _ in updateTotalSeconds() }
        .onChange(of: seconds) { _ in updateTotalSeconds() }
    }

    func updateTotalSeconds() {
        totalSeconds = TimeInterval((hours * 3600) + (minutes * 60) + seconds)
    }
}




//
//import SwiftUI
//
//struct TimeSetterView: View {
//    @Binding var totalSeconds: TimeInterval
//
//    let maxHours = 23
//    let maxMinutesAndSeconds = 59
//
//    @State private var hours: Int = 0
//    @State private var minutes: Int = 0
//    @State private var seconds: Int = 0
//
//    var body: some View {
//        HStack {
//            Picker("Hours", selection: $hours) {
//                ForEach(0...maxHours, id: \.self) {
//                    Text("\($0)h")
//                }
//            }
//            .labelsHidden() // Hide the "Hours" label
//            .pickerStyle(WheelPickerStyle())
//            .frame(width: 80, height: 150)
//
//            Picker("Minutes", selection: $minutes) {
//                ForEach(0...maxMinutesAndSeconds, id: \.self) {
//                    Text("\($0)m")
//                }
//            }
//            .labelsHidden()
//            .pickerStyle(WheelPickerStyle())
//            .frame(width: 80, height: 150)
//
//            Picker("Seconds", selection: $seconds) {
//                ForEach(0...maxMinutesAndSeconds, id: \.self) {
//                    Text("\($0)s")
//                }
//            }
//            .labelsHidden()
//            .pickerStyle(WheelPickerStyle())
//            .frame(width: 80, height: 150)
//        }
//        .onChange(of: hours) { _ in updateTotalSeconds() }
//        .onChange(of: minutes) { _ in updateTotalSeconds() }
//        .onChange(of: seconds) { _ in updateTotalSeconds() }
//    }
//
//    func updateTotalSeconds() {
//        totalSeconds = TimeInterval((hours * 3600) + (minutes * 60) + seconds)
//    }
//}

