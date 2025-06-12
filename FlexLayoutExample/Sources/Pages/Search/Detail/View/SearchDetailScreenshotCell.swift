//
//  SearchDetailScreenshotCell.swift
//  AppStoreSearch
//
//  Created by HYUN SUNG on 9/14/24.
//

import UIKit
import ReactorKit
import ReusableKit
import FlexLayout

final class SearchDetailScreenshotCell: BaseTableViewCell {
    // MARK: - Constants
    typealias Reactor = SearchItemCellReactor
    struct Reusable {
        static let screenshotCell = ReusableCell<SearchScreenshotCell>()
    }
    
    // MARK: - UI
    static let collectionViewLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout().then {
        $0.scrollDirection = .horizontal
    }
    let collectionView: BaseCollectionView = BaseCollectionView(
        frame: .zero,
        collectionViewLayout: SearchDetailScreenshotCell.collectionViewLayout
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


private extension SearchDetailScreenshotCell {
    // MARK: - setupUI
    func setupUI() {
        self.contentView.addSubview(self.collectionView)
    }
    
    // MARK: - setupConstraints
    func setupConstraints() {
//        self.collectionView.snp.makeConstraints { make in
//            make.top.bottom.equalToSuperview().inset(12)
//            make.leading.trailing.equalToSuperview().inset(20)
//            let width: CGFloat = self.contentView.frame.width
//            make.height.equalTo(width * 1.2)
//        }

        contentView.flex.define { flex in
            flex.addItem(collectionView)
                .marginHorizontal(20)
                .marginVertical(12)
                .height(UIScreen.main.bounds.width)
        }
    }
}

extension SearchDetailScreenshotCell: ReactorKit.View {
    func bind(reactor: Reactor) {
        // MARK: - Delegate
        self.collectionView.rx.setDelegate(self)
            .disposed(by: self.disposeBag)
        
        // MARK: - Action
        
        // MARK: - State
        reactor.state.map { $0.screenshotCellReactor }
            .bind(to: self.collectionView.rx.items(
                cellIdentifier: Reusable.screenshotCell.identifier,
                cellType: Reusable.screenshotCell.class)
            ) { index, model, cell in
                cell.reactor = model
            }
            .disposed(by: self.disposeBag)
    }
}



extension SearchDetailScreenshotCell: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int
    ) -> UIEdgeInsets {
        return .zero
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int
    ) -> CGFloat {
        return 10
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumInteritemSpacingForSectionAt section: Int
    ) -> CGFloat {
        return .zero
    }
    
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        
        let width: CGFloat = collectionView.frame.height * 0.6
        return .init(width: width, height: collectionView.frame.height)
    }
}
