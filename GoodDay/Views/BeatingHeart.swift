//
//  BeatingHeart.swift
//  GoodDay
//
//  Created by Roman Zakharov on 11.11.2023.
//  Copyright © 2023 Apple. All rights reserved.
//

import SwiftUI

struct BeatingHeart: View {
    @State private var heartPulse: CGFloat = 1
    @State private var heartRate: CGFloat = 67

    var body: some View {
        ZStack {
            Image(systemName: "heart.fill")
                .resizable()
                .frame(width: 100, height: 100)
                .foregroundColor(.red)
                .scaleEffect(heartPulse)
                .shadow(color: .pink, radius: 10)
                .onAppear{
                    withAnimation(.easeInOut(duration: 0.5)
                        .repeatForever(autoreverses: true).speed(heartRate / 60.0)) {
                            heartPulse = 1.25 * heartPulse
                        }
                }

            Text(String(Int(heartRate)))
                .font(.title)
                .padding(.bottom, 15)
        }
        .frame(width: 100, height: 100)
    }
}

#Preview {
    BeatingHeart()
}
