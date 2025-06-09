//
//  SearchItemCell+CollectionView.swift
//  AppStoreSearch
//
//  Created by HYUN SUNG on 9/14/24.
//

import UIKit
import RxSwift
import ReusableKit

extension SearchItemCell {
    // MARK: - BindCollectionView
    func bindCollectionView(
        reactor: Reactor,
        cell: ReusableCell<SearchScreenshotCell>
    ) {
        // MARK: - Delegate
        self.collectionView.rx.setDelegate(self)
            .disposed(by: self.disposeBag)
        
        // MARK: - Action
        
        // MARK: - State
        reactor.state.map { $0.screenshotCellReactor }
            .bind(to: self.collectionView.rx.items(
                cellIdentifier: cell.identifier,
                cellType: cell.class)
            ) { index, model, cell in
                cell.reactor = model
            }
            .disposed(by: self.disposeBag)
            
    }
}


extension SearchItemCell: UICollectionViewDelegateFlowLayout {
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
        
        let width = collectionView.getCellSize(numberOfItemsRowAt: 3, width: nil, sectionMargin: 10).width
        return .init(width: width, height: collectionView.frame.height)
    }
}
