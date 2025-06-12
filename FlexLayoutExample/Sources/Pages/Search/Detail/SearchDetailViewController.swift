//
//  SearchDetailViewController.swift
//  AppStoreSearch
//
//  Created by HYUN SUNG on 9/14/24.
//

import UIKit
import ReactorKit
import RxSwift
import ReusableKit
import RxDataSources

protocol SearchDetailPresentableListener: AnyObject {
}


final class SearchDetailViewController: BaseViewController {
    // MARK: - Constants
    typealias Reactor = SearchDetailViewReactor
    struct Reusable {
        static let infoCell = ReusableCell<SearchDetailInfoCell>()
        static let screenshotCell = ReusableCell<SearchDetailScreenshotCell>()
        static let descCell = ReusableCell<SearchDeatilDescCell>()
    }
    
    // MARK: - Properties
    weak var listener: SearchDetailPresentableListener?
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
    
    // MARK: UI
    var tableView: BaseTableView = BaseTableView().then {
        $0.register(Reusable.infoCell)
        $0.register(Reusable.screenshotCell)
        $0.register(Reusable.descCell)
    }
    
    // MARK: Initializing
    init(model: SearchResult) {
        defer { self.reactor = Reactor(model: model) }
        self.dataSource = type(of: self).dataSourceFactory()
        super.init()
    }
    
    required convenience init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
    }
    
    override func setupConstraints() {
//        self.tableView.snp.makeConstraints { make in
//            make.edges.equalTo(self.view.safeAreaLayoutGuide.snp.edges)
//        }
    }
}


private extension SearchDetailViewController {
    // MARK: - setupUI
    func setupUI() {
        self.view.addSubview(self.tableView)
    }
}

extension SearchDetailViewController: ReactorKit.View {
    func bind(reactor: Reactor) {
        // MARK: - Action
        
        // MARK: - State
        self.bindTableView(reactor: reactor)
    }
}

extension SearchDetailViewController: SearchDetailPresentable, SearchDetailViewControllable {
    
}
