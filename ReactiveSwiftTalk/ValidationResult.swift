//
//  ValidationResult.swift
//  ReactiveSwiftTalk
//
//  Created by Teddy Ku on 1/20/17.
//  Copyright © 2017 Teddy Ku. All rights reserved.
//

import Foundation

enum ValidationResult {
    case valid
    case invalid([Validator.Error])

    func combine(_ result: ValidationResult) -> ValidationResult {
        switch (self, result) {
        case (.valid, .valid): return .valid
        case (.invalid(let errors), .valid): return .invalid(errors)
        case (.valid, .invalid(let errors)): return .invalid(errors)
        case (.invalid(let lhsErrors), .invalid(let rhsErrors)): return .invalid(lhsErrors + rhsErrors)
        }
    }

    var errorString: String {
        switch self {
        case .valid: return ""
        case let .invalid(errors): return errors.first?.description ?? ""
        }
    }

}

extension ValidationResult: Equatable { }

func == (lhs: ValidationResult, rhs: ValidationResult) -> Bool {
    switch (lhs, rhs) {
    case (.valid, .valid):
        return true
    case (.invalid(_), .invalid(_)):
        return true
    default:
        return false
    }
}
