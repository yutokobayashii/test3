//
//  firseCellViewController.swift
//  test3
//
//  Created by 小林優斗 on 2022/01/18.
//

import UIKit

class firseCellViewController : UIViewController {
    
    @IBOutlet weak var firsttextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        firsttextView.layer.cornerRadius = 20
        firsttextView.layer.borderWidth = 3.0
        firsttextView.layer.masksToBounds = true
        firsttextView.layer.borderColor = UIColor.systemTeal.cgColor
        
    }
}

class secondCellViewController : UIViewController {
    
    @IBOutlet weak var secondTextView: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        secondTextView.layer.cornerRadius = 20
      secondTextView.layer.borderWidth = 3.0
       secondTextView.layer.masksToBounds = true
        secondTextView.layer.borderColor = UIColor.systemTeal.cgColor
    }
}


class thirdCellViewController : UIViewController {
    
    
    @IBOutlet weak var thirdTextView: UITextView!
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
     thirdTextView.layer.cornerRadius = 20
     thirdTextView.layer.borderWidth = 3.0
      thirdTextView.layer.masksToBounds = true
        thirdTextView.layer.borderColor = UIColor.systemTeal.cgColor
        
       
    }
    
 
}

class fourthcellViewController: UIViewController {
    
    @IBOutlet weak var fourthTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        fourthTextView.layer.cornerRadius = 20
       fourthTextView.layer.borderWidth = 3.0
        fourthTextView.layer.masksToBounds = true
           fourthTextView.layer.borderColor = UIColor.systemTeal.cgColor
           
        
    }
}
