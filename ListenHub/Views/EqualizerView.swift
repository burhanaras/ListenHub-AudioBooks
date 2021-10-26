//
//  EqualizerView.swift
//  ListenHub
//
//  Created by Burhan Aras on 26.10.2021.
//

import SwiftUI

struct EqualizerView: View {
    var barCount: Int
    var hasFrame: Bool = true
    var color = Color.primary
    @State var values: [CGFloat] = [80, 60, 40, 60, 60, 40, 60, 80, 80, 60, 40, 60, 60, 40, 60, 80]
    @Binding var isPlaying: Bool
    
    private let timer = Timer.publish(every: 0.1,  on: .main, in: .common).autoconnect()
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .center) {
                
                if hasFrame {
                    let borderWidth = geometry.size.width * 0.3  / CGFloat(barCount)
                    Circle()
                        .foregroundColor(.secondary.opacity(0))
                        .frame(width: geometry.size.height, height: geometry.size.height, alignment: .center)
                        .overlay(Circle().stroke(color, lineWidth: borderWidth))
                        .shadow(radius: 10)
                    
                }
                
                let mult = geometry.size.height / 125
                HStack(spacing: 2){
                    ForEach(0..<barCount, id: \.self){ index in
                        BarView(height: values[index] * mult,
                                width: geometry.size.width * 0.3  / CGFloat(barCount),
                                color: color)
                    }
                }
            }
            .onReceive(timer, perform: { _ in
                
                if !isPlaying{
                    values = [60, 40, 50, 20]
                    return
                }
                let slice1 = values[..<1]
                let slice2 = values[1...]
                values = Array(slice2) + Array(slice1)
            })
        }
    }
}

struct BarView: View {
    var height: CGFloat
    var width: CGFloat
    var color: Color = Color.primary
    
    var body: some View {
        RoundedRectangle(cornerRadius: 8)
            .frame(width: width, height: height, alignment: .center)
            .foregroundColor(color)
    }
}

struct EqualizerView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            EqualizerView(barCount:4, color: Color.blue, isPlaying: .constant(true))
                .frame(width: 24, height: 24, alignment: .center)
            
            EqualizerView(barCount:4, isPlaying: .constant(true))
                .frame(width: 24, height: 24, alignment: .center)
                .preferredColorScheme(.dark)
            
            HStack {
                BarView(height: 40, width: 8)
                BarView(height: 60, width: 8)
                BarView(height: 80, width: 8)
            }
        }
    }
}

