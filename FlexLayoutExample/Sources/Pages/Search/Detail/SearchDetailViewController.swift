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

    
    // MARK: - Properties
    weak var listener: SearchDetailPresentableListener?
    let adapter: SearchDetailViewAdapter = SearchDetailViewAdapter()
    
    // MARK: UI

    
    // MARK: Initializing
    init(model: SearchResult) {
        defer { self.reactor = Reactor(model: model) }
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
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.adapter.tableView.pin.all(view.safeAreaInsets)
    }
}


private extension SearchDetailViewController {
    // MARK: - setupUI
    func setupUI() {
        self.view.addSubview(self.adapter.tableView)
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
