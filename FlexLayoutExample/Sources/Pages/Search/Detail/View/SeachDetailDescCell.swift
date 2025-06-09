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
    
    // MARK: Initializing
    override init(
        style: UITableViewCell.CellStyle,
        reuseIdentifier: String?
    ) {
        super.init(style: .value1, reuseIdentifier: reuseIdentifier)
        self.setupUI()
        self.setupConstraints()
    }
}


private extension SearchDeatilDescCell {
    // MARK: - setupUI
    func setupUI() {
        self.contentView.addSubview(self.descLabel)
        self.contentView.addSubview(self.moreBackgroundGradientView)
        self.contentView.addSubview(self.moreLabel)
    }
    
    // MARK: - setupConstraints
    func setupConstraints() {
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
            .bind(to: self.descLabel.rx.numberOfLines)
            .disposed(by: self.disposeBag)
        
        numberOfLinesObservable
            .map { $0 == 0 }
            .distinctUntilChanged()
            .bind(to:
                    self.moreLabel.rx.isHidden,
                    self.moreBackgroundGradientView.rx.isHidden
            )
            .disposed(by: self.disposeBag)
    }
}
