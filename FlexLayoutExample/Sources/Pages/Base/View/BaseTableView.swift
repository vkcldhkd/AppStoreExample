//
//  BaseTableView.swift
//  AppStoreSearch
//
//  Created by HYUN SUNG on 9/13/24.
//

import UIKit

class BaseTableView: UITableView {
    
    override init(
        frame: CGRect,
        style: UITableView.Style
    ) {
        super.init(frame: frame, style: style)
        self.separatorStyle = .none
        self.separatorInset = .zero
        self.separatorColor = UIColor.clear
        self.showsVerticalScrollIndicator = false
        self.showsHorizontalScrollIndicator = false
        self.backgroundView = nil
        self.keyboardDismissMode = .onDrag
        self.backgroundColor = UIColor.clear
        if #available(iOS 15.0, *) {
            self.sectionHeaderTopPadding = 0
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
