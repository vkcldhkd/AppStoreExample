//
//  UIWindow.swift
//  AppStoreSearch
//
//  Created by HYUN SUNG on 9/14/24.
//

import UIKit

extension UIWindow {
    static var keyWindow: UIWindow? {
        if #available(iOS 13, *) {
            return UIApplication.shared.windows.first { $0.isKeyWindow }
        } else {
            return UIApplication.shared.keyWindow
        }
    }
    
    static var safeAreaBottomInset: CGFloat{
        return self.getSafeArea.bottom
    }
    
    static var getSafeArea: (top: CGFloat, bottom: CGFloat, left: CGFloat, right: CGFloat){
        return (
            UIWindow.keyWindow?.safeAreaInsets.top ?? 0,
            UIWindow.keyWindow?.safeAreaInsets.bottom ?? 0,
            UIWindow.keyWindow?.safeAreaInsets.left ?? 0,
            UIWindow.keyWindow?.safeAreaInsets.right ?? 0
        )
    }
}
