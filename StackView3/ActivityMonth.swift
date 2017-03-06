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
    }
        
    // Month names
    private let months: [String] = ["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"]
    
    private let cellID = "CellID"
    
    var buttonPressedIs: Int {
        get {
            return AMVariables.buttonNumber
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
   
        return cv
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellID)
        
        addSubview(collectionView)
        
        let leftConstraint = collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor)
        let rightConstraint = collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        let topConstraint = collectionView.topAnchor.constraint(equalTo: self.topAnchor)
        let bottomContraint = collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
                
        NSLayoutConstraint.activate([leftConstraint, rightConstraint, bottomContraint, topConstraint])

    }
    
       
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as UICollectionViewCell
        
        cell.backgroundColor = .blue
        
        let textLabel = UILabel(frame: CGRect(x: 0, y: 0, width: cell.frame.size.width, height: cell.frame.size.height))
        
        textLabel.textAlignment = NSTextAlignment.center
        textLabel.textColor = .white
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.numberOfLines = 1
        textLabel.adjustsFontSizeToFitWidth = true
        textLabel.minimumScaleFactor = 0.5
        textLabel.sizeToFit()
        
        textLabel.text = "\(months[indexPath.row])"
        cell.contentView.addSubview(textLabel)
        
        cell.contentView.addConstraintsWithFormat(format: "H:|[v0]|", views: textLabel)
        cell.contentView.addConstraintsWithFormat(format: "V:|[v0]|", views: textLabel)
        
        cell.layer.borderWidth = 2
        cell.layer.cornerRadius = 5
        cell.layer.borderColor = UIColor.white.cgColor
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
     //   print("cell \(indexPath.row) selected")
        
        AMVariables.buttonNumber = indexPath.item
        AMVariables.buttonNumberState = true
        
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.backgroundColor = .red
        
        // Setup NotificationCenter with "buttonKey" notification key
        NotificationCenter.default.post(name: Notification.Name(rawValue: mySpecialNotificationkey), object: self)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
  //    print("cell \(indexPath.row) deselected")
        
        AMVariables.buttonNumber = indexPath.item
        AMVariables.buttonNumberState = false
        
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.backgroundColor = .blue
        
        // Setup NotificationCenter with "buttonKey" notification key
        NotificationCenter.default.post(name: Notification.Name(rawValue: mySpecialNotificationkey), object: self)

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   
    
}
