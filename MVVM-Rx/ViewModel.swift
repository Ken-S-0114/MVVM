//
//  ViewModel.swift
//  MVVM-Rx
//
//  Created by 佐藤賢 on 2019/01/16.
//  Copyright © 2019 佐藤賢. All rights reserved.
//

import UIKit
import RxSwift

final class ViewModel {
    
    let validationText: Observable<String>
    let loadLabelColor: Observable<UIColor>

    init(idTextObservable: Observable<String?>,
         passwordTextObservable: Observable<String?>,
         model: ModelProtocol) {
        let event = Observable
            // ID とパスワードそれぞれで変更があったとき，共通の処理を呼び出す.
            .combineLatest(idTextObservable, passwordTextObservable)
            // skip(1) すれば最初の現在値を無視して，変化だけを監視することができる．
            .skip(1)
            // イベントを Observable に変換した上で，それを並列実行して発行するイベントをマージ( map + merge )
            .flatMap { idText, passwordText -> Observable<Event<Void>> in
                return model.validate(idText: idText, passwordText: passwordText)
                    // Observable<Event<Void>> へ変換
                    // → のちに View に出力する情報の条件（分岐）として利用するため
                    .materialize()
            }
            .share()

        self.validationText = event
            .debug()
            // flatMap(_:) に入力されるイベント(onNext，onError)に応じて View に出力する情報を加工し，更新している．
            .flatMap { event -> Observable<String> in
                switch event {
                case .next:
                    return .just("OK!!!")
                case let .error(error as ModelError):
                    return .just(error.errorText)
                case .error, .completed:
                    return .empty()
                }
            }
            .startWith("IDとPasswordを入力してください．")

        self.loadLabelColor = event
            .flatMap { event -> Observable<UIColor> in
                switch event {
                case .next:
                    return .just(.green)
                case .error:
                    return .just(.red)
                case .completed:
                    return .empty()
                }
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
