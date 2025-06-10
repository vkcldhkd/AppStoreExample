//
//  UIView.swift
//  AppStoreSearch
//
//  Created by HYUN SUNG on 9/14/24.
//

import UIKit
import FlexLayout

extension UIView {
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    var isDisplay: Bool {
        get {
            return self.isHidden
        }
        set {
            self.isHidden = newValue
            self.flex.display(newValue ? .none : .flex)
            self.setNeedsLayout()
        }
    }
}
