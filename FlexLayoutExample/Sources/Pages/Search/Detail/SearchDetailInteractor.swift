//
//  SearchDetailInteractor.swift
//  FlexLayoutExample
//
//  Created by HYUN SUNG on 6/12/25.
//

import RIBs
import RxSwift

protocol SearchDetailRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol SearchDetailPresentable: Presentable {
    var listener: SearchDetailPresentableListener? { get set }
    // TODO: Declare methods the interactor can invoke the presenter to present data.
}

protocol SearchDetailListener: AnyObject {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

final class SearchDetailInteractor: PresentableInteractor<SearchDetailPresentable>, SearchDetailInteractable, SearchDetailPresentableListener {

    weak var router: SearchDetailRouting?
    weak var listener: SearchDetailListener?
    private let model: SearchResult
    
    init(
        presenter: SearchDetailPresentable,
        model: SearchResult
    ) {
        self.model = model
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
