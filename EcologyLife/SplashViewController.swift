//
//  ViewController.swift
//  EcologyLife
//
//  Created by Полина on 03/03/2019.
//  Copyright © 2019 Polina. All rights reserved.
//

import UIKit

class SplashViewController: UIViewController {
    
    var progressBar = UIProgressView()
    var myTime = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+3) {
            self.performSegue(withIdentifier: "nextPage", sender: nil)
        }
        createProgress(progressBar)
        createTimer()
        
    }
    
    func createTimer() {
        myTime = Timer.scheduledTimer(timeInterval: 1,
                                      target: self,
                                      selector: #selector(updateProgressView),
                                      userInfo: nil,
                                      repeats: true)
    }
    
    //MARK: - Selector
    @objc func updateProgressView() {
        if progressBar.progress != 1.0 {
            progressBar.progress += 0.4 / 1.0
            
        }else if progressBar.progress == 1.0 {
            UIView.animate(withDuration: 0.7) {
            }
        }
    }
    
    func createProgress(_ progressView: UIProgressView ) {
        progressView.progressViewStyle = .bar
        progressView.frame = CGRect(x: 124, y: 542, width: 180, height: 2)
        progressView.setProgress(0.0, animated: false)
        progressView.progressTintColor = UIColor.init(displayP3Red: 98.0/255.0, green: 192/255.0, blue: 133/255.0, alpha: 1)
        progressView.trackTintColor = UIColor.gray
        view.addSubview(progressView)
    }
}
