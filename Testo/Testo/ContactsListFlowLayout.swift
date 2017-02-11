//
//  ContactsListFlowLayout.swift
//  Testo
//
//  Created by oskar morett on 2/10/17.
//  Copyright © 2017 oskar morett. All rights reserved.
//

import Foundation
import UIKit

class ContactsListFlowLayout: UICollectionViewFlowLayout {
   
   let itemHeight: CGFloat = 158
   
   
   override init() {
      super.init()
      setupLayout()
   }
   
   /**
    Init method
    
    - parameter aDecoder: aDecoder
    
    - returns: self
    */
   required init?(coder aDecoder: NSCoder) {
      super.init(coder: aDecoder)
      setupLayout()
   }
   
   /**
    Sets up the layout for the collectionView. 0 distance between each cell, and vertical layout
    */
   func setupLayout() {
      minimumInteritemSpacing = 5
      minimumLineSpacing = 5
      scrollDirection = .vertical
   }
   
   func itemWidth() -> CGFloat {
      return collectionView!.frame.width
   }
   
   override var itemSize: CGSize {
      set {
         self.itemSize = CGSize(width: itemWidth(), height: itemHeight)
      }
      get {
         return CGSize(width: itemWidth(), height: itemHeight)
      }
   }
   
   override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint) -> CGPoint {
      return collectionView!.contentOffset
   }
}

