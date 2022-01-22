//
//  TimeViewController.swift
//  test3
//
//  Created by 小林優斗 on 2022/01/05.
//



import UIKit
import StoreKit








class TimeViewController: UIViewController, SKPaymentTransactionObserver {
 


    
    let productID500 = "comkobacomtest3.item500"
    
    let productID1100 = "comkobacomtest3.1100"
    
    let productID3800 = "comkobacomtest3.3800"
    
    let productID10000 = "comkobacomtest3.10000"
    
    let productID4900 = "comkobacomtest3.5000"
    
 
    
    let productID29400 = "comkobacomtest3.29400"

    
  
    @IBOutlet weak var goalDateLabel: UILabel!
    
    @IBOutlet weak var goalMoneyLabel: UILabel!
    
    
    
    @IBOutlet weak var timeLabel: UILabel!
    
    

    @IBOutlet weak var startButton: UIButton!
    
    
    
    @IBOutlet weak var logoImageView: UIImageView!
    
    
    
    @IBOutlet weak var resetButton: UIButton!
    
    
    @IBOutlet weak var setDayLabel: UILabel!
    
    
    
   
    
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
        
        print("おはよう")
        
        let modefiedBool = UserDefaults.standard.bool(forKey: "modify")
        
        if modefiedBool {
          
            
            setStopTime(date: Date())
            stopTimer()
            UserDefaults.standard.set(false, forKey: "modify")
        }
 

        
        
        
        SKPaymentQueue.default().add(self)
      
          
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
            
            let now = UserDefaults.standard.string(forKey: "now")
          
          print("date:",date)
          print("money:",money)
            
            if date == nil || money == nil || now == nil{
                
                goalDateLabel.text = ""
                goalMoneyLabel.text = ""
                setDayLabel.text = ""
                
            } else {
          
          goalDateLabel.text = date!
          
          goalMoneyLabel.text = money!
                
                setDayLabel.text = UserDefaults.standard.string(forKey: "now")
                
                UserDefaults.standard.set(goalDateLabel.text, forKey: "date")
                UserDefaults.standard.set(goalMoneyLabel.text, forKey: "money")
            
            }
            
            
        } else  {
            
            goalDateLabel.text = ""
            goalMoneyLabel.text = ""
            setDayLabel.text = ""
            
            UserDefaults.standard.set(goalDateLabel.text, forKey: "date")
            UserDefaults.standard.set(goalMoneyLabel.text, forKey: "money")
            UserDefaults.standard.set(setDayLabel.text, forKey: "now")
        }
        
    }
    
    
   
   
    
    private func buttonchar() {
        
        // ボタンの装飾
    
                                                        
              startButton.layer.borderWidth = 0.5                                              // 枠線の幅
                                       
             startButton.layer.cornerRadius = 15                                          // 角丸のサイズ
        startButton.setTitleColor(UIColor.white, for: UIControl.State.normal)//タイトルの色
        
      
                                                          
              resetButton.layer.borderWidth = 0.5                                              // 枠線の幅
                                     
             resetButton.layer.cornerRadius =  15                                           // 角丸のサイズ
        resetButton.setTitleColor(UIColor.white, for: UIControl.State.normal)//タイトルの色
        
    
  
  
  
        
    }
    
    private func userdef() {
        
        //userdefaults読み込み、出力
        
        
        let savedata1 = UserDefaults.standard.string(forKey: "timeView")
        
        
        timeLabel.text = savedata1
        
     //   reset.text =  UserDefaults.standard.string(forKey: "ct")
        
        
        
    

    }
    
 
    
    
    
  
    
    
    
  
 
    @IBAction func startAction(_ sender: Any) {
        
         
       
        
        if goalStatus() {
            
            startButton.isEnabled = false
        } else {
        
        
        if timerCounting {
            setStopTime(date: Date())
            stopTimer()
            startTimer()
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
            
            performSegue(withIdentifier: "toSetting", sender: nil)
        }
    }
          
    
    func calcRestartTime(start: Date, stop: Date) -> Date {
        
        let diff = start.timeIntervalSince(stop)
        
        return Date().addingTimeInterval(diff)
    }
    
    
    
    
    
    func startTimer() {
        
        scheduledTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(refreshValue), userInfo: nil, repeats: true)
        
        setTimerCounting(true)
   
        
        
        
        
        
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
      
    }
    
    
 
  
        
        
        
        
        
        
        
        
        
        
        
        
 //   }
    
    
    
    @IBAction func resetAction(_ sender: Any) {
        
    
            
        if goalStatus() {
            
        
     
        
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
               
                if dayRecode >= dayGoal  {
                    
                    print("目標達成！")
                    
                    UserDefaults.standard.set(self.timeLabel.text, forKey: "time")
                    
                    self.performSegue(withIdentifier: "toAchived", sender: nil)
                    
                    self.setStopTime(date: nil)
                    self.setStartTime(date: nil)
                    self.timeLabel.text = self.makeTimeString(day: 0, hour: 0, min: 0, sec: 0)
                    self.stopTimer()
                    
              //      self.setStartTime(date: Date())
                 
              //      self.startTimer()
                    
                    let  memo = memoDataModel()
                    
                    memo.date = ""
                    memo.context = ""
                    
                    self.setDayLabel.text = ""
                    UserDefaults.standard.set(self.setDayLabel.text, forKey: "now")
                    
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
                    
               //     self.setStartTime(date: Date())
                 
              //      self.startTimer()
                    
                    let  memo = memoDataModel()
                    
                    memo.date = ""
                    memo.context = ""
                    
                    self.setDayLabel.text = ""
                    UserDefaults.standard.set(self.setDayLabel.text, forKey: "now")
                    
                    UserDefaults.standard.set(memo.date, forKey: "date")
                    UserDefaults.standard.set(memo.context, forKey: "money")
                    UserDefaults.standard.set(false, forKey: "bool")
                    //ここに課金実装
                    self.premiumadd()
                    print("目標未達成")
                    
                    self.performSegue(withIdentifier: "toNext", sender: nil)
                    
                    UserDefaults.standard.set(false, forKey: "timeswitch")

                }
                
           
            
            } else {
                
                //目標が未設定だった場合
                
                UserDefaults.standard.set(self.timeLabel.text, forKey: "time")
                self.performSegue(withIdentifier: "toNext", sender: nil)
                
                    self.setStopTime(date: nil)
                    self.setStartTime(date: nil)
                    self.timeLabel.text = self.makeTimeString(day: 0, hour: 0, min: 0, sec: 0)
                    self.stopTimer()
                    
              //      self.setStartTime(date: Date())
                 
                  //  self.startTimer()
                UserDefaults.standard.set(false, forKey: "bool")
              
                
                
                print("era")
             
                UserDefaults.standard.set(false, forKey: "timeswitch")
                
                
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
            
        
        } else {
            
            resetButton.isEnabled = false
        }
       
        
    
    }
    
    
    
    func premiumadd() {
        
        if SKPaymentQueue.canMakePayments() {
            
            
            let paymentRequest = SKMutablePayment()
                     
                       if goalMoneyLabel.text == "500円" {
                      
                           paymentRequest.productIdentifier = productID500
                           
                           SKPaymentQueue.default().add(paymentRequest)
                           
                           print("500")
                         
                       } else if  goalMoneyLabel.text == "1100円" {
                         
                            paymentRequest.productIdentifier = productID1100
                           
                          SKPaymentQueue.default().add(paymentRequest)
                       } else if goalMoneyLabel.text == "3800円" {
                           
                           
                           paymentRequest.productIdentifier = productID3800
                           
                           SKPaymentQueue.default().add(paymentRequest)
                       }
            
            
                         else if goalMoneyLabel.text == "4900円" {
                         
                            paymentRequest.productIdentifier = productID4900
                           
                           SKPaymentQueue.default().add(paymentRequest)
                       } else if goalMoneyLabel.text == "10000円" {
                         
                           paymentRequest.productIdentifier = productID10000
                           
                           SKPaymentQueue.default().add(paymentRequest)
                       } else if goalMoneyLabel.text == "29400円" {
                         
                            paymentRequest.productIdentifier = productID29400
                           
                           SKPaymentQueue.default().add(paymentRequest)
                         
                       }
                     
                     
                 

         
            
        } else {
            
            //購入できません
            print("購入できません")
        }
        
    }
    
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        
        for transaction in transactions {
            
            if transaction.transactionState == .purchased {
                
             //Userpayment successful
                print("Transaction successful!")
                
                // Get receipt if available
                    if let appStoreReceiptURL = Bundle.main.appStoreReceiptURL,
                    FileManager.default.fileExists(atPath: appStoreReceiptURL.path) {

                    do {
                        let receiptData = try Data(contentsOf: appStoreReceiptURL, options: .alwaysMapped)
                        print(receiptData)

                        let receiptString = receiptData.base64EncodedString(options: [])

                        // Read ReceiptData
                    }
                    catch { print("Couldn't read receipt data with error: " + error.localizedDescription) }
                }
                
                SKPaymentQueue.default().finishTransaction(transaction)
            
            } else if transaction.transactionState == .failed {
                
                //payment failed
                print("Transaction failed!")
                
                if let error = transaction.error {
                    
                    let errorDescription = error.localizedDescription
                    print("Transaction failed due to error: \(errorDescription)")
                }
                
                SKPaymentQueue.default().finishTransaction(transaction)
            }
        }
        
    }
    
    
    
    @IBAction func setagoal(_ sender: Any) {
        

    
    
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

extension UIColor {
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor{
        return self.init(red: red / 255, green: green / 255, blue: blue / 155, alpha: 1)
    }
}


