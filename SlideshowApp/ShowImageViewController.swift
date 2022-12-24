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
    }
}
