//
//  SearchItemCell.swift
//  AppStoreSearch
//
//  Created by HYUN SUNG on 9/14/24.
//

import UIKit
import ReactorKit
import RxKingfisher
import ReusableKit
import FlexLayout
import Cosmos

final class SearchItemCell: BaseTableViewCell {
    // MARK: - Constants
    typealias Reactor = SearchItemCellReactor
    struct Reusable {
        static let screenshotCell = ReusableCell<SearchScreenshotCell>()
    }
    
    // MARK: - UI
    let searchImageView: UIImageView = UIImageView().then {
        $0.cornerRadius = 8
    }

    let searchTitleLabel: UILabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 16)
    }
    let searchDescLabel: UILabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 14)
        $0.textColor = .darkGray
    }
//    lazy var ratingContainerView: UIView = UIView().then {
//        //        $0.addSubview(self.ratingView)
//        $0.addSubview(self.ratingLabel)
//    }
    let ratingView: CosmosView = CosmosView().then {
        $0.isUserInteractionEnabled = false
        $0.settings.starSize = 15
        $0.settings.starMargin = 2
        $0.settings.fillMode = .half
        $0.settings.filledColor = UIColor.lightGray
        $0.settings.emptyBorderColor = UIColor.lightGray
        $0.settings.filledBorderColor = UIColor.lightGray
        $0.setContentHuggingPriority(.required, for: .horizontal)
    }
    
    let ratingLabel: UILabel = UILabel().then {
        $0.textColor = UIColor.lightGray
        $0.font = UIFont.boldSystemFont(ofSize: 14)
    }
    
    let spacer = UIView()
    private static let downloadbuttonConfig: UIButton.Configuration = UIButton.Configuration.gray()
    let downloadButton: UIButton = UIButton(configuration: SearchItemCell.downloadbuttonConfig).then {
        $0.setTitle("받기", for: .normal)
        $0.setContentHuggingPriority(.required, for: .horizontal)
    }
    
    let collectionView: BaseCollectionView = BaseCollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewFlowLayout()
    ).then {
        $0.register(Reusable.screenshotCell)
    }
    
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


private extension SearchItemCell {
    // MARK: - setupUI
    func setupUI() {
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
                            .size(60)
                            .marginRight(12)
                        
                        row.addItem().direction(.column).shrink(1).define { column in
                            column.addItem(searchTitleLabel).height(20)
                            column.addItem(searchDescLabel).height(18)
                            
                            column.addItem().direction(.row)
                                .shrink(1)
                                .define { row in
                                    row.addItem(ratingView).marginRight(4)
                                    row.addItem(ratingLabel).alignItems(.center)
                                }
                            
                        }
                        
                        row.addItem(spacer).grow(1)
                        
                        row.addItem(downloadButton)
                            .alignSelf(.center)
                            .width(80)
                            .height(30)
                    }
                
                flex.addItem(self.collectionView)
                    .marginHorizontal(12)
                    .height(UIScreen.main.bounds.width * 0.7)
            }
    }
}

extension SearchItemCell: ReactorKit.View {
    func bind(reactor: Reactor) {
        // MARK: - Action
        
        // MARK: - State
        reactor.state.map { _ in }
            .bind(to: self.rx.setNeedsLayout)
            .disposed(by: self.disposeBag)
        
        self.bindInfo(reactor: reactor)
        self.bindCollectionView(reactor: reactor, cell: Reusable.screenshotCell)
    }
}
