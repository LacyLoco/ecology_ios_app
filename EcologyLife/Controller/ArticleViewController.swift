//
//  ArticleViewController.swift
//  EcologyLife
//
//  Created by Полина on 15/03/2019.
//  Copyright © 2019 Polina. All rights reserved.
//

import UIKit
import WebKit

class ArticleViewController: UIViewController, WKNavigationDelegate {
     var webView: WKWebView!
     var menu: Article?

    let progressView: UIProgressView = {
        let view = UIProgressView(progressViewStyle: .default)
        view.progressTintColor = UIColor(red: 0.0, green: 122.0/255.0, blue: 1.0, alpha: 1.0)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    deinit {
        webView.removeObserver(self, forKeyPath: "estimatedProgress")
    }
    
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
        
        webView.addObserver(self,
                            forKeyPath: #keyPath(WKWebView.estimatedProgress),
                            options: .new,
                            context: nil)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?,
                               change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            if (Float(webView.estimatedProgress) == 1.0){
                 hideProgressView()
            }
            progressView.progress = Float(webView.estimatedProgress)
        }
    }
    
    //var indicator: UIActivityIndicatorView?
    override func viewDidLoad() {
        super.viewDidLoad()
        [progressView].forEach { self.view.addSubview($0) }
        progressView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        progressView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        progressView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        progressView.heightAnchor.constraint(equalToConstant: 2).isActive = true

        // 1
        let url = URL(string: menu?.link ?? "")
        webView.load(URLRequest(url: url!))
        
        // 2
        let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: webView, action: #selector(webView.reload))
        toolbarItems = [refresh]
        navigationController?.isToolbarHidden = false
        
    }
    
    func showProgressView() {
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut, animations: {
            self.progressView.alpha = 1.0
        }, completion: nil)
    }
    func hideProgressView() {
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut, animations: {
            self.progressView.alpha = 0.0
            //self.progressView.isHidden = true
            //self.progressView.removeFromSuperview()
        }, completion: nil)
    }

}
