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
    var orgBottomStackViewConstraint:CGFloat?
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var stackViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "TO-DO LIST"
        
        // hide bottom line
        tableView.tableFooterView = UIView()
        
        NotificationCenter.default.addObserver(self, selector: #selector(willShowKeyboard(_:)), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(willHideKeyboard(_:)), name: .UIKeyboardWillHide, object: nil)
    }
    
    
    @objc func willShowKeyboard(_ noti: Notification) {
        //        print("Keyboard will show \(noti.userInfo)")
        guard let userInfo = noti.userInfo, let duration = userInfo[UIKeyboardAnimationDurationUserInfoKey] as? Double, let height = (userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.height else {
            return
        }
        
        let tabBarHeight = ((UIApplication.shared.delegate as? AppDelegate)?.window?.rootViewController as? UITabBarController)?.tabBar.frame.height ?? 0.0
        
        if orgBottomStackViewConstraint == nil {
            orgBottomStackViewConstraint = self.stackViewBottomConstraint.constant
            self.stackViewBottomConstraint.constant = self.stackViewBottomConstraint.constant + height - tabBarHeight
            UIView.animate(withDuration: duration) {
                self.view.layoutIfNeeded()// constranit 를 수정하면 내가 바뀌었다고 알려야 함
            }
        }
    }
    
    @objc func willHideKeyboard(_ noti:Notification) {
        //        print("Keyboard will show \(noti.userInfo)")
        guard let userInfo = noti.userInfo, let duration = userInfo[UIKeyboardAnimationDurationUserInfoKey] as? Double, let height = (userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.height else {
            return
        }

        let tabBarHeight = ((UIApplication.shared.delegate as? AppDelegate)?.window?.rootViewController as? UITabBarController)?.tabBar.frame.height ?? 0.0
        
        if let constraint = orgBottomStackViewConstraint {
            self.stackViewBottomConstraint.constant = constraint
            orgBottomStackViewConstraint = nil
            UIView.animate(withDuration: duration) {
                self.view.setNeedsDisplay() // constranit 를 수정하면 내가 바뀌었다고 알려야 함
            }
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

extension TodoListViewController: UIScrollViewDelegate {
    // scroll action handler
//    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) { view.endEditing(true) }
}
