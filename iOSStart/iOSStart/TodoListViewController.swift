//
//  TodoListViewController.swift
//  iOSStart
//
//  Created by David on 2017. 12. 26..
//  Copyright © 2017년 kanziw. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxOptional

class TodoListViewController: UIViewController {
    var todoList = Array<String>()
    var disposeBag = DisposeBag()
    
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
        
        func getInputText() -> String? {return textInputView.textField.text}

        textInputView.saveButton.rx.tap
            .map(getInputText)
            .filterNil().filterEmpty()
            .subscribe(onNext: saveTodoItemAction)
            .disposed(by: disposeBag)
    }
    
    func saveTodoItemAction(todoItem: String) {
        todoList.insert(todoItem, at: 0)
        textInputView.textField.text = ""
        reloadTableData()
    }
    
    func reloadTableData() { tableView.reloadData()}
    
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
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool { return true }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        tableView.beginUpdates()
        if (editingStyle == UITableViewCellEditingStyle.delete) {
            if let todoItemIndex = indexPath.last {
                todoList.remove(at: todoItemIndex)
                tableView.deleteRows(at: [indexPath], with: .left)
            }
        }
        tableView.endUpdates()
    }
}
