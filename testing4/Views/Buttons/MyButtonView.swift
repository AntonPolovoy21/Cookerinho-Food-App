//
//  ButtonView.swift
//  testing4
//
//  Created by Anton Polovoy on 6.11.24.
//

import SwiftUI

struct MyButtonView: View {
    
    let title: LocalizedStringKey
    
    var body: some View {
        Text(title)
            .bold()
            .font(.title3)
            .frame(width: 280, height: 50)
            .foregroundStyle(Color.white)
            .background(Color.accent)
            .cornerRadius(10)
    }
}

#Preview {
    MyButtonView(title: "HI")
}
