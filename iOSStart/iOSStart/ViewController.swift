//
//  ViewController.swift
//  iOSStart
//
//  Created by David on 2017. 12. 26..
//  Copyright © 2017년 kanziw. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var countLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        countLabel.text = "0"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func addCount(value: Int) {
        if let countString = countLabel.text, let count = Int(countString) {
            countLabel.text = String(count + value)
        }
    }

    @IBAction func plusAction(_ sender: UIButton) { addCount(value: 1) }
    @IBAction func minusAction(_ sender: UIButton) { addCount(value: -1) }
}
