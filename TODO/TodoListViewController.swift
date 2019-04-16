//
//  ViewController.swift
//  TODO
//
//  Created by 叶柯辰 on 2019/3/28.
//  Copyright © 2019 yekechen. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController{

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
var itemArray = ["购买水杯","吃药","修改密码"]
    
    //MARK: - Table View DataSource methods
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row]
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    //MARK:  - Table View Delegate methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }else{
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    //MARK: - Add New Items
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        //声明一个新的变量，生存期在方法的内部
        var textField = UITextField()
        
    let alert = UIAlertController(title: "添加一个新的todo项目", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "添加新项目", style: .default){(action) in
            //用户单击j添加项目按钮以后要执行的代码
            self.itemArray.append(textField.text!)
            self.tableView.reloadData()
            print(textField.text!)
        }
        alert.addTextField{(alertTextField) in
            alertTextField.placeholder = "创建一个项目..."
            //让textField指向alertTextField，因为出了闭包，alerttextfield不存在
            textField = alertTextField
        }
        
        alert.addAction(action)
        present(alert,animated: true,completion: nil)
        
    }
}

