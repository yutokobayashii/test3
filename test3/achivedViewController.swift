//
//  achivedViewController.swift
//  test3
//
//  Created by 小林優斗 on 2022/01/15.
//

import UIKit
import Lottie

class achivedViewController :UIViewController {
    
    var animationView = AnimationView()
    
    var timer:Timer = Timer()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addAnimationView()
        
        timer = Timer.scheduledTimer(timeInterval: 6.5,  target: self, selector: #selector(changeView), userInfo: nil,repeats: false)
                                                                                
                                                                    
                                                           
        
    }
    
    @objc func changeView() {
        self.performSegue(withIdentifier: "toNext1", sender: nil)
        }
   
   
    
    func addAnimationView() {
        
        //アニメーションのファイルの指定
        
        animationView = AnimationView(name: "44487-presente")
        
       
        animationView.frame = CGRect(x: 60, y: 220, width: 300, height: 300)
        
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.play()
        
        view.addSubview(animationView)
    }
    
    
}


