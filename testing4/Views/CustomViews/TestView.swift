//
//  TestView.swift
//  testing4
//
//  Created by Alex Polovoy on 18.02.25.
//

import SwiftUI

struct TestView: View {
    
    @State var show1 = false
    @State var show2 = false
    @State var show3 = false
    
    var body: some View {
        ZStack {
            HStack(spacing: 20) {
                Button(action: {
                    withAnimation {
                        show3 = false
                        show2 = false
                        show1 = true
                    }
                }, label: {
                    Text("Error")
                })
                
                Button(action: {
                    withAnimation {
                        show3 = false
                        show2 = true
                        show1 = false
                    }
                }, label: {
                    Text("Ok")
                })
                
                Button(action: {
                    withAnimation {
                        show3 = true
                        show2 = false
                        show1 = false
                    }
                }, label: {
                    Text("Warning")
                })
            }
            
            CustomAlertView(wrappedState: $show1, withDetails: .constant("Some text goes here."), type: .error)
            CustomAlertView(wrappedState: $show2, withDetails: .constant("Some text goes here."), type: .ok)
            CustomAlertView(wrappedState: $show3, withDetails: .constant("Some text goes here."), type: .warning)
        }
        
        
    }
}

#Preview {
    TestView()
}

struct CustomAlertView: View {
    @Binding var wrappedState: Bool
    @Binding var withDetails: String
    let type: CustomAlertType
    
    var body: some View {
        switch type {
        case .error:
            CustomAlert(
                show: $wrappedState,
                withIconName: "xmark.circle.fill",
                withText: "ERROR",
                withDetails: withDetails,
                withGradientColor: .red
            )
        case .ok:
            CustomAlert(
                show: $wrappedState,
                withIconName: "checkmark.circle.fill",
                withText: "OK",
                withDetails: withDetails,
                withGradientColor: .green
            )
        case .warning:
            CustomAlert(
                show: $wrappedState,
                withIconName: "exclamationmark.circle.fill",
                withText: "WARNING!",
                withDetails: withDetails,
                withGradientColor: .yellow
            )
        }
    }
}

enum CustomAlertType {
    case error
    case ok
    case warning
}
