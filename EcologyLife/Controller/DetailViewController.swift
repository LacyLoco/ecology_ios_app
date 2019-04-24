//
//  DetailViewController.swift
//  EcologyLife
//
//  Created by Полина on 12/03/2019.
//  Copyright © 2019 Polina. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

   // fileprivate var mainView = BaseScrollView(disableTapGesture: true, insets: .zero)
    
    @IBOutlet weak var recycleImageView: UIImageView! {
        didSet {
            guard let image = menu?.recycleImageName else {return}
            recycleImageView.image = UIImage(named: image)
        }
    }
    @IBOutlet weak var recycleNameLabel: UILabel! {
        didSet {
            recycleNameLabel.text = menu?.recycleName
        }
    }
    @IBOutlet weak var recNotificaionNameLabel: UILabel! {
        didSet {
            recNotificaionNameLabel.text = menu?.recycleNotificationName
        }
    }
  
    @IBOutlet weak var recycleTextLabel: UILabel!
    
    var menu: RecycleArticle?
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        recycleTextLabel.text = menu?.recycleTextView
        recycleTextLabel.sizeToFit()
        scrollView.contentSize.height = 1000

        //scrollView.setContentOffset(CGPoint(x: 0, y: 1000), animated: true)
       // recycleImageView.layoutMargins = UIEdgeInsets(top: 1000, left: 8, bottom: 0, right: 0)
       // mainView.addSubview(recycleImageView)
//        mainView.addSubview(recycleNameLabel)
       // mainView.addSubview(recNotificaionNameLabel)
//        scrollView.removeFromSuperview()
//        view.addSubview(mainView)
        // Do any additional setup after loading the view.
    }
    
    
}
