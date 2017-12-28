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
    
    lazy var textInputView: TextInputView = {
        let inputView = UINib(nibName: "TextInputView", bundle: nil).instantiate(withOwner: nil, options: nil).first as! TextInputView
        return inputView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "TO-DO LIST"
        
        // hide bottom line
        tableView.tableFooterView = UIView()
        tableView.contentInset = UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0)
        tableView.keyboardDismissMode = .interactive

        textInputView.saveButton.addTarget(self, action:#selector(saveTodoItemAction), for: .touchUpInside)
    }
    
    @objc func saveTodoItemAction() {
        if let todoItem = textInputView.textField.text, !todoItem.isEmpty {
            todoList.insert(todoItem, at: 0)
            textInputView.textField.text = ""
            tableView.reloadData()
        }
    }
    
    override var inputAccessoryView: UIView? { return textInputView }
    override var canBecomeFirstResponder: Bool { return true }
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
