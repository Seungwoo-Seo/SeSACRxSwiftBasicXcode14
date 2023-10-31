//
//  BasicViewController.swift
//  SeSACRxSwiftBasicXcode14
//
//  Created by 서승우 on 2023/10/25.
//

import RxCocoa
import RxSwift
import UIKit

class BasicViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var button: UIButton!


    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        basicTableView()
        basicButton()
        basicValidation()
        shareButton()
    }

    // bind: 메인 쓰레드 , Error x, completed x.  ui
    // drive: Bind + 스트림 공유
    func shareButton() {
        let sample = button.rx.tap
            .map { "안녕하세요 \(Int.random(in: 1...100))"}
            .asDriver(onErrorJustReturn: "")
//            .share()

        sample
            .drive(label.rx.text)
            .disposed(by: disposeBag)
        // 3곳에 공유하고 싶었는데 다 값이 달라짐
//        sample
//            .bind(to: label.rx.text)
//            .disposed(by: disposeBag)
//
//        sample
//            .bind(to: textField.rx.text)
//            .disposed(by: disposeBag)
//
//        sample
//            .bind(to: button.rx.title())
//            .disposed(by: disposeBag)
    }

    func basicValidation() {
        textField.rx.text
            .orEmpty
            .map { $0.count > 4 }
            .bind(to: button.rx.isEnabled)
            .disposed(by: disposeBag)
    }

    func basicButton() {
        button.rx.tap
            .observe(on: MainScheduler.instance) // 메인 쓰레드에서 동작하게끔 수정
            .subscribe { _ in   // next, complete, error 다 전달 가능 -> 서브스크라이브는 보장하지 않음
                print("클릭되었습니다.")
                self.label.text = "클릭되어씁니다"
                self.textField.text = "클릭되었습니ㅏㄷ"
            } onError: { error in
                print(error)
            } onCompleted: {
                print("Completed")
            } onDisposed: {
                print("Disposed")
            }
            .disposed(by: disposeBag)

        button.rx.tap
            .bind { _ in    // next 만 가능. 바인드는 메인 쓰레드 동작 보장
                print("클릭되었습니다.")
                self.label.text = "클릭되어씁니다"
                self.textField.text = "클릭되었습니ㅏㄷ"
            }
            .disposed(by: disposeBag)

        button.rx.tap
            .map {"클릭되었습니다"}
            .bind(to: label.rx.text, textField.rx.text)
            .disposed(by: disposeBag)
    }

    func basicTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        let items = Observable.just([
            "First Item",
            "Second Item",
            "Third Item"
        ])

        items
            .bind(to: tableView.rx.items) { (tableView, row, element) in
                let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
                cell.textLabel?.text = "\(element) @ row \(row)"
                return cell
            }
            .disposed(by: disposeBag)


        tableView.rx.modelSelected(String.self)
            .map { data in
                "\(data)를 클릭했어요."
            }
            .bind(to: label.rx.text)
            .disposed(by: disposeBag)
    }

}


