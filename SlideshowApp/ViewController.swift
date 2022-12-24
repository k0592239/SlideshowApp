//
//  ViewController.swift
//  SlideshowApp
//
//  Created by 佐藤佳子 on 2022/12/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var forwardButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var playStopButton: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    // タイマー
    var timer: Timer!
    // タイマー用の時間のための変数
    var timerSec: Float = 0
    // 自動送り
    var isOutSlide: Bool = false
    // スライドショーさせる画像の配列を宣言
    var imageArray:[UIImage] = [
        UIImage(named: "scr01.jpg")!,
        UIImage(named: "scr02.jpg")!,
        UIImage(named: "scr03.jpg")!,
        UIImage(named: "scr04.jpg")!,
        UIImage(named: "scr05.jpg")!,
        UIImage(named: "scr06.jpg")!,
        UIImage(named: "scr07.jpg")!,
        UIImage(named: "scr08.jpg")!
    ]
    // 表示するスライドの位置
    var imageIndex = 0
    // 画面の表示
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.imageIndex = 0
        imageView.image = imageArray[self.imageIndex]
        var configuration = UIButton.Configuration.filled()
        configuration.cornerStyle = .capsule
        configuration.imagePadding = 8
        configuration.title = "再生"
        playStopButton.configuration = configuration
        playStopButton.titleLabel?.font = UIFont.systemFont(ofSize: 30)
    }
    // 進むボタン
    @IBAction func forward(_ sender: Any) {
        setImageIndexForward()
        imageView.image = self.imageArray[self.imageIndex]
    }
    // 戻るボタン IBAction
    @IBAction func back(_ sender: Any) {
        setImageIndexBack()
        imageView.image = self.imageArray[self.imageIndex]
    }

    // 再生／停止ボタン IBAction
    @IBAction func playStop(_ sender: Any) {
        // 再生・停止ボタンの見た目の変更
        var title:String
        var icon:String
        if isOutSlide {
            title = "再生"
            icon = "play.circle"
            resetTimer()
        } else {
            title = "停止"
            icon = "stop.circle"
            startTimer()
        }
//        playStopButton.setTitle(title, for: .normal)
        playStopButton.configuration?.title = title
        playStopButton.setImage(UIImage(systemName: icon,
                                        withConfiguration: UIImage.SymbolConfiguration(scale: .large)), for: .normal)
        
//        playStopButton.titleLabel?.font = UIFont.systemFont(ofSize: 30)
//        playStopButton.titleLabel?.font = playStopButton.titleLabel?.font.withSize(50)
//        playStopButton.titleLabel?.font = UIFont(name: "Arial", size: 50)
//        playStopButton.titleLabel?.font = UIFont(name: "Zapfino", size: 50)
        // 戻る、進むボタンの設定
        forwardButton.isEnabled.toggle()
        backButton.isEnabled.toggle()
        isOutSlide.toggle()
    }
    // selector: #selector(updatetimer(_:)) で指定された関数
    // timeInterval: 2.0, repeats: true で指定された通り、2.0秒毎に呼び出され続ける
    @objc func updateTimer(_ timer: Timer) {
        self.timerSec += 2.0
        setImageIndexForward()
        imageView.image = self.imageArray[self.imageIndex]
    }
    // 進むボタン押下時の画像インデックスを設定
    func setImageIndexForward() {
        if (self.imageIndex == self.imageArray.count - 1) {
            self.imageIndex = 0
        } else {
            self.imageIndex += 1
        }
    }
    // 戻るボタン押下時の画像インデックスを設定
    func setImageIndexBack() {
        if (self.imageIndex == 0) {
            self.imageIndex = self.imageArray.count - 1
        } else {
            self.imageIndex -= 1
        }
    }
    // タイマースタート
    func startTimer() {
        // タイマーの作成、始動
        if self.timer == nil {
            self.timer =  Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(updateTimer(_:)), userInfo: nil, repeats: true)
        }
    }
    // タイマーのリセット
    func resetTimer() {
        // リセットボタンを押すと、タイマ＝の時間を0にする
        self.timerSec = 0
        if self.timer != nil {
            self.timer.invalidate()   // タイマーを停止する
            self.timer = nil          // startTimer() の self.timer == nil で判断するために、 self.timer = nil としておく
        }
    }
    // 画面繊維（字画面に表示する画像の設定）
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let showImageViewController:ShowImageViewController = segue.destination as! ShowImageViewController
        showImageViewController.image = imageView.image
    }
    // 画像タップ
    @IBAction func imageTapped(_ sender: Any) {
    }

    @IBAction func unwind(_ segue: UIStoryboardSegue) {
    }
}

