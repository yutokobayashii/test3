//
//  goalViewController.swift
//  test3
//
//  Created by 小林優斗 on 2022/01/12.
//

import UIKit


let moneyList = [

    "300円","1000円","3000円","5000円","10000円"
]




class goalViewController:UIViewController   {
    
    
    @IBOutlet weak var goalTextField: UITextField!
    
    
    @IBOutlet weak var goalDateLabel: UILabel!
    
    
    @IBOutlet weak var goalMoneyLabel: UILabel!
    
    
    
    @IBOutlet weak var goalPickerView: UIPickerView!
    
    
    @IBOutlet weak var goalSendButton: UIButton!
    
    var datePicker: UIDatePicker = UIDatePicker()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        datePicker.preferredDatePickerStyle = .wheels
        datePickerControl()
        
        goalPickerView.delegate = self
        goalPickerView.dataSource = self
        
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
              

              // 日付のフォーマット
              let formatter = DateFormatter()

              //"yyyy年MM月dd日"を"yyyy/MM/dd"したりして出力の仕方を好きに変更できるよ
              formatter.dateFormat = "yyyy年MM月dd日"
           
        
           
          
           
           goalTextField.text = "\(formatter.string(from: datePicker.date))"
           
           goalDateLabel.text = "\(formatter.string(from: datePicker.date))"
           
           goalTextField.endEditing(true)
       }
    
    
    
    @IBAction func tappedGoalSendButton(_ sender: Any) {
        
    performSegue(withIdentifier: "toMain", sender: nil)
        
    //TimeVCに表示したい。
    //userdefが使えるかも
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
   
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return moneyList[row]
    }
    
    
    
}
   
