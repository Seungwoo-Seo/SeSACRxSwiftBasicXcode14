//
//  RxViewController.swift
//  SeSACRxSwiftBasicXcode14
//
//  Created by jack on 2023/10/23.
//

import UIKit
import RxCocoa
import RxSwift

class RxViewController: UIViewController {
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var changeButton: UIButton!
//    var nickname = Observable.just("고래밥")
    var nickname = BehaviorSubject(value: "고래밥")
    
    @IBOutlet var timerLabel: UILabel!
    
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        nickname
//            .bind(to: nameLabel.rx.text, timerLabel.rx.text)
//            .disposed(by: disposeBag)
//
//
//        changeButton.rx.tap
//            .subscribe { value in
//                print("버튼 클릭 \(value)")
//                //nickname -> 값을 주고 싶은데 Observable은 값을 변경할 수 없다?
//                self.nickname.onNext("버튼 클릭 \(Int.random(in: 1...100))")
//            } onError: { error in
//                print("changeButton - onError")
//            } onCompleted: {
//                print("changeButton - onCompleted")
//            } onDisposed: {
//                print("changeButton - Disposed")
//            }
//            .disposed(by: disposeBag)
//
//        Observable<Int>.interval(.seconds(1), scheduler: MainScheduler.instance)
//            .subscribe { value in
//                print("value")
//                self.timerLabel.text = "\(value)"
//            } onError: { error in
//                print("interval - \(error)")
//            } onCompleted: {
//                print("interval completed")
//            } onDisposed: {
//                print("interval disposed")
//            }
//            .disposed(by: disposeBag)   // 수동으로 처리해주어야 할 때도 있음!
//
//        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
//            // 수동으로 처리해주어야 할 땐 기존 disposeBag에 새로운 DisposeBag 인스턴스를 대입해주면 된다.
//            self.disposeBag = DisposeBag()
//        }
        sample()
    }

    func sample() {
        // just - 하나만
        // of - 여러개
        // from - 컬렉션 순회
        // repeatElement - 반복
        // take - 처음부터 n개까지만
        let item = [2,3,4,5,6,7,8,100]
        let item2 = [3,5,7]
        Observable.repeatElement(item)
            .take(5)
            .subscribe { value in
                print("subscribe - \(value)")
            } onError: { error in
                print("error - \(error)")
            } onCompleted: {
                print("onCompleted")
            } onDisposed: {
                print("onDisposed")
            }
            .disposed(by: disposeBag)
    }
}
