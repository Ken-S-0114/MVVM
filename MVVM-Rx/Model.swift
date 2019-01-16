//
//  Model.swift
//  MVVM-Rx
//
//  Created by 佐藤賢 on 2019/01/16.
//  Copyright © 2019 佐藤賢. All rights reserved.
//

import RxSwift

enum ModelError: Error {
    case invalidId
    case invalidPassword
    case inValidIdAndPassword
}

/*
Point: Model の protocol を作っておくことで
ViewModel が依存する Model を Test Double と置き換えやすくなり，ViewModel のテストが書きやすくなる．
 */
protocol ModelProtocol {
    // Point: 利便性を高めるために Observable で返却する
    func validate(idText: String?, passwordText: String?) -> Observable<Void>
}

final class Model: ModelProtocol {

    func validate(idText: String?, passwordText: String?) -> Observable<Void> {
        switch (idText, passwordText) {
        case (.none, .none):
            return Observable.error(ModelError.inValidIdAndPassword)
        case (.none, .some):
            return Observable.error(ModelError.invalidId)
        case (.some, .none):
            return Observable.error(ModelError.invalidPassword)
        case (let idText?, let passwordText?):
            switch (idText.isEmpty, passwordText.isEmpty) {
            case (true, true):
                return Observable.error(ModelError.inValidIdAndPassword)
            case (false, false):
                return Observable.just(())
            case (true, false):
                return Observable.error(ModelError.invalidId)
            case (false, true):
                return Observable.error(ModelError.invalidPassword)
            }
        }
    }

}
