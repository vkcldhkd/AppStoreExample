//
//  UILabel.swift
//  FlexLayoutExample
//
//  Created by HYUN SUNG on 6/13/25.
//

import UIKit
import RxSwift
import FlexLayout

extension UILabel {
    var flexNumberOfLines: Int {
        get { return self.numberOfLines }
        set {
            self.numberOfLines = newValue
            self.flex.markDirty()
        }
    }
}
