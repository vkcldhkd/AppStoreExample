//
//  SearchMainRouter.swift
//  FlexLayoutExample
//
//  Created by HYUN SUNG on 6/12/25.
//

import RIBs

protocol SearchMainInteractable: Interactable {
    var router: SearchMainRouting? { get set }
    var listener: SearchMainListener? { get set }
}

protocol SearchMainViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class SearchMainRouter: ViewableRouter<SearchMainInteractable, SearchMainViewControllable>, SearchMainRouting {

    // TODO: Constructor inject child builder protocols to allow building children.
    override init(interactor: SearchMainInteractable, viewController: SearchMainViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}
