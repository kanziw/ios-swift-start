//
//  ViewController.swift
//  iOSStart
//
//  Created by David on 2017. 12. 26..
//  Copyright © 2017년 kanziw. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var value = 0 {
        didSet {
            countLabel.text = String(value)
        }
    }

    @IBOutlet weak var countLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func addCount(adder: Int) {
        value = value + adder
    }

    @IBAction func plusAction(_ sender: UIButton) { addCount(adder: 1) }
    @IBAction func minusAction(_ sender: UIButton) { addCount(adder: -1) }
}
