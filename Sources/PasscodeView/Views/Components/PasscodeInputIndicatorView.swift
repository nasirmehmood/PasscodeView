//
//  PasscodeInputIndicatorView.swift
//  SwiftUIPasscode
//
//  Created by Light on 23/01/2023.
//  
//

import SwiftUI

struct PasscodeInputIndicatorView {

    // MARK: - Properties

    @Binding var PasscodeInput: PasscodeInput

}

// MARK: - View

extension PasscodeInputIndicatorView: View {

    var body: some View {
        HStack(spacing: Constants.circlesSpacing) {
            ForEach(0 ..< PasscodeInput.passcodeLength) { index in
                self.view(for: self.PasscodeInput, at: index)
            }
        }
    }

}

// MARK: - Private methods

extension PasscodeInputIndicatorView {

    private func view(for PasscodeInput: PasscodeInput,
                      at index: Int) -> some View {
        Circle()
            .fill(Color.primary.opacity(index < PasscodeInput.inputLength
                ? Constants.backgroundEnteredOpacity
                : Constants.backgroundEmptyOpacity))
            .frame(width: Constants.circleSize.width,
                   height: Constants.circleSize.height,
                   alignment: .center)
    }

}

// MARK: - Constants

extension PasscodeInputIndicatorView {

    private enum Constants {
        static let backgroundEmptyOpacity: Double = 0.3
        static let backgroundEnteredOpacity: Double = 1.0
        static let circleSize: CGSize = .init(width: 16.0, height: 16.0)
        static let circlesSpacing: CGFloat = 10.0
    }

}

// MARK: - Preview

struct PasscodeInputIndicatorView_Previews: PreviewProvider {

    private struct PreviewContainer: View {

        @State private var input = PasscodeInput()

        var body: some View {
            PasscodeInputIndicatorView(PasscodeInput: $input)
        }

    }

    static var previews: some View {
        PreviewContainer()
    }
}
