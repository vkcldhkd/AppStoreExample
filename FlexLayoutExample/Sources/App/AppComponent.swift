//
//  AppComponent.swift
//  FlexLayoutExample
//
//  Created by HYUN SUNG on 6/12/25.
//

import RIBs

final class AppComponent: Component<EmptyDependency>, RootDependency {
//    var webService: WebServicing
    
    init() {
//        webService = WebService()
        super.init(dependency: EmptyComponent())
    }
}
