//
//  BaseViewController.swift
//  AppStoreSearch
//
//  Created by HYUN SUNG on 9/13/24.
//

import UIKit
import Then
import RxSwift
import FlexLayout

class BaseViewController: UIViewController {
    
    // MARK: Properties
    lazy private(set) var className: String = {
        return type(of: self).description().components(separatedBy: ".").last ?? ""
    }()
    private var backgroundColor: UIColor
    let navigationBarData: NavigationBarData
    // MARK: Rx
    var disposeBag = DisposeBag()
    
    
    // MARK: Layout Constraints
    private(set) var didSetupConstraints = false
    
    // MARK: - UI
    let loadingView: UIActivityIndicatorView = UIActivityIndicatorView()
    let rootFlexContainer = UIView()
    
    // MARK: Initializing
    init(
        backgroundColor: UIColor = UIColor.white,
        barBackgroundColor: UIColor = UIColor.white,
        prefersHidden: Bool? = nil,
        isTranslucent: Bool? = nil,
        hidesBottomBarWhenPushed: Bool = true
    ) {
        self.backgroundColor = backgroundColor
        self.navigationBarData = type(of: self).navigationBarDataFactory(
            barBackgroundColor: barBackgroundColor,
            prefersHidden: prefersHidden ?? false,
            isTranslucent: isTranslucent ?? true
        )
        super.init(nibName: nil, bundle: nil)
        self.hidesBottomBarWhenPushed = hidesBottomBarWhenPushed
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        self.init()
    }
    
    deinit {
        print("DEINIT: \(self.className)")
    }
    
    
    // MARK: View Lifecycle
    override func viewDidLoad() {
        self.view.setNeedsUpdateConstraints()
        self.view.backgroundColor = self.backgroundColor
        self.view.addSubview(self.rootFlexContainer)
    }
    
    override func updateViewConstraints() {
        if !self.didSetupConstraints {
            self.setupConstraints()
            self.didSetupConstraints = true
        }
        super.updateViewConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(self.navigationBarData.prefersHidden, animated: true)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // PinLayout으로 root container 사이즈 지정
        self.rootFlexContainer.pin.all(self.view.pin.safeArea)
        
        // FlexLayout으로 내부 레이아웃 계산
        self.rootFlexContainer.flex.layout()
    }
    
    func setupConstraints() {
        // Override point
    }
}

private extension BaseViewController {
    private static func navigationBarDataFactory(
        barBackgroundColor: UIColor?,
        prefersHidden: Bool,
        isTranslucent: Bool
    ) -> NavigationBarData {
        return NavigationBarData(
            barBackgroundColor: barBackgroundColor ?? UIColor.white,
            prefersHidden: prefersHidden,
            isTranslucent: isTranslucent
        )
    }
}
extension BaseViewController {
    @objc func endEditing(){
        self.view.endEditing(true)
    }
    
    func loadingViewAddSubView() {
        self.view.addSubview(self.loadingView)
    }
    
    func loadingViewConstraints(inset: CGFloat = 0) {
        self.loadingView.pin.center()
    }
}
