//
//  goalViewController.swift
//  test3
//
//  Created by 小林優斗 on 2022/01/12.
//

import UIKit


let moneyList = [

    "無料","500円","1100円","3800円","4900円","10000円","29400円"
]

   var goal = goalDataModel()


class goalViewController:UIViewController   {
    
    
    @IBOutlet weak var goalTextField: UITextField!
    
    
    @IBOutlet weak var goalDateLabel: UILabel!
    
    
    @IBOutlet weak var goalMoneyLabel: UILabel!
    
    
    
    @IBOutlet weak var goalPickerView: UIPickerView!
    
    
    @IBOutlet weak var goalSendButton: UIButton!
    
    
    @IBOutlet weak var cautionLabel: UILabel!
    
    @IBOutlet weak var lastGoButton: UIButton!
    
   
    @IBOutlet weak var lastBackButton: UIButton!
    
    
    @IBOutlet weak var lastConfigView: UIView!
    
    
    @IBOutlet weak var goalTextView: UITextView!
    
    
    var datePicker: UIDatePicker = UIDatePicker()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        datePicker.preferredDatePickerStyle = .wheels
        datePickerControl()
        
        goalPickerView.delegate = self
        goalPickerView.dataSource = self
        
        goalSendButton.layer.cornerRadius = 15
        
      //  lastGoButton.layer.cornerRadius = 15
        
     //   lastBackButton.layer.cornerRadius = 15
        
        
   
        
        
        
      
        
    //    lastConfigView.layer.borderWidth = 3
        
    //    lastConfigView.layer.cornerRadius = 10
        
        goalTextView.isUserInteractionEnabled = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
   
        
    }
    

        
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
   
    
    func datePickerControl() {
           
        // ピッカー設定
        
                datePicker.datePickerMode = UIDatePicker.Mode.date
                datePicker.timeZone = NSTimeZone.local
                datePicker.locale = Locale.current
                goalTextField.inputView = datePicker
        
        datePicker.minimumDate = Calendar.current.date(byAdding: .year, value: 0, to: Date())

                // 決定バーの生成
                let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 35))
                let spacelItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
                let doneItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done))
                toolbar.setItems([spacelItem, doneItem], animated: true)

                // インプットビュー設定(紐づいているUITextfieldへ代入)
                goalTextField.inputView = datePicker
               goalTextField.inputAccessoryView = toolbar
       }
       
       
       @objc func done() {
              

      
           
           
               //画面表示用
               let formatter = DateFormatter()
           
                formatter.dateFormat = "yyyy年M月dd日"
       
           
           goalTextField.text = "\(formatter.string(from: datePicker.date))"
           
           goalDateLabel.text = "\(formatter.string(from: datePicker.date))"
           
       
      
          
         
        
    
       
           
    
           
           goal.goalDate = goalDateLabel.text!
           
           
    
           
           print("goalDate:", goal.goalDate)
           
       //    UserDefaults.standard.set(goal.goalDate, forKey: "date")
           
           
           
           
           
           
           goalTextField.endEditing(true)
       }
    
    
    
    @IBAction func tappedGoalSendButton(_ sender: Any) {
        
   
 
        if goalDateLabel.text == "" || goalMoneyLabel.text == "" {
            
            cautionLabel.isHidden = false
            
         print("エラー")
            
        } else {
            
            lastConfigView.isHidden = false
            
            goalSendButton.isEnabled = false
   
        
        }
        
 
        
        
        
  
    }
    
    
    
    @IBAction func lastBackButtonTapped(_ sender: Any) {
        
        
        UserDefaults.standard.set(true, forKey: "modify")
        
        performSegue(withIdentifier: "toMain", sender: nil)
        
        
    }
    
    
    @IBAction func lastConfigButtonTapped(_ sender: Any) {
        
        
        let f = DateFormatter()
        f.timeStyle = .none
        f.dateStyle = .long
        f.locale = Locale(identifier: "ja_JP")
        let now = Date()
        print(f.string(from: now))
        
        UserDefaults.standard.set(f.string(from: now), forKey: "now")
      
        
        
        UserDefaults.standard.set(true, forKey: "bool")
        
        UserDefaults.standard.set(goal.goalmoney, forKey: "money")
        
        UserDefaults.standard.set(goal.goalDate, forKey: "date")
        
        
        let differ = Int(datePicker.date.timeIntervalSinceNow)//　小数点位置直す
        
        let diff = ceil(Double(differ / 86388))
        
        print("diff",differ )
        
        UserDefaults.standard.set(diff, forKey: "diff")
        
       performSegue(withIdentifier: "toMain", sender: nil)
    }
    
    
}




extension goalViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
  
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        moneyList.count
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        goalMoneyLabel.text = moneyList[row]
        
        goal.goalmoney = goalMoneyLabel.text!
        
        print("goalMoney:", goal.goalmoney)
        
     //   UserDefaults.standard.set(goal.goalmoney, forKey: "money")
   
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return moneyList[row]
    }
    
    
    
}
   
