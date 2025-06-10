//
//  SearchHistoryCell.swift
//  AppStoreSearch
//
//  Created by HYUN SUNG on 9/14/24.
//

import UIKit
import ReactorKit
import FlexLayout

final class SearchHistoryCell: BaseTableViewCell {
    // MARK: - Constants
    typealias Reactor = SearchHistoryCellReactor
    
    // MARK: - UI
    private lazy var containerStackView: UIStackView = UIStackView().then {
        $0.spacing = 8
        $0.addArrangedSubview(self.searchImageView)
        $0.addArrangedSubview(self.searchTitleLabel)
    }
    private let searchImageView: UIImageView = UIImageView(image: UIImage.init(systemName: "magnifyingglass")).then {
        $0.isHidden = true
        $0.tintColor = UIColor.lightGray
    }
    private let searchTitleLabel: UILabel = UILabel()
    
    // MARK: Initializing
    override init(
        style: UITableViewCell.CellStyle,
        reuseIdentifier: String?
    ) {
        super.init(style: .value1, reuseIdentifier: reuseIdentifier)
        self.setupUI()
        self.setupConstraints()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layout()
    }
    
    fileprivate func layout() {
        self.contentView.flex.layout(mode: .adjustHeight)
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        contentView.pin.width(size.width)
        self.layout()
        return contentView.frame.size
    }
}

private extension SearchHistoryCell {
    // MARK: - setupUI
    func setupUI() {
//        self.contentView.addSubview(self.containerStackView)
        
    }
    
    // MARK: - setupConstraints
    func setupConstraints() {
        self.contentView.flex
            .direction(.column)
            .define { flex in
                flex.addItem()
                    .direction(.row)
                    .alignItems(.center)
                    .paddingHorizontal(12)
                    .paddingVertical(12)
                    .define { row in
                        row.addItem(searchImageView)
                            .size(15)
                            .marginRight(12)
                        
                        row.addItem(searchTitleLabel)
                            .grow(1)
                    }
            }
    }
}

extension SearchHistoryCell: ReactorKit.View {
    func bind(reactor: Reactor) {
        // MARK: - Action
        
        // MARK: - State
        reactor.state.map { _ in }
            .bind(to: self.rx.setNeedsLayout)
            .disposed(by: self.disposeBag)
        
        reactor.state.map { $0.model }
            .distinctUntilChanged()
            .bind(to: self.searchTitleLabel.rx.text)
            .disposed(by: self.disposeBag)
        
        
        let isContainsObservable = reactor.state.map { $0.isContains }
            .distinctUntilChanged()
        
        isContainsObservable
            .map { $0 ? UIColor.black : UIColor.systemBlue }
            .distinctUntilChanged()
            .bind(to: self.searchTitleLabel.rx.textColor)
            .disposed(by: self.disposeBag)
        
        isContainsObservable
            .map { !$0 }
            .bind(to: self.searchImageView.rx.isDisplay)
            .disposed(by: self.disposeBag)
    }
}
