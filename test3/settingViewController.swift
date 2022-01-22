//
//  settingViewController.swift
//  test3
//
//  Created by 小林優斗 on 2022/01/11.
//

import UIKit



class settingViewController:UIViewController {
    
    
    @IBOutlet weak var settingButton: UIButton!
    
    
  
    @IBOutlet weak var settingTextView: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        settingButton.layer.cornerRadius = 15
        
       
        settingTextView.isUserInteractionEnabled = false
        
        
     
    }
    
    
  
    
    
    
   
    
    @IBAction func settingSaveButtonTapped(_ sender: Any) {
        
        performSegue(withIdentifier: "toGoal", sender: nil)
  
        
    }
    
    
}
