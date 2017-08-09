//
//  檔名： ViewController.swift
//  專案： CommonName
//
//  《Swift 入門指南》 V3.00 的範例程式
//  購書連結
//         Google Play  : https://play.google.com/store/books/details?id=AO9IBwAAQBAJ
//         iBooks Store : https://itunes.apple.com/us/book/id1079291979
//         Readmoo      : https://readmoo.com/book/210034848000101
//         Pubu         : http://www.pubu.com.tw/ebook/65565?apKey=576b20f092
//
//  作者網站： http://www.kaiching.org
//  電子郵件： kaichingc@gmail.com
//
//  作者： 張凱慶
//  時間： 2017/08/03
//

import Cocoa
import GameplayKit

class ViewController: NSViewController {
    //MARK: 屬性
    
    //遊戲資料
    var nameData = [["Jacob", "雅各"],
                    ["Mason", "梅森"],
                    ["Ethan", "伊森"],
                    ["Noah", "諾亞"],
                    ["William", "威廉"],
                    ["Sophia", "蘇菲雅"],
                    ["Emma", "艾瑪"],
                    ["Isabella", "伊莎貝拉"],
                    ["Olivia", "奧莉薇亞"],
                    ["Ava", "艾娃"]]
    
    //原始順序
    let array = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
    //題目與隨機排列的選項
    var answer = [Int:[Int]]()
    //題目順序
    var answerOrder = [Int]()
    
    //記錄遊戲次數
    var times = 0
    //記錄玩家按下哪個按鈕
    var useranswer: Int?
    //累計分數
    var score = 0
    
    //MARK: 視窗屬性
    @IBOutlet weak var question: NSTextField!
    @IBOutlet weak var display: NSTextField!
    @IBOutlet weak var button1: NSButton!
    @IBOutlet weak var button2: NSButton!
    @IBOutlet weak var button3: NSButton!
    @IBOutlet weak var button4: NSButton!
    
    //MARK: 視窗方法
    @IBAction func method1(_ sender: NSButton) {
        useranswer = 0
        next()
    }
    
    @IBAction func method2(_ sender: NSButton) {
        useranswer = 1
        next()
    }
    
    @IBAction func method3(_ sender: NSButton) {
        useranswer = 2
        next()
    }
    
    @IBAction func method4(_ sender: NSButton) {
        useranswer = 3
        next()
    }
    
    
    //MARK: 方法
    
    func next() {
        //檢查玩家是否有答對做分數加減
        if let userinput = useranswer {
            if answerOrder[times] == answer[answerOrder[times]]![userinput] {
                score += 1
            }
            else {
                score -= 1
            }
            
            display.stringValue = "分數： " + String(score)
        }
        times += 1
        
        //
        if times == 10 {
            times = -1
            button1.isEnabled = false
            button2.isEnabled = false
            button3.isEnabled = false
            button4.isEnabled = false
        }
        
        if times == -1 {
            question.stringValue = "測驗結束"
            button1.title = ""
            button2.title = ""
            button3.title = ""
            button4.title = ""
        }
        else {
            showQuestions()
        }
    }
    
    func showQuestions() {
        //設定題目
        question.stringValue = nameData[answerOrder[times]][1]
        //設定選項
        let one = answer[answerOrder[times]]![0]
        let two = answer[answerOrder[times]]![1]
        let three = answer[answerOrder[times]]![2]
        let four = answer[answerOrder[times]]![3]
        button1.title = nameData[one][0]
        button2.title = nameData[two][0]
        button3.title = nameData[three][0]
        button4.title = nameData[four][0]
    }
    
    //隨機排列問題、答案的組合
    func setAnswerArray() {
        //設定答案與選項
        for item in array {
            answer[item] = [item]
            var count = 0
            var r = -1
            while true {
                r = Int(arc4random() % 10)
                if answer[item]!.contains(r) {
                    continue
                }
                if count == 3 {
                    break
                }
                answer[item]?.append(r)
                count += 1
            }
        }
        
        //攪亂選項順序
        for (item1, item2) in answer {
            answer[item1] = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: item2) as? [Int]
        }
        
        //攪亂題目順序
        answerOrder = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: array) as! [Int]
    }
    
    //MARK: 預設方法
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setAnswerArray()
        showQuestions()
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

