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
    
    let AMonth: ActivityMonth = {
        let am = ActivityMonth()
        am.translatesAutoresizingMaskIntoConstraints = false
        am.backgroundColor = .orange
        return am
    }()
    
    let AMonthView: UIView = {
        let amv = UIView()
        amv.translatesAutoresizingMaskIntoConstraints = false
       return amv
    }()
    
    private func setupActivityMonth() {
    
    // Setup stackView //
    let stackView = UIStackView(arrangedSubviews: [AMonthView])
    stackView.axis = .vertical
    stackView.distribution = .fillProportionally
    stackView.alignment = .fill
    stackView.spacing = 5
    stackView.translatesAutoresizingMaskIntoConstraints = false
        
    // Set height and width of Activity Month View
    AMonthView.addSubview(AMonth)
    AMonthView.addConstraintsWithFormat(format: "H:|[v0]|", views: AMonth)
    AMonthView.addConstraintsWithFormat(format: "V:|[v0(100)]|", views: AMonth)
        
    // Set height and width for stackView
    view.addSubview(stackView)
        
    view.addConstraintsWithFormat(format: "H:|[v0]|", views: stackView)
    view.addConstraintsWithFormat(format: "V:|[v0]|", views: stackView)
        
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

