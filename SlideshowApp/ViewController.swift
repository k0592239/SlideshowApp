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
        UIImage(named: "scr1")!,
        UIImage(named: "scr2")!,
        UIImage(named: "scr3")!,
        UIImage(named: "scr4")!,
        UIImage(named: "scr5")!,
        UIImage(named: "scr6")!
    ]
    // 表示するスライドの位置
    var imageIndex = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.imageIndex = 0
        imageView.image = imageArray[self.imageIndex]
        let imgTap = UITapGestureRecognizer(target: self, action: #selector(self.imageTapped))
        imageView.addGestureRecognizer(imgTap)
        imageView.isUserInteractionEnabled = true
    }
    @objc func imageTapped(sender: UITapGestureRecognizer) {
            if sender.state == .ended {
                    print("UIImageView tapped")
            }
    }

    // 進むボタン IBAction
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
        if isOutSlide {
            playStopButton.setTitle("再生", for: .normal)
            resetTimer()
        } else {
            playStopButton.setTitle("停止", for: .normal)
            startTimer()
        }
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

    // 再生ボタン IBAction
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
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let showImageViewController:ShowImageViewController = segue.destination as! ShowImageViewController
        showImageViewController.selectImageView = imageView
    }
}

