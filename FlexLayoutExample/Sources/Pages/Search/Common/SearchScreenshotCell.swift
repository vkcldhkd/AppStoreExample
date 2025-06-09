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
        imageView.pin.all()
//        self.contentView.flex.layout(mode: .fitContainer)
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        // 1) Set the contentView's width to the specified size parameter
        contentView.pin.width(size.width)
        
        // 2) Layout contentView flex container
        layout()
        
        // Return the flex container new size
        print("contentView.frame.size: \(contentView.frame.size)")
        return contentView.frame.size
    }
}

private extension SearchScreenshotCell {
    // MARK: - setupUI
    func setupUI() {
//        self.contentView.addSubview(self.imageView)
    }
    
    // MARK: - setupConstraints
    func setupConstraints() {
        contentView.flex.define { flex in
            flex.addItem(imageView)
                .grow(1)             // 남은 공간 전부 차지
                .shrink(1)           // 공간 부족 시 줄어들기 허용
                .alignSelf(.stretch) // 부모의 너비에 딱 맞춤
        }
//        self.imageView.snp.makeConstraints { make in
//            make.edges.equalToSuperview()
//        }
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
