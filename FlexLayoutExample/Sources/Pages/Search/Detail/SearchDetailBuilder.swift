//
//  SearchDetailBuilder.swift
//  FlexLayoutExample
//
//  Created by HYUN SUNG on 6/12/25.
//

import RIBs

protocol SearchDetailDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class SearchDetailComponent: Component<SearchDetailDependency> {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

protocol SearchDetailBuildable: Buildable {
    func build(withListener listener: SearchDetailListener, model: SearchResult) -> SearchDetailRouting
}

final class SearchDetailBuilder: Builder<SearchDetailDependency>, SearchDetailBuildable {

    override init(dependency: SearchDetailDependency) {
        super.init(dependency: dependency)
    }

    func build(
        withListener listener: SearchDetailListener,
        model: SearchResult
    ) -> SearchDetailRouting {
        let component = SearchDetailComponent(dependency: dependency)
        let viewController = SearchDetailViewController(model: model)
        let interactor = SearchDetailInteractor(
            presenter: viewController,
            model: model
        )
        interactor.listener = listener
        return SearchDetailRouter(interactor: interactor, viewController: viewController)
    }
}
