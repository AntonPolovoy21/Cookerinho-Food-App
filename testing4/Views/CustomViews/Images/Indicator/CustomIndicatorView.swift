//
//  CustomIndicatorView.swift
//  testing4
//
//  Created by Alex Polovoy on 4.04.25.
//

import SwiftUI

struct CustomIndicatorView: View {
    let type: CustomAlertType
    
    var body: some View {
        switch type {
        case .error:
            CustomIndicator(withIconName: "xmark.circle.fill", withGradientColor: .red)
        case .ok:
            CustomIndicator(withIconName: "checkmark.circle.fill", withGradientColor: .green)
        case .warning:
            CustomIndicator(withIconName: "exclamationmark.circle.fill", withGradientColor: .yellow)
        }
    }
}

#Preview {
    CustomIndicatorView(type: .ok)
}
