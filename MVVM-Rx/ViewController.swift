//
//  ViewController.swift
//  MVVM-Rx
//
//  Created by 佐藤賢 on 2019/01/16.
//  Copyright © 2019 佐藤賢. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class ViewController: UIViewController {

    @IBOutlet private weak var idTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var validationLabel: UILabel!

    private lazy var viewModel = ViewModel(
        idTextObservable: idTextField.rx.text.asObservable(),
        passwordTextObservable: passwordTextField.rx.text.asObservable(),
        model: Model())

    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.validationText
        .bind(to: validationLabel.rx.text)
        .disposed(by: disposeBag)

        viewModel.loadLabelColor
        .bind(to: loadLabelColor)
        .disposed(by: disposeBag)
    }

    // rx 拡張の無いプロパティを更新（UILabel の textColor）
    private var loadLabelColor: Binder<UIColor> {
        return Binder(self) { me, color in
            me.validationLabel.textColor = color
        }
    }
}

