//
//  SearchDetailViewAdapter.swift
//  FlexLayoutExample
//
//  Created by HYUN SUNG on 6/12/25.
//

import UIKit
import ReusableKit
import RxDataSources
import RxSwift

final class SearchDetailViewAdapter {
    // MARK: - Constants
    struct Reusable {
        static let infoCell = ReusableCell<SearchDetailInfoCell>()
        static let screenshotCell = ReusableCell<SearchDetailScreenshotCell>()
        static let descCell = ReusableCell<SearchDeatilDescCell>()
    }
    
    // MARK: - UI
    var tableView: BaseTableView = BaseTableView().then {
        $0.register(Reusable.infoCell)
        $0.register(Reusable.screenshotCell)
        $0.register(Reusable.descCell)
    }
    
    // MARK: - Rx
    private let disposeBag = DisposeBag()
    
    // MARK: - Properties
    var onItemSelected: ((SearchMainSectionItem) -> Void)?
    let dataSource: RxTableViewSectionedReloadDataSource<SearchDetailSection>
    private static func dataSourceFactory() -> RxTableViewSectionedReloadDataSource<SearchDetailSection> {
        return .init(
            configureCell: { dataSource, tableView, indexPath, sectionItem in
                switch sectionItem {
                case let .infoItem(cellReactor):
                    let cell = tableView.dequeue(Reusable.infoCell, for: indexPath)
                    cell.reactor = cellReactor
                    return cell
                    
                case let .screenshotItem(cellReactor):
                    let cell = tableView.dequeue(Reusable.screenshotCell, for: indexPath)
                    cell.reactor = cellReactor
                    return cell
                    
                case let .descItem(cellReactor):
                    let cell = tableView.dequeue(Reusable.descCell, for: indexPath)
                    cell.reactor = cellReactor
                    return cell
                }
            }
        )
    }
    
    // MARK: - Initializing
    init() {
        self.dataSource = type(of: self).dataSourceFactory()
    }
}
