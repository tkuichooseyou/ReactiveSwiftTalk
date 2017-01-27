//
//  Reactive+Ext.swift
//  ReactiveSwiftTalk
//
//  Created by Teddy Ku on 1/26/17.
//  Copyright © 2017 Teddy Ku. All rights reserved.
//

import Foundation
import ReactiveSwift
import enum Result.NoError

extension Reactive where Base: UITextField {
	var editingDidEndValues: Signal<String, NoError> {
		return controlEvents(.editingDidEnd).map { $0.text ?? "" }
	}

	public var editingChangedValues: Signal<String, NoError> {
		return controlEvents(.editingChanged).map { $0.text ?? "" }
	}
}
