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
        return am
    }()
    
    private func setupActivityMonth() {
    
    view.addSubview(AMonth)
        
    view.addConstraintsWithFormat(format: "H:|[v0]|", views: AMonth)
    view.addConstraintsWithFormat(format: "V:|-150-[v0]|", views: AMonth)
    
        
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

