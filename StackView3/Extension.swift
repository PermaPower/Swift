//
//  Extension.swift
//  StackView3
//
//  Created by David on 1/3/17.
//  Copyright © 2017 David. All rights reserved.
//

import UIKit

// Extension for addConstraintsWithFormat
extension UIView {
    func addConstraintsWithFormat(format: String, views: UIView...){
        
        // Enumerate views within viewsDictionary
        var viewsDictionary = [String: UIView]()
        for (index,view) in views.enumerated() {
            let key = "v\(index)"
            view.translatesAutoresizingMaskIntoConstraints = false
            viewsDictionary[key] = view
        }
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutFormatOptions(), metrics: nil, views: viewsDictionary))
        
    }
}

extension UIViewController {
    func hideKeyboardWhenTappedAround(cancelTouch cancelTouchesInView: Bool) {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = cancelTouchesInView
        view.addGestureRecognizer(tap)
        
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension UIColor {
    convenience init(hex: Int) {
        let r = hex / 0x10000
        let g = (hex - r*0x10000) / 0x100
        let b = hex - r*0x10000 - g*0x100
        self.init(red: CGFloat(r)/255, green: CGFloat(g)/255, blue: CGFloat(b)/255, alpha: 1)
    }
}
