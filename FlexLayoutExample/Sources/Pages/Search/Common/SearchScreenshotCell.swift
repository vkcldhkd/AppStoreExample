//
//  SearchScreenshotCell.swift
//  AppStoreSearch
//
//  Created by HYUN SUNG on 9/14/24.
//

import UIKit
import ReactorKit
import FlexLayout

final class SearchScreenshotCell: BaseCollectionViewCell {
    typealias Reactor = SearchScreenshotCellReactor
    
    let imageView: UIImageView = UIImageView().then {
        $0.backgroundColor = UIColor.lightGray
        $0.cornerRadius = 8
    }
    
    // MARK: Initializing
    override init(frame: CGRect) {
        super.init(frame: .zero)
        self.setupUI()
        self.setupConstraints()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.imageView.image = nil
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layout()
    }
    
    fileprivate func layout() {
        self.imageView.pin.all()
    }
}

private extension SearchScreenshotCell {
    // MARK: - setupUI
    func setupUI() {
        self.contentView.addSubview(self.imageView)
    }
    
    // MARK: - setupConstraints
    func setupConstraints() {
        self.layout()
    }
}

extension SearchScreenshotCell: ReactorKit.View {
    func bind(reactor: Reactor) {
        // MARK: - Action
        
        // MARK: - State
        reactor.state.map { _ in }
            .bind(to: self.rx.setNeedsLayout)
            .disposed(by: self.disposeBag)
        
        reactor.state.map { $0.url }
            .distinctUntilChanged()
            .compactMap { URLHelper.createEncodedURL(url: $0) }
            .bind(to: self.imageView.kf.rx.image())
            .disposed(by: self.disposeBag)
    }
}
