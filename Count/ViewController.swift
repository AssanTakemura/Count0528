//
//  ViewController.swift
//  Count
//
//  Created by 竹村明日香 on 2021/05/28.
//


//数字四則演算は自由　誤差を小さくする


import UIKit

class ViewController: UIViewController {
    
    var number: Int = 0
    
    //問題
    @IBOutlet var randomlabel: UILabel!
    
    //回答表示
    @IBOutlet var label1: UILabel!
    @IBOutlet var label2: UILabel!
    @IBOutlet var label3: UILabel!
    @IBOutlet var label4: UILabel!
    

    let randomInt = Int.random(in: 4..<100)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func Start(){
        
    }
    

}

