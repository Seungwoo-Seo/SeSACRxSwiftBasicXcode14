//
//  SimpleTableViewViewController.swift
//  SeSACRxSwiftBasicXcode14
//
//  Created by 서승우 on 2023/11/01.
//

import RxCocoa
import RxSwift
import UIKit

final class SimpleTableViewViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        let items = Observable.just(
            (0..<20).map { "\($0)" }
        )

        items.bind(to: tableView.rx.items(
            cellIdentifier: "Cell",
            cellType: UITableViewCell.self
        )) { row, element, cell in
            cell.textLabel?.text = "\(element) @ row \(row)"
        }
        .disposed(by: disposeBag)

        tableView.rx
            .modelSelected(String.self)
            .subscribe(onNext: { [weak self] in
                guard let self else {return}
                self.presentAlert("\($0)")
            })
            .disposed(by: disposeBag)

        tableView.rx
            .itemAccessoryButtonTapped
            .subscribe(onNext: { [weak self] (indexPath) in
                guard let self else {return}
                self.presentAlert("Tapped Detail @ \(indexPath.section), \(indexPath.row)")
            })
            .disposed(by: disposeBag)
    }

    func presentAlert(_ title: String) {
        let alert = UIAlertController(
            title: title,
            message: nil,
            preferredStyle: .alert
        )
        let confirm = UIAlertAction(
            title: "확인",
            style: .default
        )
        alert.addAction(confirm)
        present(alert, animated: true)
    }

}
