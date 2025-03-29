//
//  LogOutButton.swift
//  testing4
//
//  Created by Alex Polovoy on 29.03.25.
//

import SwiftUI

struct XLogOutButton: View {
    var body: some View {
        Image(systemName: "door.left.hand.open")
            .foregroundStyle(Color.red)
            .frame(width: 40, height: 40)
            .imageScale(.large)
            .background(Color.white)
            .cornerRadius(20)
            .padding(.top, 10)
            .padding(.trailing, 10)
            .shadow(radius: 20)
    }
}

#Preview {
    XLogOutButton()
}
