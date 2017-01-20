//
//  SignupView.swift
//  ReactiveSwiftTalk
//
//  Created by Teddy Ku on 1/20/17.
//  Copyright © 2017 Teddy Ku. All rights reserved.
//

import Foundation
import UIKit
import Stevia
import ReactiveSwift
import ReactiveCocoa

final class SignupView: UIView {
    private let email = UITextField()
    private let password = UITextField()
    private let passwordConfirm = UITextField()
    private let errorLabel = UILabel()
    private let signupButton = UIButton()
    private let viewModel = SignupViewModel()

    convenience init() {
        self.init(frame: .zero)
        render()
        bindViewModel()
    }

    private func bindViewModel() {
        viewModel.emailTextSignal = email.reactive.continuousTextValues.map { $0 ?? "" }
        viewModel.passwordTextSignal = password.reactive.continuousTextValues.map { $0 ?? "" }
        viewModel.passwordConfirmTextSignal = passwordConfirm.reactive.continuousTextValues.map { $0 ?? "" }
        signupButton.reactive.isEnabled <~ viewModel.actionButtonEnabledSignal
        signupButton.reactive.backgroundColor <~ viewModel.actionButtonColorSignal
    }

    private func render() {
        backgroundColor = .white

        sv(
            email.placeholder("Email").style(fieldStyle),
            password.placeholder("Password").style(fieldStyle).style(passwordFieldStyle),
            passwordConfirm.placeholder("Confirm Password").style(fieldStyle).style(passwordFieldStyle),
            errorLabel.style(errorLabelStyle),
            signupButton.text("Sign up").style(buttonStyle).tap(loginTapped)
        )

        layout(
            100,
            |-email-| ~ 80,
            8,
            |-password-| ~ 80,
            8,
            |-passwordConfirm-| ~ 80,
            8,
            |-errorLabel-| ~ 80,
            "",
            |signupButton| ~ 80,
            0
        )

    }

    private func fieldStyle(f: UITextField) {
        f.borderStyle = .roundedRect
        f.font = UIFont(name: "HelveticaNeue-Light", size: 26)
        f.autocorrectionType = .no
        f.autocapitalizationType = .none
        f.returnKeyType = .next
    }

    private func passwordFieldStyle(f: UITextField) {
        f.isSecureTextEntry = true
        f.returnKeyType = .done
    }

    private func errorLabelStyle(l: UILabel) {
        l.textColor = .red
    }

    private func buttonStyle(b: UIButton) {
        b.backgroundColor = .lightGray
    }

    private func loginTapped() {
        print("loginTapped")
    }

    func injected() {
        render()
    }
}
