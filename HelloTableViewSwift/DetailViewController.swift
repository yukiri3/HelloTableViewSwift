//
//  DetailViewController.swift
//  HelloTableViewSwift
//
//  Created by user on 2016/11/28.
//  Copyright © 2016年 HelloSwift. All rights reserved.
//

/*
 
    ViewController
 
*/


import UIKit

class DetailViewController: UIViewController {
    //私有變數
     @IBOutlet private  var myImageView: UIImageView!
     @IBOutlet private  var myLabelName: UILabel!
     @IBOutlet private  var myLabelNumber: UILabel!
    var myImage: UIImage!
    var myName: String!
    var myNumber: String!
    override func viewDidLoad() {
        super.viewDidLoad()
        myImageView.image = myImage!
        myLabelName.text = myName!
        myLabelNumber.text = myNumber!
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    

  
}
