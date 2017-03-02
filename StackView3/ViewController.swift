//
//  ViewController.swift
//  StackView3
//
//  Created by David on 1/3/17.
//  Copyright © 2017 David. All rights reserved.
//

import UIKit

class ViewController: UICollectionViewController {
    
    var scrollView: UIScrollView!
    
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
    
    private func setupActivityMonth() {
        
        // Stop view from going under navigationbar
        edgesForExtendedLayout = []

        // Set height of Activity Month View
        AMonthView.addSubview(AMonth)
        AMonthView.addConstraintsWithFormat(format: "H:|[v0]|", views: AMonth)
        AMonthView.addConstraintsWithFormat(format: "V:|[v0(100)]|", views: AMonth)
        
        // Add scrollView //
        scrollView = UIScrollView(frame: view.bounds)
        scrollView.backgroundColor = UIColor.green
        scrollView.autoresizingMask = UIViewAutoresizing.flexibleWidth
        scrollView.autoresizingMask = UIViewAutoresizing.flexibleHeight
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.isScrollEnabled = true
        
        view.addSubview(scrollView)
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: scrollView)
        view.addConstraintsWithFormat(format: "V:|[v0]|", views: scrollView)
        
        // Setup StackView //
        let stackView = UIStackView(arrangedSubviews: [label, AMonthView])
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.alignment = .fill
        stackView.spacing = 5
        stackView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(stackView)
        
        stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        
        //scrollView.contentSize = CGSize(width: stackView.frame.width, height: stackView.frame.height)
        //scrollView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[stackView]|", options: NSLayoutFormatOptions.alignAllCenterX, metrics: nil, views: ["stackView": stackView]))
        
        scrollView.contentSize.height = 3000
        
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        AMonth.collectionView.collectionViewLayout.invalidateLayout()
        collectionView?.collectionViewLayout.invalidateLayout()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
 
}

