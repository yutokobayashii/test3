//
//  NoteDetailViewController.swift
//  test3
//
//  Created by 小林優斗 on 2022/01/05.
//



import UIKit
import CoreData

class NoteDetailViewController: UIViewController {
    
    
    @IBOutlet weak var titleTF: UITextView!
    
    @IBOutlet weak var timerLabel2: UILabel!
    
    var inputText: String = ""
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //枠の調整
        
        titleTF.layer.borderColor = UIColor.black.cgColor
        
        titleTF.layer.borderWidth = 0.5
        
       
        timerLabel2.text = inputText
        
        //キーボードに完了のツールバーを作成
            let doneToolbar = UIToolbar()
            doneToolbar.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 40)
            let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
            let doneButton = UIBarButtonItem(title: "完了", style: .done, target: self, action: #selector(doneButtonTaped))
            doneToolbar.items = [spacer, doneButton]
            titleTF.inputAccessoryView = doneToolbar

      
    }
    
    @objc func doneButtonTaped(sender: UIButton) {
        
        titleTF.endEditing(true)
    }
    
    
    @IBAction func saveAction(_ sender: Any) {
        
        
        //日時の取得
        
        let dt = Date()
        
        let dateFormatter = DateFormatter()
        
        //DateFormatterを使用して書式とローカルを指定する
        
        dateFormatter.dateFormat = DateFormatter.dateFormat(fromTemplate: "yMMMdHms", options: 0, locale: Locale(identifier: "ja_JP"))
        
        let time1: String = "日時："
        
        let record1: String = "記録："
        
        let cause1: String = "一言："
        
        let cause: String = titleTF.text
        
        let time: String = dateFormatter.string(from: dt) //koko
       
        
        let brank: String = "                                                                 "
        
        let record: String = timerLabel2.text!
         
        let brank2: String = "                                                     "
        
       
        
        
        let notelist: String = time1 + time + brank + record1 + record + brank2 + cause1 + cause
        
        
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

        let note = Note(context: context)
        note.chestity = notelist
       

        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
        
        //userdefaults保存
        let time4 = dateFormatter.string(from: dt)
        
        
        UserDefaults.standard.set(time4, forKey: "time")
        
        
     
        
        
       
        
        
                
       
        
        
               
        
       
      
        self.dismiss(animated: true, completion: nil)
        
        
        
    }
    

}

