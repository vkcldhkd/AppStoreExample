//
//  SearchMainRouter.swift
//  FlexLayoutExample
//
//  Created by HYUN SUNG on 6/12/25.
//

import RIBs

protocol SearchMainInteractable: Interactable, SearchDetailListener {
    var router: SearchMainRouting? { get set }
    var listener: SearchMainListener? { get set }
}

protocol SearchMainViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
//    func didTapDetailItem(_ item: SearchResult?)
}

final class SearchMainRouter: ViewableRouter<SearchMainInteractable, SearchMainViewControllable>, SearchMainRouting {
    
    private let searchDetailBuilder: SearchDetailBuildable
//    private var searchDetailRouter: SearchDetailRouting?
    
    init(
        interactor: SearchMainInteractor,
        viewController: SearchMainViewControllable,
        searchDetailBuilder: SearchDetailBuildable
    ) {
        self.searchDetailBuilder = searchDetailBuilder
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}

extension SearchMainRouter {
    func routeToSearchDetail(item: SearchResult?) {
        guard let item = item else { return }
//        guard self.searchDetailRouter == nil else { return }
        let router = self.searchDetailBuilder.build(
            withListener: interactor,
            model: item
        )
        self.attachChild(router)
//        self.searchDetailRouter = router
        self.viewController.uiviewController.navigationController?.pushViewController(router.viewControllable.uiviewController, animated: true)
//        self.viewController.didTapDetailItem(item)
    }
}
