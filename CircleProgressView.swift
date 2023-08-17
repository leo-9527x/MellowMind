//
//  CircleProgressView.swift
//  lofi-soundboard
//
//  Created by Robert Liu on 8/15/23.
//

import SwiftUI

struct CircleProgressView: View {
    @Binding var value: TimeInterval
    let maxValue: TimeInterval
    let lineWidth: CGFloat = 15

    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: lineWidth)
                .opacity(0.3)
                .foregroundColor(Color.white)

            Circle()
                .trim(from: 0.0, to: CGFloat(min(value / maxValue, 1.0)))
                .stroke(style: StrokeStyle(lineWidth: lineWidth, lineCap: .round, lineJoin: .round))
                .foregroundColor(Color.white)
                .rotationEffect(Angle(degrees: 270.0))
                .animation(.linear)

            Text("\(Int(value))s")
                .font(.title2)
                .bold()
                .foregroundColor(.white)
        }
    }
}

struct CircleProgressView_Previews: PreviewProvider {
    static var previews: some View {
        CircleProgressView(value: .constant(150), maxValue: 300)
    }
}




//import SwiftUI
//
//struct CircleProgressView: View {
//    @Binding var value: TimeInterval
//    let maxValue: TimeInterval
//    let lineWidth: CGFloat = 15
//
//    var body: some View {
//        ZStack {
//            Circle()
//                .stroke(lineWidth: lineWidth)
//                .opacity(0.3)
//                .foregroundColor(Color.white)
//
//            Circle()
//                .trim(from: 0.0, to: CGFloat(min(value / maxValue, 1.0)))
//                .stroke(style: StrokeStyle(lineWidth: lineWidth, lineCap: .round, lineJoin: .round))
//                .foregroundColor(Color.white)
//                .rotationEffect(Angle(degrees: 270.0))
//                .animation(.linear)
//
//            Text("\(Int(value))s")
//                .font(.title2)
//                .bold()
//                .foregroundColor(.white)
//        }
//    }
//}
//
//struct CircleProgressView_Previews: PreviewProvider {
//    static var previews: some View {
//        CircleProgressView(value: .constant(150), maxValue: 300)
//    }
//}
