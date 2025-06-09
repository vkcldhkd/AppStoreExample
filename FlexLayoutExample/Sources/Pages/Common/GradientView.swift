//
//  GradientView.swift
//  AppStoreSearch
//
//  Created by HYUN SUNG on 9/14/24.
//

import UIKit

enum GradientType {
    case topToBottom
    case leftToRight
}

extension GradientType {
    var startPoint: CGPoint {
        switch self {
        case .topToBottom: return CGPoint(x: 0.5, y: 0.0)
        case .leftToRight: return CGPoint(x: 0.0, y: 0.5)
        }
    }
    
    var endPoint: CGPoint {
        switch self {
        case .topToBottom: return CGPoint(x: 0.5, y: 1.0)
        case .leftToRight: return CGPoint(x: 1.0, y: 0.5)
        }
    }
}

final class GradientView: BaseView {

    private var gradient = CAGradientLayer()
    private let endColor: UIColor
    private let type: GradientType
    
    init(
        endColor: UIColor,
        type: GradientType = GradientType.leftToRight
    ) {
        self.endColor = endColor
        self.type = type
        super.init(frame: .zero)
        self.setupGradientView()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.gradient.frame = self.bounds
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension GradientView {
    private func setupGradientView() {
        self.gradient.colors = [
            self.endColor.withAlphaComponent(0).cgColor,
            self.endColor.withAlphaComponent(1).cgColor,
            self.endColor.withAlphaComponent(1).cgColor,
        ]
        self.gradient.startPoint = self.type.startPoint
        self.gradient.endPoint = self.type.endPoint
        self.gradient.locations = [0.0, 0.2, 1.0]
        self.layer.addSublayer(self.gradient)
    }
}
