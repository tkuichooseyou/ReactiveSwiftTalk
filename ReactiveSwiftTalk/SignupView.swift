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

final class SignupView: UIView {
    private let email = UITextField()
    private let password = UITextField()
    private let signupButton = UIButton()

    convenience init() {
        self.init(frame: .zero)
        render()
    }

    private func render() {
        backgroundColor = .white

        sv(
            email.placeholder("Email").style(fieldStyle),
            password.placeholder("Password").style(fieldStyle).style(passwordFieldStyle),
            signupButton.text("Sign up").style(buttonStyle).tap(loginTapped)
        )

        layout(
            100,
            |-email-| ~ 80,
            8,
            |-password-| ~ 80,
            "",
            |signupButton| ~ 80,
            0
        )

    }

    func fieldStyle(f: UITextField) {
        f.borderStyle = .roundedRect
        f.font = UIFont(name: "HelveticaNeue-Light", size: 26)
        f.returnKeyType = .next
    }

    func passwordFieldStyle(f: UITextField) {
        f.isSecureTextEntry = true
        f.returnKeyType = .done
    }

    func buttonStyle(b: UIButton) {
        b.backgroundColor = .lightGray
    }

    func loginTapped() {
        //Do something
    }

    func injected() {
        render()
    }
}
