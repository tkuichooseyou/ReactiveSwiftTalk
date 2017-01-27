//
//  String+Ext.swift
//  ReactiveSwiftTalk
//
//  Created by Teddy Ku on 1/20/17.
//  Copyright © 2017 Teddy Ku. All rights reserved.
//

import Foundation
import ReactiveSwift
import Result

extension SignalProducerProtocol where Value == String, Error == NoError {
    var textIsNotEmpty: SignalProducer<Bool, NoError> {
        return map { (string: String) -> Bool in
            return string != ""
        }
    }
    
}
