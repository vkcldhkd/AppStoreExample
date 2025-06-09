//
//  UIView+Rx.swift
//  AppStoreSearch
//
//  Created by HYUN SUNG on 9/14/24.
//

import RxSwift
import UIKit


extension Reactive where Base: UIView {   
    var setNeedsLayout: Binder<Void> {
        return Binder(self.base) { view, _ in
            view.setNeedsLayout()
        }
    }
}

