//
//  XDismissButton.swift
//  testing4
//
//  Created by Anton Polovoy on 6.11.24.
//

import SwiftUI

struct XDismissButton: View {
    var body: some View {
        Image(systemName: "xmark")
            .foregroundStyle(Color.black)
            .frame(width: 34, height: 34)
            .background(Color.white)
            .cornerRadius(17)
            .opacity(0.6)
            .padding(.top, 10)
            .padding(.trailing, 10)
    }
}

#Preview {
    XDismissButton()
}
