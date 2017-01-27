//
//  SignupViewModel.swift
//  ReactiveSwiftTalk
//
//  Created by Teddy Ku on 1/20/17.
//  Copyright © 2017 Teddy Ku. All rights reserved.
//

import Foundation
import ReactiveSwift
import Result

final class SignupViewModel {
    let email = MutableProperty("")
    let password = MutableProperty("")
    let passwordConfirm = MutableProperty("")

    private var emailSignal: SignalProducer<String, NoError> { return email.producer }
    private var passwordSignal: SignalProducer<String, NoError> { return password.producer }
    private var passwordConfirmSignal: SignalProducer<String, NoError> { return passwordConfirm.producer }

    lazy private(set) var buttonEnabledSignal: SignalProducer<Bool, NoError> = { [unowned self] in
        let notEmptySignals = [
            self.emailSignal.textIsNotEmpty,
            self.passwordSignal.textIsNotEmpty,
            self.passwordConfirmSignal.textIsNotEmpty
        ]
        return SignalProducer
            .combineLatest(notEmptySignals)
            .map { $0.reduce(true) {$0 && $1} }
    }()

    lazy private(set) var buttonColorSignal: SignalProducer<UIColor, NoError> = { [unowned self] in
        return self.buttonEnabledSignal.map { (enabled: Bool) -> UIColor in
            return (enabled ? .blue : .lightGray)
        }
    }()

    lazy private(set) var errorTextSignal: SignalProducer<String, NoError> = { [unowned self] in
        self.buttonEnabledSignal.combineLatest(with: self.validationResultSignal).map { (buttonEnabled, validationResult) in
            return (buttonEnabled ? validationResult.errorString : "")
        }
    }()

    func loginTapped() {
        print("email: \(email.value)")
        print("password: \(password.value)")
    }

    private lazy var validationResultSignal: SignalProducer<ValidationResult, NoError> = { [unowned self] in
        let results = [
            self.emailSignal.map(Validator.validateEmail),
            self.passwordSignal.map(Validator.validatePasswordLength),
            self.passwordSignal.combineLatest(with: self.passwordConfirmSignal).map(Validator.validatePasswordsMatch)
        ]
        return SignalProducer
            .combineLatest(results)
            .map { $0.reduce(.valid) { $0.combine($1)} }
    }()
}
