//
//  ViewModel.swift
//  MVVM
//
//  Created by 佐藤賢 on 2019/01/15.
//  Copyright © 2019 佐藤賢. All rights reserved.
//

import Foundation

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
    }
}
