//
//  BaseTableViewCell.swift
//  AppStoreSearch
//
//  Created by HYUN SUNG on 9/14/24.
//

import UIKit
import RxSwift

class BaseTableViewCell: UITableViewCell {
    
    // MARK: - Rx
    var disposeBag = DisposeBag()
    
    // MARK: - Initializing
    override init(
        style: UITableViewCell.CellStyle,
        reuseIdentifier: String?
    ) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.separatorInset = .zero
        
        self.contentView.backgroundColor = .clear
        self.backgroundColor = .clear
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        self.init(style: .default, reuseIdentifier: nil)
    }
    
}
