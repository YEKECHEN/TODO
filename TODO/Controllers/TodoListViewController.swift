//
//  ViewController.swift
//  TODO
//
//  Created by 叶柯辰 on 2019/3/28.
//  Copyright © 2019 yekechen. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController{
    
    var itemArray = [Item]()
    
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    func loadItems(){
        if let data = try? Data(contentsOf: dataFilePath!){
            let decoder = PropertyListDecoder()
            do{
                itemArray = try decoder.decode([Item].self, from: data)
            }catch {
                print("解码item错误！")
            }
        }
    }
    
    func saveItem(){
        let encoder = PropertyListEncoder()
        
        do {
            let data = try encoder.encode(itemArray)
            try data.write(to: dataFilePath!)
        }catch{
            print("编译错误\(error)")
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print(dataFilePath!)
        
        loadItems()
    }
    
    //MARK: - Table View DataSource methods
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row].title
        
        var item = itemArray[indexPath.row]
        
        cell.accessoryType = item.done == true ? .checkmark : .none
//        if itemArray[indexPath.row].done == false{
//            cell.accessoryType = .none
//        }else{
//            cell.accessoryType = .checkmark
//        }
//
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    //MARK:  - Table View Delegate methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        if itemArray[indexPath.row].done == false {
            itemArray[indexPath.row].done = true
        }else {
            itemArray[indexPath.row].done = false
        }
        
        tableView.beginUpdates()
        tableView.reloadRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
        tableView.endUpdates()
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        saveItem()
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    //MARK: - Add New Items
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        //声明一个新的变量，生存期在方法的内部
        var textField = UITextField()
        
    let alert = UIAlertController(title: "添加一个新的todo项目", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "添加新项目", style: .default){(action) in
            //用户单击j添加项目按钮以后要执行的代码
            
            let newItem = Item()
            newItem.title = textField.text!
            
            self.itemArray.append(newItem)
            
            self.saveItem()
            
            self.tableView.reloadData()
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

