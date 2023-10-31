//
//  SimpleNumbersViewController.swift
//  SeSACRxSwiftBasicXcode14
//
//  Created by 서승우 on 2023/11/01.
//

import RxCocoa
import RxSwift
import UIKit

final class SimpleNumbersViewController: UIViewController {
    @IBOutlet weak var number1: UITextField!
    @IBOutlet weak var number2: UITextField!
    @IBOutlet weak var number3: UITextField!

    @IBOutlet weak var result: UILabel!

    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        Observable.combineLatest(
            number1.rx.text.orEmpty,
            number2.rx.text.orEmpty,
            number3.rx.text.orEmpty
        ) { textValue1, textValue2, textValue3 -> Int in
            return (Int(textValue1) ?? 0) + (Int(textValue2) ?? 0) + (Int(textValue3) ?? 0)
        }
        .map { $0.description }
        .bind(to: result.rx.text)
        .disposed(by: disposeBag)
    }

}
