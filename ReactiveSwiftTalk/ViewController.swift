//
//  ViewController.swift
//  ReactiveSwiftTalk
//
//  Created by Teddy Ku on 1/20/17.
//  Copyright © 2017 Teddy Ku. All rights reserved.
//

import UIKit
import Stevia
import ReactiveSwift

class ViewController: UIViewController {
    private let signupView = SignupView()

    override func viewDidLoad() {
        super.viewDidLoad()
        render()
        bindViewModel()
    }

    private func render() {
        view.sv(
            signupView
        )
        view.layout(
            signupView.fillContainer()
        )
    }

    private func bindViewModel() {
        signupView.viewModel.alertSignal
            .observe(on: UIScheduler())
            .observeValues { [weak self] alertString in
                let alertController = UIAlertController(title: alertString, message: nil, preferredStyle: .alert)
                let okayAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                alertController.addAction(okayAction)
                self?.present(alertController, animated: true, completion: nil)
        }
        
    }

}

