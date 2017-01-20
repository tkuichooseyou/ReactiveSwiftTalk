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

    lazy private(set) var actionButtonEnabledSignal: Signal<Bool, NoError> = { [unowned self] in
        let notEmptySignals: [Signal<Bool, NoError>] = [
            self.emailTextSignal.textIsNotEmpty,
            self.passwordTextSignal.textIsNotEmpty,
            self.passwordConfirmTextSignal.textIsNotEmpty
        ]
        return Signal
            .combineLatest(notEmptySignals)
            .map { $0.reduce(true) {$0 && $1} }
    }()

    lazy private(set) var actionButtonColorSignal: Signal<UIColor, NoError> = { [unowned self] in
        return self.actionButtonEnabledSignal.map { (enabled: Bool) -> UIColor in
            return (enabled ? .blue : .lightGray)
        }
    }()

}
