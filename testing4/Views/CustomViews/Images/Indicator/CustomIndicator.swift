//
//  CustomIndicator.swift
//  testing4
//
//  Created by Alex Polovoy on 4.04.25.
//

import SwiftUI


struct CustomIndicator: View {
    @State private var animateCircle = false
    
    private let iconName: String
    private let gradientColor: Color
    
    init(withIconName iconName: String,
         withGradientColor gradientColor: Color) {
        self.iconName = iconName
        self.gradientColor = gradientColor
    }
    
    var body: some View {
        VStack {
            VStack(spacing: 20) {
                ZStack {
                    Circle().stroke(lineWidth: 5).foregroundStyle(gradientColor)
                        .frame(width: 105, height: 105)
                        .scaleEffect(animateCircle ? 1.3 : 0.9)
                        .opacity(animateCircle ? 0 : 1)
                        .animation(.easeInOut(duration: 2).delay(1.2).repeatForever(autoreverses: false), value: animateCircle)
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                animateCircle = true
                            }
                        }
                    
                    Image(systemName: iconName)
                        .resizable()
                        .frame(width: 105, height: 105)
                        .foregroundStyle(gradientColor)
                        .symbolEffect(.bounce.down.byLayer, options: .speed(0.5), value: animateCircle)
                    
                }
            }
        }
    }
}


#Preview {
    CustomIndicator(withIconName: "xmark.circle.fill", withGradientColor: .red)
}
