//
//  ContactsGridFlowLayout.swift
//  Testo
//
//  Created by oskar morett on 2/10/17.
//  Copyright © 2017 oskar morett. All rights reserved.
//

import Foundation
import UIKit

class ContactsGridFlowLayout: UICollectionViewFlowLayout {
   
   let itemHeight: CGFloat = 158
   
   override init() {
      super.init()
      setupLayout()
   }
   
   required init?(coder aDecoder: NSCoder) {
      super.init(coder: aDecoder)
      setupLayout()
   }
   
   /**
    Sets up the layout for the collectionView. 0 distance between each cell, and vertical layout
    */
   func setupLayout() {
      minimumInteritemSpacing = 1
      minimumLineSpacing = 1
      scrollDirection = .vertical
   }
   
   func itemWidth() -> CGFloat {
      return (collectionView!.frame.width/2)-1
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

