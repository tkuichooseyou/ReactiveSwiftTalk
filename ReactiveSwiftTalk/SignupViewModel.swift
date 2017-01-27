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
    var emailTextSignal: Signal<String, NoError> = Signal.empty
    var passwordTextSignal: Signal<String, NoError> = Signal.empty
    var passwordConfirmTextSignal: Signal<String, NoError> = Signal.empty

    lazy private(set) var buttonEnabledSignal: Signal<Bool, NoError> = { [unowned self] in
        let notEmptySignals = [
            self.emailTextSignal.textIsNotEmpty,
            self.passwordTextSignal.textIsNotEmpty,
            self.passwordConfirmTextSignal.textIsNotEmpty
        ]
        return Signal
            .combineLatest(notEmptySignals)
            .map { $0.reduce(true) {$0 && $1} }
    }()

    lazy private(set) var buttonColorSignal: Signal<UIColor, NoError> = { [unowned self] in
        return self.buttonEnabledSignal.map { (enabled: Bool) -> UIColor in
            return (enabled ? .blue : .lightGray)
        }
    }()

    lazy private(set) var errorTextSignal: Signal<String, NoError> = { [unowned self] in
        self.buttonEnabledSignal.combineLatest(with: self.validationResultSignal).map { (buttonEnabled, validationResult) in
            return (buttonEnabled ? validationResult.errorString : "")
        }
    }()

    private lazy var validationResultSignal: Signal<ValidationResult, NoError> = { [unowned self] in
        let results = [
            self.emailTextSignal.map(Validator.validateEmail),
            self.passwordTextSignal.map(Validator.validatePasswordLength),
            self.passwordTextSignal.combineLatest(with: self.passwordConfirmTextSignal).map(Validator.validatePasswordsMatch)
        ]
        return Signal
            .combineLatest(results)
            .map { $0.reduce(.valid) { $0.combine($1)} }
    }()
}
