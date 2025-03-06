//
//  CustomAlert.swift
//  testing4
//
//  Created by Alex Polovoy on 18.02.25.
//

import SwiftUI

struct CustomAlert: View {
    @Binding var show: Bool
    @State private var animateCircle = false
    
    private let iconName: String
    private let text: String
    private let details: String
    private let gradientColor: Color
    private let corner: CGFloat
    
    init(show: Binding<Bool>,
         withIconName iconName: String,
         withText text: String,
         withDetails details: String,
         withGradientColor gradientColor: Color,
         withCorner corner: CGFloat = 30) {
        self._show = show
        self.iconName = iconName
        self.text = text
        self.details = details
        self.gradientColor = gradientColor
        self.corner = corner
    }
    
    var body: some View {
        VStack {
            Spacer()
            ZStack {
                RoundedRectangle(cornerRadius: corner)
                    .frame(height: 300)
                    .foregroundStyle(LinearGradient(gradient: Gradient(colors: [.clear, .clear, gradientColor]), startPoint: .top, endPoint: .bottom))
                    .opacity(0.4)
                    .offset(y: show ? 0 : 300)
                ZStack {
                    RoundedRectangle(cornerRadius: corner)
                        .foregroundStyle(.white)
                        .frame(height: 280)
                        .shadow(color: .black.opacity(0.05), radius: 20)
                        .shadow(color: .black.opacity(0.2), radius: 30)
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
                        Text(text)
                            .bold()
                            .font(.system(size: 30))
                            .foregroundColor(.black)

                        Text(details)
                            .opacity(0.5)
                            .foregroundColor(.black)
                    }
                }
                .padding(.horizontal, 10)
                .offset(y: show ? -30 : 300)
            }
            .onChange(of: show) { oldValue, newValue in
                if newValue {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                        withAnimation {
                            show = false
                        }
                    }
                }
            }
        }
        .ignoresSafeArea()
    }
}

#Preview {
    CustomAlertView(wrappedState: .constant(true), withDetails: .constant("Some text goes here."), type: .warning)
}
