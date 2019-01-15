//
//  ViewController.swift
//  MVVM
//
//  Created by 佐藤賢 on 2019/01/15.
//  Copyright © 2019 佐藤賢. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet private weak var idTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var validationLabel: UILabel!

    private let notificationCenter = NotificationCenter()

    private lazy var viewModel = ViewModel(notificationCenter: notificationCenter)

    override func viewDidLoad() {
        super.viewDidLoad()

        idTextField.addTarget(self, action: #selector(textFieldEditingChanged), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(textFieldEditingChanged), for: .editingChanged)
    }


}

extension ViewController {
    @objc func textFieldEditingChanged(sender: UITextField) {

    }

    @objc func updateValidationText(notification: Notification) {

    }
}

