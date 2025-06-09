//
//  SearchMainViewController.swift
//  AppStoreSearch
//
//  Created by HYUN SUNG on 9/13/24.
//

import UIKit
import ReactorKit
import RxDataSources
import ReusableKit
import FlexLayout
import PinLayout

final class SearchMainViewController: BaseViewController {
    // MARK: - Constants
    typealias Reactor = SearchMainViewReactor
    struct Reusable {
        static let listCell = ReusableCell<SearchItemCell>()
        static let emptyCell = ReusableCell<SearchEmptyCell>()
        static let historyCell = ReusableCell<SearchHistoryCell>()
    }
    
    // MARK: - UI
    var searchBar: UISearchBar = UISearchBar().then {
        $0.placeholder = "게임, 앱, 스토리 등"
    }
    var tableView: BaseTableView = BaseTableView().then {
        $0.register(Reusable.listCell)
        $0.register(Reusable.emptyCell)
        $0.register(Reusable.historyCell)
        $0.keyboardDismissMode = .onDrag
    }
    
    // MARK: - Properties
    let dataSource: RxTableViewSectionedReloadDataSource<SearchMainSection>
    private static func dataSourceFactory() -> RxTableViewSectionedReloadDataSource<SearchMainSection> {
        return .init(
            configureCell: { dataSource, tableView, indexPath, sectionItem in
                switch sectionItem {
                case let .searchItem(cellReactor):
                    let cell = tableView.dequeue(Reusable.listCell, for: indexPath)
                    cell.reactor = cellReactor
                    return cell
                case let .searchEmptyItem(keyword):
                    let cell = tableView.dequeue(Reusable.emptyCell, for: indexPath)
                    cell.updateKeywordTitle(keyword: keyword)
                    return cell
                case let .historyItem(cellReactor):
                    let cell = tableView.dequeue(Reusable.historyCell, for: indexPath)
                    cell.reactor = cellReactor
                    return cell
                }
            }
        )
    }
    
    // MARK: - Initializing
    init() {
        defer { self.reactor = Reactor() }
        self.dataSource = type(of: self).dataSourceFactory()
        super.init(prefersHidden: true)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func setupConstraints() {
        defer { self.loadingViewConstraints() }
        
        self.rootFlexContainer.flex.define { flex in
            flex.addItem(self.searchBar).width(100%)
            flex.addItem(self.tableView).grow(1).width(100%)
        }
    }
}

private extension SearchMainViewController {
    // MARK: - setupUI
    func setupUI() {
        defer { self.loadingViewAddSubView() }
        self.view.addSubview(self.searchBar)
        self.view.addSubview(self.tableView)
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
    }
    
    func setupNavigationBar() {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
}

extension SearchMainViewController: ReactorKit.View {
    func bind(reactor: Reactor) {
        self.bindSearchBar(reactor: reactor)
        self.bindTableView(reactor: reactor)
        self.bindLoading(reactor: reactor)
    }
}
