//
//  TodoListViewController.swift
//  iOSStart
//
//  Created by David on 2017. 12. 26..
//  Copyright © 2017년 kanziw. All rights reserved.
//

import UIKit

class TodoListViewController: UIViewController {
    var todoList = Array<String>()
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var stackViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "TO-DO LIST"
        
        // hide bottom line
        tableView.tableFooterView = UIView()
        
        NotificationCenter.default.addObserver(self, selector: #selector(willShowKeyboard(_:)), name: .UIKeyboardWillShow, object: nil)
    }
    
    @objc func willShowKeyboard(_ noti: Notification) {
        //        print("Keyboard will show \(noti.userInfo)")
        guard let userInfo = noti.userInfo, let duration = userInfo[UIKeyboardAnimationDurationUserInfoKey] as? Double, let keyboardFrame = userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue else {
            return
        }
        let height = keyboardFrame.cgRectValue.height
        
        //        let tabBarHeight = UITabBar().frame.height    // 0 으로 값이 나옴
        let tabBarHeight = ((UIApplication.shared.delegate as? AppDelegate)?.window?.rootViewController as? UITabBarController)?.tabBar.frame.height ?? 0.0
        UIView.animate(withDuration: duration) {
            self.stackViewBottomConstraint.constant = self.stackViewBottomConstraint.constant + height - tabBarHeight
            self.view.setNeedsDisplay() // constranit 를 수정하면 내가 바뀌었다고 알려야 함
        }
    }
    
    @IBAction func saveButtonAction(_ sender: UIButton) {
        guard let currentText = textField?.text else {
            return
        }
        if (!currentText.isEmpty) {
            todoList.append(currentText)
            textField.text = ""
            tableView.reloadData()
        }
    }
}

extension TodoListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = todoList[indexPath.row]
        return cell
    }
}
