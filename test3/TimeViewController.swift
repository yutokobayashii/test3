//
//  TimeViewController.swift
//  test3
//
//  Created by 小林優斗 on 2022/01/05.
//



import UIKit
import Lottie








class TimeViewController: UIViewController {
    
    var animationView = AnimationView()
    
    
    
  
    @IBOutlet weak var goalDateLabel: UILabel!
    
    @IBOutlet weak var goalMoneyLabel: UILabel!
    
    
    
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
        
       
        
  
   userdef()
   buttonchar()
   goalsetting()
    
        
    
        
    }

    
    
    func goalStatus() -> Bool {
        //目標設定済みか否かの確認
        let goalstatus = UserDefaults.standard.bool(forKey: "bool")
        
        if goalstatus {
            
            print("goalstatus:success")
            
            return true
        } else {
            
            print("goalstatus; failed")
            
            return false
        }
    }
    
    
    func goalsetting() {
     
        if goalStatus() {
          
         let date = UserDefaults.standard.string(forKey: "date")
          
          let money = UserDefaults.standard.string(forKey: "money")
          
          print("date:",date!)
          print("money:",money!)
          
          goalDateLabel.text = date
          
          goalMoneyLabel.text = money
            
     
            
            
        } else  {
            
            goalDateLabel.text = "未設定"
            goalMoneyLabel.text = "未設定"
        }
        
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
        
        
        let savedata1 = UserDefaults.standard.string(forKey: "timeView")
        
        
        timeLabel.text = savedata1
        
     //   reset.text =  UserDefaults.standard.string(forKey: "ct")
        
        
        
    

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
        
        
        //比較用
        UserDefaults.standard.set(day, forKey: "day")
        
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
            
            
          
            
            if self.goalStatus() {
                
                
             
                   
           
               
              
                //目標が設定済みだった場合
                
          
                let dayRecode = UserDefaults.standard.integer(forKey: "day")
                
                let dayGoal = UserDefaults.standard.integer(forKey: "diff")
                
     
                print("recode:",dayRecode)
                print("goal:",dayGoal)
                 
               //目標が設定済みで合った場合でかつ、目標達成した場合
               
                if dayRecode >= dayGoal {
                    
                    print("目標達成！")
                    
                    UserDefaults.standard.set(self.timeLabel.text, forKey: "time")
                    
                    self.performSegue(withIdentifier: "toAchived", sender: nil)
                    
                    self.setStopTime(date: nil)
                    self.setStartTime(date: nil)
                    self.timeLabel.text = self.makeTimeString(day: 0, hour: 0, min: 0, sec: 0)
                    self.stopTimer()
                    
                    self.setStartTime(date: Date())
                 
                    self.startTimer()
                    
                    let  memo = memoDataModel()
                    
                    memo.date = "未設定"
                    memo.context = "未設定"
                    
                    UserDefaults.standard.set(memo.date, forKey: "date")
                    UserDefaults.standard.set(memo.context, forKey: "money")
                    
                    UserDefaults.standard.set(false, forKey: "bool")
                }
                
               //目標が設定済みでかつ、目標未達成だった場合
                else {
                    
                    UserDefaults.standard.set(self.timeLabel.text, forKey: "time")
                    
                  
                    
                    self.setStopTime(date: nil)
                    self.setStartTime(date: nil)
                    self.timeLabel.text = self.makeTimeString(day: 0, hour: 0, min: 0, sec: 0)
                    self.stopTimer()
                    
                    self.setStartTime(date: Date())
                 
                    self.startTimer()
                    
                    let  memo = memoDataModel()
                    
                    memo.date = "未設定"
                    memo.context = "未設定"
                    
                    UserDefaults.standard.set(memo.date, forKey: "date")
                    UserDefaults.standard.set(memo.context, forKey: "money")
                    UserDefaults.standard.set(false, forKey: "bool")
                    //ここに課金実装
                    
                    print("目標未達成")
                }
                
           
            
            } else {
                
                //目標が未設定だった場合
                self.performSegue(withIdentifier: "toNext", sender: nil)
                
                    self.setStopTime(date: nil)
                    self.setStartTime(date: nil)
                    self.timeLabel.text = self.makeTimeString(day: 0, hour: 0, min: 0, sec: 0)
                    self.stopTimer()
                    
                    self.setStartTime(date: Date())
                 
                    self.startTimer()
                UserDefaults.standard.set(false, forKey: "bool")
              
                
                
                
             
                
                
                
            }
          
            
            
            
            
            
            
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
        
        if goalStatus() {
            
            performSegue(withIdentifier: "toSetting", sender: nil)
            
            setagoalButton.isEnabled = false
           
           
            
        } else {
            
            performSegue(withIdentifier: "toSetting", sender: nil)
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
