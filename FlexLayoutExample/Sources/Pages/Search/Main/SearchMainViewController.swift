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


protocol SearchMainPresentableListener: AnyObject {
    func didTapDetailItem(_ item: SearchResult?)
}

final class SearchMainViewController: BaseViewController {
    // MARK: - Constants
    typealias Reactor = SearchMainViewReactor
    
    // MARK: - UI
    var searchBar: UISearchBar = UISearchBar().then {
        $0.placeholder = "게임, 앱, 스토리 등"
    }
    
    // MARK: - Properties
    weak var listener: SearchMainPresentableListener?
    let adapter: SearchMainViewAdapter = SearchMainViewAdapter()
    
    // MARK: - Initializing
    init() {
        defer { self.reactor = Reactor() }
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
            flex.addItem(self.adapter.tableView).grow(1).width(100%)
        }
    }
}

private extension SearchMainViewController {
    // MARK: - setupUI
    func setupUI() {
        self.loadingViewAddSubView()
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

extension SearchMainViewController: SearchMainPresentable, SearchMainViewControllable {
    func didTapDetailItem(_ item: SearchResult?) {
        self.listener?.didTapDetailItem(item)
    }
}
