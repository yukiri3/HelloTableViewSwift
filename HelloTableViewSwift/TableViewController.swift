//
//  TableViewController.swift
//  HelloTableViewSwift
//
//  Created by user on 2016/11/28.
//  Copyright © 2016年 HelloSwift. All rights reserved.
//

/*
    TableViewController for Swift
 */

import UIKit

class TableViewController: UITableViewController {
    //宣告一個陣列存 好友姓名
    var friendName:Array<String> = []
    //宣告一個陣列存 好友電話
    var friendNumber:Array<String> = []
    //宣告一個image
    let image = UIImage(named: "default_user_icon")

    override func viewDidLoad() {
        super.viewDidLoad()
        //初始化假資料
        friendName=["聯絡人1","聯絡人2","聯絡人3","聯絡人4","聯絡人5","聯絡人6","聯絡人7","聯絡人8","聯絡人9","聯絡人10"];
        for i in 0...9 {
            //int轉String
            let str:String=String(i)
            friendNumber += ["090000000"+str]
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

    /*
     
     TableViewDelegate
     TableViewDataSource
     
     */
    
    
    //這裡回傳tableView要有幾個Section
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }

    //這裡回傳一個Section 要有幾個row
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //回傳陣列裡的數據量
        return friendName.count
    }

    
    //這裡回傳Cell顯示的內容 (可自訂)
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //我有一個cell Identifier為 “Telephone”
        let cell = tableView.dequeueReusableCell(withIdentifier: "Telephone", for: indexPath)
       
        //Cell系統自帶label
        //把陣列裡的Str按照 row 丟進去 然後回傳
        cell.textLabel?.text = friendName[indexPath.row];
        cell.detailTextLabel?.text = friendNumber[indexPath.row];
        cell.imageView?.image = image
        

        return cell
    }
    
    //往左滑
    // 如果要可以編輯表格（含刪除、新增資料）請開啟本方法
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        
        return true
    }
    
    // 如果要可以編輯表格（含刪除、新增資料）請開啟本方法
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
      
        if editingStyle == .delete
        {
            //刪除選中的 陣列中資料
            friendName.remove(at: indexPath.row)
            friendNumber.remove(at: indexPath.row)
            
            //要更新tableView UI
            tableView.reloadData()
        }
    }
    
 
    //將使用者點擊的 row 找出來
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      // 準備下一頁
       let vc:DetailViewController = UIStoryboard(name:"Main", bundle: nil).instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        
        //把A vc的值傳給 B vc
        vc.myImage = self.image
        vc.myName = friendName[indexPath.row]
        vc.myNumber = friendNumber[indexPath.row]
        
        //navigationController push
        self.navigationController?.pushViewController(vc, animated:true)
        
         //or使用modal
//         self.present(vc, animated: true, completion: nil);  
        
 
    }
    //建立一個 UIBarButton Action
    @IBAction func addNewFriend(_ sender: UIBarButtonItem) {
        // 建立一個提示框
        //alert用法-UIAlertController 
        //註：請勿使用UIAlertView 此方法已在iOS9中移除
        
        let alertController = UIAlertController(
            title: "新增好友",
            message: "請輸入好友名稱與電話號碼",
            preferredStyle: .alert)
        
        // 建立兩個輸入框
        alertController.addTextField {
            (textField: UITextField!) -> Void in
            textField.placeholder = "名稱"
        }
        alertController.addTextField {
            (textField: UITextField!) -> Void in
            textField.placeholder = "號碼"
            // 如果要輸入密碼 這個屬性要設定為 true
            textField.isSecureTextEntry = false
        }
        // 建立取消按鈕
        let cancelAction = UIAlertAction(
            title: "取消",
            style: .cancel,
            handler: nil)
        alertController.addAction(cancelAction)
        
        // 建立確定按鈕
        let okAction = UIAlertAction(
            title: "確定",
            style: .default) {
                (action: UIAlertAction!) -> Void in
                let name = (alertController.textFields?.first)! as UITextField
                let number = (alertController.textFields?.last)! as UITextField
              
                //將TextField的值+到陣列裡
                self.friendName += [name.text!]
                self.friendNumber += [number.text!]
                //並且更新TableView UI
                self.tableView.reloadData()
        }
        alertController.addAction(okAction)
        // 顯示提示框
        self.present(alertController, animated: true, completion: nil)
    }

    
    /*其餘代理方法 未完...*/
    
    
    //這方法是回傳Cell高度 型態為CGFloat
   override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 70.0;
    }
    //這方法回傳Header高度
   override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return 30.0;
    }
   //這方法回傳Footer高度
   override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.0;
    }

    //設置HeaderView
   override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    //初始化一個UIView與設定Frame
    let headerView:UIView = UIView(frame: CGRect(x: 0, y: 0, width:self.view.frame.size.width, height: 30));
    //將headerView背景設為綠色
    headerView.backgroundColor = UIColor.green
    //初始化一個Label
    let headerLabel:UILabel = UILabel(frame: CGRect(x: 10, y: 3, width:self.view.frame.size.width, height: 25));
    headerLabel.text = "我的好麻吉"
    //將Label加入HeaderView
    headerView.addSubview(headerLabel)
        return headerView
    }
    
    // 設定是否允許cell點下去時 亮起
    override func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return true;
    }
    
    
}
