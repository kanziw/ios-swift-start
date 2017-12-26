//
//  ViewController.swift
//  iOSStart
//
//  Created by David on 2017. 12. 26..
//  Copyright © 2017년 kanziw. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class CounterViewController: UIViewController {
    var value = Variable(0)
    var disposeBag = DisposeBag()
    
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var plusButton: UIButton!
    @IBOutlet weak var minusButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "COUNTER"
        
        value.asObservable()
            .map(String.init)
            .bind(to: countLabel.rx.text)
            .disposed(by:disposeBag)
        
        plusButton.rx.tap.asObservable().map({1}).subscribe(onNext: addCount).disposed(by: disposeBag)
        minusButton.rx.tap.asObservable().map({-1}).subscribe(onNext: addCount).disposed(by: disposeBag)
    }
    
    func addCount(adder: Int) { value.value = value.value + adder }
}
