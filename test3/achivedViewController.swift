//
//  achivedViewController.swift
//  test3
//
//  Created by 小林優斗 on 2022/01/15.
//

import UIKit


class achivedViewController :UIViewController {

    
    var timer:Timer = Timer()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
   
        
        timer = Timer.scheduledTimer(timeInterval: 4.5,  target: self, selector: #selector(changeView), userInfo: nil,repeats: false)
                                                                                
                                                                    
                                                           
        
    }
    
    @objc func changeView() {
        self.performSegue(withIdentifier: "toNext1", sender: nil)
        }
   
   
    
  
    
}


