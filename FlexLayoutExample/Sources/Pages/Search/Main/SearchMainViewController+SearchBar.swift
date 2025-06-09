//
//  SearchMainViewController+SearchBar.swift
//  AppStoreSearch
//
//  Created by HYUN SUNG on 9/14/24.
//

import RxSwift
import RxCocoa

extension SearchMainViewController {
    // MARK: - BindSearchBar
    func bindSearchBar(reactor: Reactor) {
        // MARK: - Action
        self.searchBar.rx.value
            .skip(1)
            .map { Reactor.Action.searchHistory(keyword: $0) }
            .bind(to: reactor.action)
            .disposed(by: self.disposeBag)
        
        self.searchBar.rx.searchButtonClicked
            .withUnretained(self)
            .subscribe(onNext: {
                let keyword = $0.0.reactor?.currentState.keyword
                $0.0.searchBar.resignFirstResponder()
                $0.0.reactor?.action.onNext(.search(keyword: keyword))
            })
            .disposed(by: self.disposeBag)
        
        self.searchBar.rx.cancelButtonClicked
            .withUnretained(self)
            .subscribe(onNext: {
                $0.0.searchBar.resignFirstResponder()
                $0.0.reactor?.action.onNext(.searchHistory(keyword: nil))
            })
            .disposed(by: self.disposeBag)
        
        
        self.searchBar.rx.textDidBeginEditing
            .withUnretained(self)
            .observe(on: MainScheduler.asyncInstance)
            .subscribe(onNext: { $0.0.searchBar.setShowsCancelButton(true, animated: true) })
            .disposed(by: self.disposeBag)
        
        self.searchBar.rx.textDidEndEditing
            .withUnretained(self)
            .observe(on: MainScheduler.asyncInstance)
            .subscribe(onNext: { $0.0.searchBar.setShowsCancelButton(false, animated: true) })
            .disposed(by: self.disposeBag)
        
        // MARK: - State
        reactor.state.map { $0.keyword }
            .distinctUntilChanged()
            .bind(to: self.searchBar.rx.text)
            .disposed(by: self.disposeBag)
    }
}
