//
//  PasscodeView.swift
//  SwiftUIPasscode
//
//  Created by Light on 23/01/2023.
//  
//

import SwiftUI

public struct PasscodeView {

    // MARK: - Properties

    @State private var passcodeInput = PasscodeInput()
    @State var loginAttempts: Int = 0

    public var passcodeValidationCallback: ((String) -> Bool)
    
    public init(_ callback: @escaping ((String) -> Bool)) {
        self.passcodeValidationCallback = callback
    }
}

// MARK: - View

extension PasscodeView: View {

    public var body: some View {
        VStack(spacing: 40.0) {
            PasscodeInputIndicatorView(PasscodeInput: $passcodeInput)
                .modifier(Shake(animatableData: CGFloat(loginAttempts)))
                .onChange(of: passcodeInput.isComplete) { isComplete in
                    if isComplete {
                        let isValid = passcodeValidationCallback(passcodeInput.input)
                        if !isValid {
                            invalidPasscode()
                        }
                    }
                }
            PasscodeKeyboardView(PasscodeInput: $passcodeInput)
            HStack {
                Button(action: {
                    withAnimation {
                        self.eraseOrCancel()
                    }
                }, label: {
                    Text("Clear")
                })
            }
        }
        .preferredColorScheme(.dark)
    }

}

// MARK: - Private methods

extension PasscodeView {
    
    private func invalidPasscode() {
        withAnimation {
            self.loginAttempts += 1
            self.eraseOrCancel()
        }
    }
    
    private func eraseOrCancel() {
        passcodeInput.clear()
    }
}
