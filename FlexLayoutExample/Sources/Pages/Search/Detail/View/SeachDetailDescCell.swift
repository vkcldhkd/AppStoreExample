//
//  SeachDetailDescCell.swift
//  AppStoreSearch
//
//  Created by HYUN SUNG on 9/14/24.
//

import UIKit
import ReactorKit

final class SearchDeatilDescCell: BaseTableViewCell {
    // MARK: - Constants
    typealias Reactor = SeachDetailDescCellReactor
    
    // MARK: - UI
    
    let descLabel: UILabel = UILabel().then {
        $0.lineBreakMode = .byCharWrapping
        $0.font = UIFont.systemFont(ofSize: 14)
    }
    let moreLabel: UILabel = UILabel().then {
        $0.isUserInteractionEnabled = false
        $0.text = "더보기"
        $0.textColor = UIColor.systemBlue
    }
    let moreBackgroundGradientView: GradientView = GradientView(endColor: UIColor.white).then {
        $0.isUserInteractionEnabled = false
    }
    let moreWrapperView = UIView()
    
    // MARK: Initializing
    override init(
        style: UITableViewCell.CellStyle,
        reuseIdentifier: String?
    ) {
        super.init(style: .value1, reuseIdentifier: reuseIdentifier)
        self.setupUI()
        self.setupConstraints()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layout()
    }
    
    fileprivate func layout() {
        self.contentView.flex.layout(mode: .adjustHeight)
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        contentView.pin.width(size.width)
        self.layout()
        return contentView.frame.size
    }
    
}


private extension SearchDeatilDescCell {
    // MARK: - setupUI
    func setupUI() {
//        self.contentView.addSubview(self.descLabel)
//        self.contentView.addSubview(self.moreBackgroundGradientView)
//        self.contentView.addSubview(self.moreLabel)
        
        moreWrapperView.addSubview(moreBackgroundGradientView)
        moreWrapperView.addSubview(moreLabel)
    }
    
    // MARK: - setupConstraints
    func setupConstraints() {
        
        self.contentView.flex.padding(20).define { flex in
            flex.addItem().position(.relative).define { layer in
                layer.addItem(descLabel)
                
                layer.addItem(moreWrapperView)
                    .position(.absolute)
                    .right(0)
                    .bottom(0)
                    .define { wrapper in
                        wrapper.addItem(moreBackgroundGradientView)
                            .position(.absolute)
                            .left(-8).right(0).top(0).bottom(0)

                        wrapper.addItem(moreLabel)
                    }
            }
        }
        
//        self.descLabel.snp.makeConstraints { make in
//            make.edges.equalToSuperview().inset(20)
//        }
//        
//        self.moreLabel.snp.makeConstraints { make in
//            make.trailing.equalToSuperview().inset(20)
//            make.bottom.equalTo(self.descLabel.snp.bottom)
//        }
//        
//        self.moreBackgroundGradientView.snp.makeConstraints { make in
//            make.leading.equalTo(self.moreLabel.snp.leading).inset(-8)
//            make.trailing.equalTo(self.moreLabel.snp.trailing)
//            make.centerY.equalTo(self.moreLabel.snp.centerY)
//            make.height.equalTo(self.moreLabel.snp.height)
//        }
    }
}


extension SearchDeatilDescCell: ReactorKit.View {
    func bind(reactor: Reactor) {
        // MARK: - Action
        
        // MARK: - State
        reactor.state.map { $0.model.description }
            .distinctUntilChanged()
            .bind(to: self.descLabel.rx.text)
            .disposed(by: self.disposeBag)
        
        let numberOfLinesObservable = reactor.state.map { $0.numberOfLines }
            .distinctUntilChanged()
        
        numberOfLinesObservable
            .bind(to: self.descLabel.rx.flexNumberOfLines)
            .disposed(by: self.disposeBag)
        
        numberOfLinesObservable
            .map { $0 == 0 }
            .distinctUntilChanged()
            .bind(to: self.moreWrapperView.rx.isDisplay)
            .disposed(by: self.disposeBag)
    }
}
