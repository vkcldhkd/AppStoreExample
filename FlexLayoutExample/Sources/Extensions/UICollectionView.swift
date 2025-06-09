//
//  UICollectionView.swift
//  AppStoreSearch
//
//  Created by HYUN SUNG on 9/14/24.
//

import UIKit

extension UICollectionView {
    func getCellSize(
        numberOfItemsRowAt: Int,
        width: CGFloat? = nil,
        sectionMargin: Int = 10
    ) -> CGSize {
        var screenWidth = width == nil ? self.frame.width : width!
        
        if #available(iOS 11.0, *) {
            let leftPadding = UIWindow.getSafeArea.left
            let rightPadding = UIWindow.getSafeArea.right
            screenWidth -= (leftPadding + rightPadding)
        }
        
        let margin = CGFloat((numberOfItemsRowAt - 1) * sectionMargin)
        let cellWidth =  (screenWidth - margin) / CGFloat(numberOfItemsRowAt)
        return CGSize(width: cellWidth, height: cellWidth)
    }
}
