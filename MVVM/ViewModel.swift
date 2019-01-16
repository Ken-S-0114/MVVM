//
//  ViewModel.swift
//  MVVM
//
//  Created by 佐藤賢 on 2019/01/15.
//  Copyright © 2019 佐藤賢. All rights reserved.
//

import UIKit

final class ViewModel {
    
    let changeText = Notification.Name("changeText")
    let changeColor = Notification.Name("changeColor")

    private let notificationCenter: NotificationCenter
    private let model: ModelProtocol

    init(notificationCenter: NotificationCenter, model: ModelProtocol = Model()) {
        self.notificationCenter = notificationCenter
        self.model = model
    }

    func idPasswordChanged(id: String?, password: String?) {
        let result = model.validate(idText: id, passwordText: password)

        switch result {
        case .success:
            notificationCenter.post(name: changeText, object: "OK!!")
            notificationCenter.post(name: changeColor, object: UIColor.green)
        case .failure(let error as ModelError):
            notificationCenter.post(name: changeText, object: error.errorText)
            notificationCenter.post(name: changeColor, object: UIColor.red)
        case .failure(_):
            fatalError("Unexpected pattern.")
        }
    }
}

extension ModelError {
    fileprivate var errorText: String {
        switch self {
        case .inValidIdAndPassword:
            return "IDとPasswordが未入力です．"
        case .invalidId:
            return "IDが未入力です．"
        case .invalidPassword:
            return "Passwordが未入力です．"
        }
    }
}
