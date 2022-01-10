//
//  dailyViewController.swift
//  test3
//
//  Created by 小林優斗 on 2022/01/09.
//

import UIKit
import Realm
import RealmSwift

class dailyViewController:UIViewController {
    
    @IBOutlet weak var dailyDateLabel: UILabel!
    
    @IBOutlet weak var dailyTextView: UITextView!
    
    @IBOutlet weak var saveButton: UIButton!
    
    @IBOutlet weak var returnButton: UIButton!
    
    
    var inputText: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dailyDateLabel.text = inputText
        
        framechar()
        
        print(Realm.Configuration.defaultConfiguration.fileURL)
    }
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    
    
    func framechar() {
          
          // 枠の調整
             
             dailyTextView.layer.borderColor = UIColor.black.cgColor
             
            dailyTextView.layer.borderWidth = 0.5
        
      dailyTextView.layer.cornerRadius = 15
             
             //キーボードに完了のツールバーを作成
                 let doneToolbar = UIToolbar()
                 doneToolbar.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 40)
                let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
                 let doneButton = UIBarButtonItem(title: "完了", style: .done, target: self, action: #selector(doneButtonTaped))
                 doneToolbar.items = [spacer, doneButton]
                 dailyTextView.inputAccessoryView = doneToolbar
      }
    
    @objc func doneButtonTaped(sender: UIButton) {
        
        //キーボード閉じる
        dailyTextView.endEditing(true)
    }
      
      
    
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        
        let realm = try! Realm()
        
        try! realm.write {
            
            let daily = [memoDataModel(value:["date": dailyDateLabel.text, "context": dailyTextView.text ])]
            
            realm.add(daily)
            
            print("データ読み込み中")
            
        }
        print("データ書き込み完了")
        
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func returnButtonTapped(_ sender: Any) {
        
     dismiss(animated: true, completion: nil)
    }
}
