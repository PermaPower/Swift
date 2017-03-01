//
//  ActivityMonth.swift
//  StackView3
//
//  Created by David on 1/3/17.
//  Copyright © 2017 David. All rights reserved.
//

import UIKit

class ActivityMonth: UIView, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    
    
    let cellID = "CellID"
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        cv.delegate = self
        cv.dataSource = self
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
        let centerY = collectionView.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        let centerX = collectionView.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        NSLayoutConstraint.activate([leftConstraint, rightConstraint, bottomContraint, topConstraint, centerX, centerY])

        
    }
    
       
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath)
        
        cell.backgroundColor = .blue
        
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



    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   
    
}
