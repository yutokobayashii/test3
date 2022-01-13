//
//  CalendarViewController.swift
//  test3
//
//  Created by 小林優斗 on 2022/01/06.
//


import UIKit
import FSCalendar
import CalculateCalendarLogic
import Realm
import RealmSwift







class CalendarViewController: UIViewController,FSCalendarDelegate,FSCalendarDataSource,FSCalendarDelegateAppearance {
   
    

    @IBOutlet weak var calendar: FSCalendar!

    
    @IBOutlet weak var memoDateLabel: UILabel!
    
    
    @IBOutlet weak var memoTextView: UITextView!
    
    
    @IBOutlet weak var memoButton: UIButton!
    
    
 //   var date: String!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        memoTextView.isUserInteractionEnabled = true
        
        memoTextView.isEditable = false
        
        memoButton.layer.cornerRadius = 30
   
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
  
 
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // キーボードを閉じる
        view.endEditing(true)
    }
    
    
    @objc func keyboardWillHide() {
            if self.view.frame.origin.y != 0 {
                self.view.frame.origin.y = 0
            }
        }

    
    @objc func keyboardWillShow(notification: NSNotification) {
            if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
                if self.view.frame.origin.y == 0 {
                    self.view.frame.origin.y -= keyboardSize.height
                } else {
                    let suggestionHeight = self.view.frame.origin.y + keyboardSize.height
                    self.view.frame.origin.y -= suggestionHeight
                }
            }
        }
     
    
    fileprivate let gregorian: Calendar = Calendar(identifier: .gregorian)
    fileprivate  var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()

    // 祝日判定を行い結果を返すメソッド(True:祝日)
    func judgeHoliday(_ date : Date) -> Bool {
        //祝日判定用のカレンダークラスのインスタンス
        let tmpCalendar = Calendar(identifier: .gregorian)

        // 祝日判定を行う日にちの年、月、日を取得
        let year = tmpCalendar.component(.year, from: date)
        let month = tmpCalendar.component(.month, from: date)
        let day = tmpCalendar.component(.day, from: date)

        // CalculateCalendarLogic()：祝日判定のインスタンスの生成
        let holiday = CalculateCalendarLogic()

        return holiday.judgeJapaneseHoliday(year: year, month: month, day: day)
    }
    // date型 -> 年月日をIntで取得
    func getDay(_ date:Date) -> (Int,Int,Int){
        let tmpCalendar = Calendar(identifier: .gregorian)
        let year = tmpCalendar.component(.year, from: date)
        let month = tmpCalendar.component(.month, from: date)
        let day = tmpCalendar.component(.day, from: date)
       
     
        
        return (year,month,day)
    }

    //曜日判定(日曜日:1 〜 土曜日:7)
    func getWeekIdx(_ date: Date) -> Int{
        let tmpCalendar = Calendar(identifier: .gregorian)
        return tmpCalendar.component(.weekday, from: date)
    }

    // 土日や祝日の日の文字色を変える
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, titleDefaultColorFor date: Date) -> UIColor? {
        //祝日判定をする（祝日は赤色で表示する）
        if judgeHoliday(date){
            return UIColor.red
        }

        //土日の判定を行う（土曜日は青色、日曜日は赤色で表示する）
        let weekday = getWeekIdx(date)
        if weekday == 1 {   //日曜日
            return UIColor.red
        }
        else if weekday == 7 {  //土曜日
            return UIColor.blue
        }

        return nil
    }

    
    
 

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        
        
        memoTextView.text = ""
        
        
        let tmpCalendar = Calendar(identifier: .gregorian)
        let year = tmpCalendar.component(.year, from: date)
        let month = tmpCalendar.component(.month, from: date)
        let day = tmpCalendar.component(.day, from: date)
        
        memoDateLabel.text = String(year) + "/" + String(month) + "/" + String(day)
      
        let da = memoDateLabel.text
        
        let realm = try! Realm()
        
        var result = realm.objects(memoDataModel.self)
        
        result = result.filter("date = '\(da!)'")
        
        print(result)
        
        for daily in result {
            
            if daily.date == da {
                
                memoTextView.text = daily.context
            }
            
            
            
                
            
        
        }
        
        
        
      
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let nextVC = segue.destination as? dailyViewController,
           
            let inputText = memoDateLabel.text {
            
            nextVC.inputText = inputText
        }
        
       
        
    }
    
   

    
    
   
    @IBAction func memoButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "toDaily", sender: nil)
        
    }
    
    
    
    //点マークをつける関数
    func calendar(calendar: FSCalendar!, hasEventForDate date: NSDate!) -> Bool {
        return putdot
    }
    
    
    }



