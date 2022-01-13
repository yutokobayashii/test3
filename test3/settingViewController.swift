//
//  settingViewController.swift
//  test3
//
//  Created by 小林優斗 on 2022/01/11.
//

import UIKit
import Lottie


class settingViewController:UIViewController {
    
    
    var animationView = AnimationView()
    
    
  
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
         addAnimationView()
       
  
     
    }
    
    
  
    
    func addAnimationView() {
        
        //アニメーションのファイルの指定
        
        animationView = AnimationView(name: "74216-animated-flames")
        
       
        animationView.frame = CGRect(x: 60, y: 470, width: 300, height: 300)
        
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.play()
        
        view.addSubview(animationView)
    }
    
   
    
    @IBAction func settingSaveButtonTapped(_ sender: Any) {
        
        performSegue(withIdentifier: "toGoal", sender: nil)
  
        
    }
    
    
}
