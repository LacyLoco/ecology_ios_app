//
//  BaseSxrollView.swift
//  EcologyLife
//
//  Created by Полина on 15/03/2019.
//  Copyright © 2019 Polina. All rights reserved.
//

import UIKit
import PinLayout

class BaseScrollView: UIView {
    
    let scrollView = UIScrollView()
    
    fileprivate let insets: UIEdgeInsets
    
    init(disableTapGesture: Bool, insets: UIEdgeInsets = .zero) {
        self.insets = insets
        
        super.init(frame: UIScreen.main.bounds)
        
        scrollView.showsVerticalScrollIndicator = false
        
        //        scrollView.keyboardDismissMode = .onDrag
        
        if !disableTapGesture {
            scrollView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapScrollView)))
        }
        
        addSubview(scrollView)
        
       // NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: .UIKeyboardWillShow, object: nil)
        //NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: .UIKeyboardWillHide, object: nil)
        
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        scrollView.pin.top(insets.top).left().right().bottom(pin.safeArea + insets.bottom)
    }
    
    @objc
    internal func keyboardWillShow(notification: Notification) {
        guard let sizeValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        setFormScrollView(bottomInset: sizeValue.cgRectValue.height)
    }
    
    @objc
    internal func keyboardWillHide(notification: Notification) {
        resetScrollOffset()
    }
    
    @objc
    internal func didTapScrollView() {
        endEditing(true)
        resetScrollOffset()
    }
    
    fileprivate func resetScrollOffset() {
        guard scrollView.contentInset != .zero else { return }
        setFormScrollView(bottomInset: 0)
    }
    
    fileprivate func setFormScrollView(bottomInset: CGFloat) {
        scrollView.contentInset = UIEdgeInsets(top: scrollView.contentInset.top, left: 0, bottom: bottomInset, right: 0)
    }
}

