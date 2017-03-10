//
//  ActivityMonth.swift
//  StackView3
//
//  Created by David on 1/3/17.
//  Copyright © 2017 David. All rights reserved.
//

import UIKit

class ActivityMonth: UIView, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    let mySpecialNotificationkey = "buttonKey"
    
    struct AMVariables {
        static var buttonNumber = 0
        static var buttonNumberState = Bool()
        static var buttonNameString = String()
    }
        
    // Month names
    private let months: [String] = ["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"]
    
    private let cellID = "CellID"
    
    var buttonPressedIs: Int {
        get {
            return AMVariables.buttonNumber
        }
       
    }
    
    var buttonPressedNameIs: String {
        get {
            return AMVariables.buttonNameString
        }
    }
    
    var buttonPressedIsState: Bool {
        get {
            return AMVariables.buttonNumberState
        }
    }

    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        cv.delegate = self
        cv.dataSource = self
        cv.allowsMultipleSelection = true
        cv.translatesAutoresizingMaskIntoConstraints = false
        
        cv.layer.cornerRadius = cv.frame.size.height / 2
        cv.clipsToBounds = false
        cv.layer.shadowOpacity = 0.4
        cv.layer.shadowOffset = CGSize(width: 3, height: 3)
        
        return cv
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellID)
        
        addSubview(collectionView)
        
        addConstraintsWithFormat(format: "H:|-10-[v0]-10-|", views: collectionView)
        addConstraintsWithFormat(format: "V:|[v0]|", views: collectionView)
   
    }
    
       
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as UICollectionViewCell
        
        cell.backgroundColor = UIColor.white.withAlphaComponent(0.8)
        
        let textLabel = UILabel(frame: CGRect(x: 0, y: 0, width: cell.frame.size.width, height: cell.frame.size.height))
        
        textLabel.textAlignment = NSTextAlignment.center
        textLabel.textColor = UIColor.darkGray
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.numberOfLines = 1
        textLabel.adjustsFontSizeToFitWidth = true
        textLabel.minimumScaleFactor = 0.5
        textLabel.sizeToFit()
        
        textLabel.text = "\(months[indexPath.row])"
        cell.contentView.addSubview(textLabel)
        
        cell.contentView.addConstraintsWithFormat(format: "H:|[v0]|", views: textLabel)
        cell.contentView.addConstraintsWithFormat(format: "V:|[v0]|", views: textLabel)
        
        cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 5
        cell.layer.borderColor = UIColor.cyan.cgColor
        cell.layer.masksToBounds = true
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemsPerRow: CGFloat = 7
        let sectionInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = UIScreen.main.bounds.width  - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        return CGSize(width: widthPerItem, height: ((self.frame.height) / 2 ) - (sectionInsets.left * 2))
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        AMVariables.buttonNumber = indexPath.item
        AMVariables.buttonNumberState = true
        AMVariables.buttonNameString = months[indexPath.item]
        
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.backgroundColor = UIColor.cyan
        
        // Setup NotificationCenter with "buttonKey" notification key
        NotificationCenter.default.post(name: Notification.Name(rawValue: mySpecialNotificationkey), object: self)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        
        AMVariables.buttonNumber = indexPath.item
        AMVariables.buttonNumberState = false
        
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.backgroundColor = UIColor.white.withAlphaComponent(0.8)
        
        // Setup NotificationCenter with "buttonKey" notification key
        NotificationCenter.default.post(name: Notification.Name(rawValue: mySpecialNotificationkey), object: self)

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
   
    
}
