//
//  TimeViewController.swift
//  test3
//
//  Created by 小林優斗 on 2022/01/05.
//



import UIKit

var putdot = true

class TimeViewController: UIViewController {
    
    
    
    
    @IBOutlet weak var goaltextView: UITextView!
    
    
    
    
    @IBOutlet weak var timeLabel: UILabel!
    
    

    @IBOutlet weak var startButton: UIButton!
    
    
    
    
    @IBOutlet weak var resetButton: UIButton!
    
    
    @IBOutlet weak var setagoalButton: UIButton!
    
    
   
    
    var timerCounting: Bool = false
    
    var startTime: Date?
    
    var stopTime: Date?
    
    let userdefaults = UserDefaults.standard
    
    let START_TIME_KEY = "startTime"
    
    let STOP_TIME_KEY = "startTime"
    
    let COOUNTING_KEY = "countingKey"
    
    var scheduledTimer: Timer!
    

    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
       
      
  
  
  
        
        
        
          
        startTime = userdefaults.object(forKey: START_TIME_KEY) as? Date
        stopTime = userdefaults.object(forKey: STOP_TIME_KEY) as? Date
        timerCounting = userdefaults.bool(forKey: COOUNTING_KEY)
        
        if timerCounting{
            startTimer()
        }
        else {
            stopTimer()
            if let start = startTime
            {
                if let stop = stopTime
                {
                    let time = calcRestartTime(start: start, stop: stop)
                    let diff = Date().timeIntervalSince(time)
                    setTimeLabel(Int(diff))
                }
            }
        }
        
       
        
   buttonchar()
   framechar()
   userdef()
        
        
        
        
    
        
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    private func buttonchar() {
        
        // ボタンの装飾
        let rgba = UIColor.systemGray6 // ボタン背景色設定
              startButton.backgroundColor = rgba                                               // 背景色
              startButton.layer.borderWidth = 0.5                                              // 枠線の幅
             startButton.layer.borderColor = UIColor.black.cgColor                            // 枠線の色
             startButton.layer.cornerRadius = 5.0                                             // 角丸のサイズ
        startButton.setTitleColor(UIColor.white, for: UIControl.State.normal)//タイトルの色
        
      
              resetButton.backgroundColor = rgba                                               // 背景色
              resetButton.layer.borderWidth = 0.5                                              // 枠線の幅
             resetButton.layer.borderColor = UIColor.black.cgColor                            // 枠線の色
             resetButton.layer.cornerRadius = 5.0                                             // 角丸のサイズ
        resetButton.setTitleColor(UIColor.white, for: UIControl.State.normal)//タイトルの色
        
        setagoalButton.backgroundColor = rgba                                               // 背景色
       setagoalButton.layer.borderWidth = 0.5                                              // 枠線の幅
       setagoalButton.layer.borderColor = UIColor.black.cgColor                            // 枠線の色
       setagoalButton.layer.cornerRadius = 5.0                                             // 角丸のサイズ
 setagoalButton.setTitleColor(UIColor.white, for: UIControl.State.normal)//タイトルの色
  
  
  
        
    }
    
    private func userdef() {
        
        //userdefaults読み込み、出力
        
      let savedata =  UserDefaults.standard.string( forKey: "goaltextview")
        
        goaltextView.text = savedata
        
        let savedata1 = UserDefaults.standard.string(forKey: "timeView")
        
        
        timeLabel.text = savedata1
        
     //   reset.text =  UserDefaults.standard.string(forKey: "ct")
        
    

    }
    
  func framechar() {
        
        // 枠の調整
           
           goaltextView.layer.borderColor = UIColor.black.cgColor
           
          goaltextView.layer.borderWidth = 0.5
      
      goaltextView.layer.cornerRadius = 15
           
           //キーボードに完了のツールバーを作成
               let doneToolbar = UIToolbar()
               doneToolbar.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 40)
              let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
               let doneButton = UIBarButtonItem(title: "完了", style: .done, target: self, action: #selector(doneButtonTaped))
               doneToolbar.items = [spacer, doneButton]
               goaltextView.inputAccessoryView = doneToolbar
    }
    
    
    
    
    @objc func doneButtonTaped(sender: UIButton) {
        
        //キーボード閉じる
        goaltextView.endEditing(true)
        
        //userdefaults保存
      guard let text = goaltextView.text else {return}
        
       UserDefaults.standard.set(text, forKey: "goaltextview")
        
    
    }
    
    
    
  
 
    @IBAction func startAction(_ sender: Any) {
    
    
        
        
        if timerCounting {
            setStopTime(date: Date())
            stopTimer()
        }
        else {
            
            if let stop = stopTime {
                let restartTime = calcRestartTime(start: startTime!, stop: stop)
                setStopTime(date: nil)
                setStartTime(date: restartTime)
            }
            else {
                setStartTime(date: Date())
            }
            startTimer()
        }
    }
    
    func calcRestartTime(start: Date, stop: Date) -> Date {
        
        let diff = start.timeIntervalSince(stop)
        
        return Date().addingTimeInterval(diff)
    }
    
    
    
    
    
    func startTimer() {
        
        scheduledTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(refreshValue), userInfo: nil, repeats: true)
        
        setTimerCounting(true)
        startButton.setTitle("STOP", for: .normal)
        startButton.setTitleColor(UIColor.red, for: .normal)
        
        
        
        
        
    }
    
    @objc func refreshValue() {
        
        if let start = startTime
        {
            let diff = Date().timeIntervalSince(start)
            setTimeLabel(Int(diff))
        }
        else {
            stopTimer()
            setTimeLabel(0)
        }
        
    }
    
    func setTimeLabel(_ val: Int) {
        
        let time = secondsToHourMinutesSeconds(val)
        let timeString = makeTimeString(day: time.0, hour: time.1, min: time.2, sec: time.3)
        
        timeLabel.text = timeString
        
    }
    
    func secondsToHourMinutesSeconds(_ ms: Int) -> (Int, Int, Int, Int) {
        
        let day = ms / 86400
        
        var hour = (ms / 3600) % 24 //test中13:06-
        
        let min = (ms % 3600) / 60
        
        let sec = (ms % 3600) % 60
        
        if hour == 60 {
            
            hour = 0
        }
        
        
        
        
        return (day,hour, min, sec)
        
        
    }
    
    func makeTimeString(day: Int, hour: Int, min: Int, sec: Int) -> String {
        
        var timeString = ""
        timeString += String(format: "%02d", day)
        timeString += "日"
        timeString += String(format: "%02d", hour)
        timeString += "時"
        timeString += String(format: "%02d",min)
        timeString += "分"
        timeString += String(format: "%02d", sec)
        timeString += "秒"
        
        return timeString
        
    }
    
    
    
    
    func stopTimer() {
        
        if scheduledTimer != nil {
        
        scheduledTimer.invalidate()
            
        }
        setTimerCounting(false)
       // startButton.setTitle("START", for: .normal)
      //  startButton.setTitleColor(UIColor.systemGreen, for: .normal)
    }
    
    
  //  func resetcounter() {
        
  //      let date = Date()
 //       let cal = Calendar.current
  //      let comp = cal.dateComponents([Calendar.Component.year,Calendar.Component.month], from: date)
       
  
        
        
        
        
        
        
        
        
        
        
        
        
 //   }
    
    
    
    @IBAction func resetAction(_ sender: Any) {
        
     
        
        //アラート表示コード
        
        //アラート生成
        //UIAlertControllerのスタイルがalert
        let alert: UIAlertController = UIAlertController(title: "本当にリセットしますか？", message:  "後悔のない決断をお勧めします", preferredStyle:  UIAlertController.Style.alert)
        // 確定ボタンの処理
        let confirmAction: UIAlertAction = UIAlertAction(title: "リセット", style: UIAlertAction.Style.default, handler:{
            // 確定ボタンが押された時の処理をクロージャ実装する
            (action: UIAlertAction!) -> Void in
            //実際の処理
            
            self.performSegue(withIdentifier: "toNext", sender: nil)
            
            self.setStopTime(date: nil)
            self.setStartTime(date: nil)
            self.timeLabel.text = self.makeTimeString(day: 0, hour: 0, min: 0, sec: 0)
            self.stopTimer()
            
            self.setStartTime(date: Date())
         
            self.startTimer()
            putdot = false
            
            
          
            
            
            
            
            
            
            //[self]をhandlerの中に
      
        })
      
        
        // キャンセルボタンの処理
        let cancelAction: UIAlertAction = UIAlertAction(title: "キャンセル", style: UIAlertAction.Style.cancel, handler:{
            // キャンセルボタンが押された時の処理をクロージャ実装する
            (action: UIAlertAction!) -> Void in
            //実際の処理
            print("キャンセル")
        })

        //UIAlertControllerにキャンセルボタンと確定ボタンをActionを追加
        alert.addAction(cancelAction)
        alert.addAction(confirmAction)

        //実際にAlertを表示する
        
        present(alert, animated: true, completion: nil)
        
    
    }
    
    
    
    @IBAction func setagoal(_ sender: Any) {
       
    }
    
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

          if let NoteDetailVC = segue.destination as? NoteDetailViewController,
        let inputText: String = timeLabel.text {

               // 遷移先のViewControllerに文字列を渡す
                    NoteDetailVC.inputText = inputText
           }
        }
    
    func setStartTime(date: Date?) {
        
        startTime = date
        userdefaults.set(date, forKey: START_TIME_KEY)
    }
    
    
    func setStopTime(date: Date?) {
        
        stopTime = date
        userdefaults.set(date, forKey: STOP_TIME_KEY)
    }
    
    func setTimerCounting(_ val: Bool) {
        timerCounting = val
        userdefaults.set(timerCounting, forKey: COOUNTING_KEY)
        
    }
    
    
    
    
    
    



}
