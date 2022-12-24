//
//  ShowImageViewController.swift
//  SlideshowApp
//
//  Created by 佐藤佳子 on 2022/12/22.
//

import UIKit

class ShowImageViewController: UIViewController {

    @IBOutlet weak var selectImageView: UIImageView!
    var image:UIImage!
    override func viewDidLoad() {
        super.viewDidLoad()
        selectImageView.image = image
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
