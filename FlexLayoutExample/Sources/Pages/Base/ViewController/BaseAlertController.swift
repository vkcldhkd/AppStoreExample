//
//  BaseAlertController.swift
//  FlexLayoutExample
//
//  Created by HYUN SUNG on 6/13/25.
//

import UIKit
import RxSwift

final class BaseAlertController: UIAlertController {
    struct AlertAction {
        var title: String?
        var style: UIAlertAction.Style
        
        static func action(
            title: String?,
            style: UIAlertAction.Style = .default
        ) -> AlertAction {
            return AlertAction(title: title, style: style)
        }
    }
    
    static func present(
        title: String? = nil,
        message: String? = nil,
        actions: [AlertAction]
    ) -> Observable<Int> {
        return Observable.create { observer in
            let alertController = UIAlertController(
                title: title,
                message: message,
                preferredStyle: .alert
            )
            
            actions.enumerated().forEach { index, action in
                let action = UIAlertAction(title: action.title, style: action.style) { _ in
                    observer.onNext(index)
                    observer.onCompleted()
                }
                alertController.addAction(action)
            }
            
            // Present the alert
            
            if let windowScene = UIApplication.shared.connectedScenes
                .first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene,
               let viewController = windowScene.windows.first(where: { $0.isKeyWindow })?.rootViewController {
                // Find the presented view controller
                var presentedController = viewController
                while presentedController.presentedViewController != nil && presentedController.presentedViewController?.isBeingDismissed == false {
                    presentedController = presentedController.presentedViewController!
                }
                DispatchQueue.main.async {
                    presentedController.present(alertController, animated: true, completion: nil)
                }
            }
            return Disposables.create { alertController.dismiss(animated: true, completion: nil) }
        }
    }
}
