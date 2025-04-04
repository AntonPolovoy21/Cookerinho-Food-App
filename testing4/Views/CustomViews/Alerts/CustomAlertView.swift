//
//  CustomAlertView.swift
//  testing4
//
//  Created by Alex Polovoy on 28.03.25.
//

import SwiftUI

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
                withText: "Ошибка",
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
                withText: "Внимание!",
                withDetails: withDetails,
                withGradientColor: .yellow
            )
        }
    }
}
