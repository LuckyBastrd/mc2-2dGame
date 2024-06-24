//
//  RainfallView.swift
//  BitRayed
//
//  Created by Ali Haidar on 20/06/24.
//

import SwiftUI

struct Raindrop: View {
    var body: some View {
        Capsule()
            .fill(Color.white)
            .frame(width: 2, height: 40)
    }
}

struct RainfallView: View {
    let numberOfDrops = 100
    @State private var animate = false

    var body: some View {
            ZStack {
                Color.black
                ForEach(0..<numberOfDrops, id: \.self) { _ in
                    Raindrop()
                        .offset(x: CGFloat.random(in: -200...200), y: animate ? 800 : -800)
                        .animation(
                            .linear(duration: Double.random(in: 1.0...2.0))
                                .repeatForever(autoreverses: false)
                                .delay(Double.random(in: 0...1)),
                            value: animate
                        )
                }
            }
            .ignoresSafeArea()
            .onAppear {
                withAnimation {
                    self.animate = true
                }
            }
        }
}

#Preview {
    RainfallView()
}
