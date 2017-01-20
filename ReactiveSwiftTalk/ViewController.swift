//
//  ViewController.swift
//  ReactiveSwiftTalk
//
//  Created by Teddy Ku on 1/20/17.
//  Copyright © 2017 Teddy Ku. All rights reserved.
//

import UIKit
import Stevia

class ViewController: UIViewController {
    private let signupView = SignupView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.sv(
            signupView
        )
        view.layout(
            signupView.fillContainer()
        )
    }

}

