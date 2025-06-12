//
//  SearchMainBuilder.swift
//  FlexLayoutExample
//
//  Created by HYUN SUNG on 6/12/25.
//

import RIBs

protocol SearchMainDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class SearchMainComponent: Component<SearchMainDependency> {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

protocol SearchMainBuildable: Buildable {
    func build(withListener listener: SearchMainListener) -> SearchMainRouting
}

final class SearchMainBuilder: Builder<SearchMainDependency>, SearchMainBuildable {

    override init(dependency: SearchMainDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: SearchMainListener) -> SearchMainRouting {
        let component = SearchMainComponent(dependency: dependency)
        let viewController = SearchMainViewController()
        let interactor = SearchMainInteractor(presenter: viewController)
        interactor.listener = listener
        return SearchMainRouter(interactor: interactor, viewController: viewController)
    }
}
