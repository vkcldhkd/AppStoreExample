//
//  RootRouter.swift
//  FlexLayoutExample
//
//  Created by HYUN SUNG on 6/12/25.
//

import RIBs

protocol RootInteractable: Interactable, SearchMainListener {
    var router: RootRouting? { get set }
    var listener: RootListener? { get set }
}

protocol RootViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
    func replaceScreen(viewController: ViewControllable)
}

final class RootRouter: LaunchRouter<RootInteractable, RootViewControllable> {
    private let searchMainBuilder: SearchMainBuildable
    private var searchMainRouter: SearchMainRouting?
    
    init(
        interactor: RootInteractable,
        viewController: RootViewControllable,
        searchMainBuilder: SearchMainBuildable
    ) {
        self.searchMainBuilder = searchMainBuilder
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}

extension RootRouter: RootRouting {
    func attachSearchMain() {
        guard self.searchMainRouter == nil else { return }
        let router = self.searchMainBuilder.build(withListener: interactor)
        self.attachChild(router)
        self.searchMainRouter = router
        self.viewController.replaceScreen(viewController: router.viewControllable)
    }
}
