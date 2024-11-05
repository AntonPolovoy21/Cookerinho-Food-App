//
//  LoadingView.swift
//  testing4
//
//  Created by Anton Polovoy on 5.11.24.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        ZStack {
            Color(.systemBackground)
                .ignoresSafeArea()
            
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: .accentColor))
                .scaleEffect(2)
        }
    }
}
