//
//  ViewController.swift
//  StackView3
//
//  Created by David on 1/3/17.
//  Copyright © 2017 David. All rights reserved.
//

import UIKit

class ViewController: UICollectionViewController {
    
    private var ActivityMonthButtons = ActivityMonth()
    
    //  private var ActivityMonthButtonHasBeenPressed = Bool()
    
    private var ButtonFlag = 0
    
    private let cellID = "CellID"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Link this ViewController to the observer for Activity Month Button Variables
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.actOnSpecialNotification), name: NSNotification.Name(rawValue: "buttonKey"), object: nil)
        
        navigationItem.title = "Home"
        
        setupActivityMonth()
    }
    
    // Take action on notification //
    func actOnSpecialNotification() {
        
        print(ActivityMonthButtons.buttonPressedIs)
        print(ActivityMonthButtons.buttonPressedIsState)
        
        if ActivityMonthButtons.buttonPressedIsState == true {
            ButtonFlag = ButtonFlag + 1
            showNotes()
        }else{
            ButtonFlag = ButtonFlag - 1
            showNotes()
        }
        
    }
    
    func showNotes() {
        if ButtonFlag == 0 {
            UIView.animate(withDuration: 0.35,
                           delay: 0,
                           options: [ .curveEaseIn ],
                           animations: {
                            self.label.isHidden = true
            },  completion: nil)
            
        } else {
            stackView.addArrangedSubview(label)
            UIView.animate(withDuration: 0.35,
                           delay: 0,
                           options: [ .curveEaseOut ],
                           animations: {
                            self.label.isHidden = false
            },  completion: nil)
        }
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
        
        // Add stackview width contraint //
        stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        
        // Setup inital display for Actvity notes //
        // label.isHidden = true
        self.label.isHidden = true
        
        showNotes()
        
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

