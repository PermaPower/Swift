//
//  ViewController.swift
//  StackView3
//
//  Created by David on 1/3/17.
//  Copyright © 2017 David. All rights reserved.
//

import UIKit

class ViewController: UICollectionViewController, UITextViewDelegate {
    
    private var ActivityMonthButtons = ActivityMonth()
    
    private var ButtonFlag = 0
    
    private let cellID = "CellID"
    
    var showActivityMonthNote: Dictionary <String, Bool> = ["Jan": false, "Feb": false, "Mar": false, "Apr": false, "May": false, "Jun": false, "Jul": false, "Aug": false, "Sep": false, "Oct": false, "Nov": false, "Dec": false]
    
    
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
    
    // Label for scrollView //
    let label: UILabel = {
        let lbl = UILabel(frame: CGRect.zero)
        lbl.textAlignment = .center
        lbl.textColor = UIColor.white
        lbl.adjustsFontSizeToFitWidth = true
        lbl.numberOfLines = 0
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    // Text view
    let textView: UITextView = {
        let tv = UITextView(frame: CGRect.zero)
        tv.textColor = UIColor.lightGray
        tv.becomeFirstResponder()
        tv.selectedTextRange = tv.textRange(from: tv.beginningOfDocument, to: tv.beginningOfDocument)
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.isScrollEnabled = false
        tv.text = "Enter notes"
        tv.layer.cornerRadius = tv.frame.size.height / 2
        tv.clipsToBounds = false
        tv.layer.shadowOpacity = 0.4
        tv.layer.shadowOffset = CGSize(width: 3, height: 3)
        
        return tv
    }()
    
    // Add scrollview //
    let scrollView: UIScrollView = {
        let sv = UIScrollView()

        sv.backgroundColor = UIColor.init(patternImage: #imageLiteral(resourceName: "bg-sunny"))
        
        sv.autoresizingMask = UIViewAutoresizing.flexibleWidth
        sv.autoresizingMask = UIViewAutoresizing.flexibleHeight
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.bounces = false
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
        sView.isLayoutMarginsRelativeArrangement = true
        sView.translatesAutoresizingMaskIntoConstraints = false
        return sView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Link this ViewController to the observer for Activity Month Button Variables
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.actOnSpecialNotification), name: NSNotification.Name(rawValue: "buttonKey"), object: nil)
        
        // Title of the viewcontroller
        navigationItem.title = "Home"
       
        // Setup the structure of the view
        setupActivityMonth()
        
    }
    
    // Take action on notification //
    func actOnSpecialNotification() {
        
        if ActivityMonthButtons.buttonPressedIsState == true {
            ButtonFlag = ButtonFlag + 1
            showNotes()
            // Update ahowActivityMonthNote flag in dictionary
            showActivityMonthNote.updateValue(true, forKey: ActivityMonthButtons.buttonPressedNameIs)
        } else {
            ButtonFlag = ButtonFlag - 1
            showNotes()
            // Update ahowActivityMonthNote flag in dictionary
            showActivityMonthNote.updateValue(false, forKey: ActivityMonthButtons.buttonPressedNameIs)
        }
        
    }
    
    // Hide or Shows notes view based on ActivityMonthButtons Button Flag value
    func showNotes() {
        
        // No button had been pressed
        if ButtonFlag == 0 {
            UIView.animate(withDuration: 0.35,
                           delay: 0,
                           options: [ .curveEaseIn ],
                           animations: {
                            self.textView.isHidden = true
            },  completion: nil)
            
            // Short delay
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(0.35)) {
                
                if self.stackView.arrangedSubviews.index(of: self.textView) != nil {
                    // we found the current webview in the stack view! Remove it from the stack view
                    self.stackView.removeArrangedSubview(self.textView)
                    
                    // now remove it from the view hierarchy – this is important!
                    self.textView.removeFromSuperview()
                    self.AMonth.collectionView.collectionViewLayout.invalidateLayout()
                }
            }
            
        } else {
            // Add textView as at least one button has been pressed
            stackView.addArrangedSubview(textView)
            UIView.animate(withDuration: 0.35,
                           delay: 0,
                           options: [ .curveEaseOut ],
                           animations: {
                            self.textView.isHidden = false
            },  completion: nil)
            

            
        }
    }
    
    private func setupActivityMonth() {
        
        // Stop view from going under navigationbar
        edgesForExtendedLayout = []
        automaticallyAdjustsScrollViewInsets = false
        
        // Set height of Activity Month View
        AMonthView.addSubview(AMonth)
        AMonthView.addConstraintsWithFormat(format: "H:|[v0]|", views: AMonth)
        AMonthView.addConstraintsWithFormat(format: "V:|[v0(100)]|", views: AMonth)
        
        // Add scrollView
        view.addSubview(scrollView)
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: scrollView)
        view.addConstraintsWithFormat(format: "V:|[v0]|", views: scrollView)
        
        // Add clouds //
        let cloudy1 = UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
        cloudy1.image = UIImage(named: "bg-sunny-cloud-1")
        scrollView.addSubview(cloudy1)
        
        let cloudy2 = UIImageView(frame: CGRect(x: 80, y: 100, width: 110, height: 40))
        cloudy2.image = UIImage(named: "bg-sunny-cloud-2")
        scrollView.addSubview(cloudy2)
  
        
        UIView.animate(withDuration: 100, delay: 1,
                       options: [.repeat, .autoreverse, .curveEaseInOut],
                       animations: {
                        cloudy1.center.x += self.view.bounds.width
        }, 
                       completion: nil
        )
        
        
        UIView.animate(withDuration: 150, delay: 10,
                       options: [.repeat, .autoreverse, .curveEaseInOut],
                       animations: {
                        cloudy2.center.x += self.view.bounds.width
        },
                       completion: nil
        )
        
          // Setup StackView
        scrollView.addSubview(stackView)
        
        // Add views to StackView
        
        stackView.addArrangedSubview(label)
        label.text = "Plant activity months"
        label.font = label.font.withSize(22)
        stackView.addConstraintsWithFormat(format: "H:|[v0]|", views: label)
        stackView.addConstraintsWithFormat(format: "V:[v0]", views: label)
        
        stackView.addArrangedSubview(textView)
        stackView.addConstraintsWithFormat(format: "H:|[v0]|", views: textView)
        stackView.addConstraintsWithFormat(format: "V:[v0]", views: textView)

        // Add Activity Month View to the StackView
        stackView.addArrangedSubview(AMonthView)
        
        // Add stackview width contraint
        stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        
        // Setup inital display for Actvity notes
        textView.isHidden = true
        
        // Initilise showNotes view (should based on number of button pressed)
        showNotes()
        
        //scrollView.contentSize = CGSize(width: stackView.frame.width, height: stackView.frame.height)
       // scrollView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[stackView]|", options: NSLayoutFormatOptions.alignAllCenterX, metrics: nil, views: ["stackView": stackView]))
        scrollView.contentSize.height = 3000
        
        // Dismiss keyboard if the scrollview has been scrolled
        scrollView.keyboardDismissMode = UIScrollViewKeyboardDismissMode.onDrag
        
        // Set the delegate for the textView and hide the keyboard on initialisation
        textView.delegate = self
        textView.resignFirstResponder()
        
        // Calls extention to cancel touches if not in view.  This also hides the keyboard
        hideKeyboardWhenTappedAround(cancelTouch: false)
    }
    
    // Scrolls the scrollview to the top when shown
    override func scrollViewShouldScrollToTop(_ scrollView: UIScrollView) -> Bool {
        return true
    }
    
    // Detects any touches on the screen (Array)
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        textView.endEditing(true)
        textView.resignFirstResponder()
        super.touchesBegan(touches, with: event)
    }
    
    // Reddraws view if screen is rotated
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        AMonth.collectionView.collectionViewLayout.invalidateLayout()
    }
    
    // Manage warning messages
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Sets up textview placeholder text
    func textViewDidBeginEditing(_ textView: UITextView) {
        if (textView.text == "Enter notes")
        {
            textView.text = ""
            textView.textColor = UIColor.black
        }
        textView.becomeFirstResponder()
    }
    
    // ReEnters placeholder text if the textView was edited back to nothing and resets text color
    func textViewDidEndEditing(_ textView: UITextView) {
        if (textView.text == "")
        {
            textView.text = "Enter notes"
            textView.textColor = UIColor.lightGray
        }
        textView.resignFirstResponder()
    }
    
    // Scrolls textView to the top of the screen (to make sure keyboard fits)
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        let pointInTable:CGPoint = textView.superview!.convert(textView.frame.origin, to: scrollView)
        var contentOffset:CGPoint = scrollView.contentOffset
        contentOffset.y  = pointInTable.y
        if let accessoryView = textView.inputAccessoryView {
            contentOffset.y -= accessoryView.frame.size.height
        }
        scrollView.contentOffset = contentOffset
        return true
    }
    
  }
