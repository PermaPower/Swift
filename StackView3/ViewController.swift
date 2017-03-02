//
//  ViewController.swift
//  StackView3
//
//  Created by David on 1/3/17.
//  Copyright © 2017 David. All rights reserved.
//

import UIKit

class ViewController: UICollectionViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Home"
        
        setupActivityMonth()
    }
    

    
    // Setup Activity Month //
    let AMonth: ActivityMonth = {
        let am = ActivityMonth()
        am.translatesAutoresizingMaskIntoConstraints = false
        return am
    }()
    
    // Add Activity Month to a UIView //
    let AMonthView: UIView = {
        let amv = UIView()
        amv.translatesAutoresizingMaskIntoConstraints = false
        return amv
    }()
    
    // TEST Label for scrollView //
    let label: UILabel = {
        let lbl = UILabel(frame: CGRect.zero)
        lbl.text = "Nothing to show"
        lbl.textAlignment = .center
        lbl.backgroundColor = .white
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    // Add scrollview //
    let scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.backgroundColor = UIColor.green
        sv.autoresizingMask = UIViewAutoresizing.flexibleWidth
        sv.autoresizingMask = UIViewAutoresizing.flexibleHeight
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.isScrollEnabled = true
        return sv
    }()
    
    // Add stackview //
    let stackView : UIStackView = {
        let sView = UIStackView()
        sView.axis = .vertical
        sView.distribution = .fillProportionally
        sView.alignment = .fill
        sView.spacing = 5
        sView.translatesAutoresizingMaskIntoConstraints = false
        return sView
    }()
    
    private func setupActivityMonth() {
        
        // Stop view from going under navigationbar
        edgesForExtendedLayout = []
        
        // Set height of Activity Month View
        AMonthView.addSubview(AMonth)
        AMonthView.addConstraintsWithFormat(format: "H:|[v0]|", views: AMonth)
        AMonthView.addConstraintsWithFormat(format: "V:|[v0(100)]|", views: AMonth)
        
        // Add scrollView //
        view.addSubview(scrollView)
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: scrollView)
        view.addConstraintsWithFormat(format: "V:|[v0]|", views: scrollView)
        
        // Setup StackView //
        scrollView.addSubview(stackView)
        
        // Add views to StackView //
        stackView.addArrangedSubview(label)
        stackView.addArrangedSubview(AMonthView)
        

        
        // Hide views not required
        // label.isHidden = true
        

        // Add stackview width contraint //
        stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        
        //scrollView.contentSize = CGSize(width: stackView.frame.width, height: stackView.frame.height)
        //scrollView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[stackView]|", options: NSLayoutFormatOptions.alignAllCenterX, metrics: nil, views: ["stackView": stackView]))
        
        scrollView.contentSize.height = 3000
        
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        AMonth.collectionView.collectionViewLayout.invalidateLayout()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

