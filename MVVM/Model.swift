//
//  Model.swift
//  MVVM
//
//  Created by 佐藤賢 on 2019/01/15.
//  Copyright © 2019 佐藤賢. All rights reserved.
//

import Foundation

enum Result<T> {
    case success(T)
    case failure(Error)
}

enum ModelError: Error {
    case invalidId
    case invalidPassword
    case inValidIdAndPassword
}

protocol ModelProtocol {
    func validate(idText: String?, passwordText: String?) -> Result<Void>
}

final class Model: ModelProtocol {

    func validate(idText: String?, passwordText: String?) -> Result<Void> {
        switch (idText, passwordText) {
        case (.none, .none):
            return .failure(ModelError.inValidIdAndPassword)
        case (.none, .some):
            return .failure(ModelError.invalidId)
        case (.some, .none):
            return .failure(ModelError.invalidPassword)
        case (let idText?, let passwordText?):
            switch (idText.isEmpty, passwordText.isEmpty) {
            case (true, true):
                return .failure(ModelError.inValidIdAndPassword)
            case (false, false):
                return .success(())
            case (true, false):
                return .failure(ModelError.invalidId)
            case (false, true):
                return .failure(ModelError.invalidPassword)
            }
        }
    }
    
}
