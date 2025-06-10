//
//  SearchItemHeaderView.swift
//  AppStoreSearch
//
//  Created by HYUN SUNG on 9/14/24.
//

import UIKit
import FlexLayout

final class SearchItemHeaderView: BaseView {
    let rootFlexContainer = UIView()
    
    // MARK: - UI
    private let headerTitleLabel: UILabel = UILabel().then {
        $0.font = UIFont.boldSystemFont(ofSize: 20)
    }
    
    // MARK: - Initializing
    init(title: String?) {
        super.init(frame: .zero)
        self.setupUI(title: title)
        self.setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layout()
    }
    
    fileprivate func layout() {
        self.headerTitleLabel.pin.all().margin(12)
    }
}

extension SearchItemHeaderView {
    // MARK: - setupUI
    func setupUI(title: String?) {
        self.addSubview(self.headerTitleLabel)
        self.headerTitleLabel.text = title
        self.backgroundColor = .white
    }
    
    // MARK: - setupConstraints
    func setupConstraints() {
        self.layout()
    }
}
