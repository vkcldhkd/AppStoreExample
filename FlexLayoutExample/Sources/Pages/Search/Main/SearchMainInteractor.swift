//
//  SearchMainInteractor.swift
//  FlexLayoutExample
//
//  Created by HYUN SUNG on 6/12/25.
//

import RIBs
import RxSwift

protocol SearchMainRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
    func routeToSearchDetail(item: SearchResult?)
}

protocol SearchMainPresentable: Presentable {
    var listener: SearchMainPresentableListener? { get set }
    // TODO: Declare methods the interactor can invoke the presenter to present data.
}

protocol SearchMainListener: AnyObject {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
//    func attachSearchDetail(_ item: SearchResult)
}

final class SearchMainInteractor: PresentableInteractor<SearchMainPresentable>, SearchMainInteractable {
    weak var router: SearchMainRouting?
    weak var listener: SearchMainListener?

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    override init(presenter: SearchMainPresentable) {
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        // TODO: Implement business logic here.
    }

    override func willResignActive() {
        super.willResignActive()
        // TODO: Pause any business logic.
    }
}

extension SearchMainInteractor: SearchMainPresentableListener {
    func didTapDetailItem(_ item: SearchResult?) {
        self.router?.routeToSearchDetail(item: item)
    }
}
