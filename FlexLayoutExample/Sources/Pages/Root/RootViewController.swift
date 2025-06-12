//
//  RootViewController.swift
//  FlexLayoutExample
//
//  Created by HYUN SUNG on 6/12/25.
//

import RIBs
import RxSwift
import UIKit

protocol RootPresentableListener: AnyObject {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
}

final class RootViewController: BaseViewController, RootPresentable, RootViewControllable {
    
    // MARK: - Properties
    weak var listener: RootPresentableListener?
    private var currentViewController: ViewControllable?
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        currentViewController?.uiviewController.view.pin.all()
        currentViewController?.uiviewController.view.flex.layout()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension RootViewController {
    func replaceScreen(viewController: ViewControllable) {
        let newVC = viewController.uiviewController
        
        self.addChild(newVC)
        self.view.addSubview(newVC.view)
        
        // 2. PinLayout + Flex로 레이아웃 설정
        newVC.view.pin.all()
        newVC.view.flex.layout()
        
        // 3. 이전 VC 정리
        if let current = self.currentViewController?.uiviewController {
            current.willMove(toParent: nil)
            current.view.removeFromSuperview()
            current.removeFromParent()
        }
        
        // 4. 마무리
        newVC.didMove(toParent: self)
        self.currentViewController = viewController
    }
}
