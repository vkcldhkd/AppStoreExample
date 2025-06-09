//
//  SearchItemHeaderView.swift
//  AppStoreSearch
//
//  Created by HYUN SUNG on 9/14/24.
//

import UIKit

final class SearchItemHeaderView: BaseView {
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
//        self.headerTitleLabel.snp.makeConstraints { make in
//            make.edges.equalToSuperview().inset(20)
//        }
    }
}
