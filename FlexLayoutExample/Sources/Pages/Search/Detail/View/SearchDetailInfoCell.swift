//
//  SearchDetailInfoCell.swift
//  AppStoreSearch
//
//  Created by HYUN SUNG on 9/14/24.
//
import UIKit
import ReactorKit
import FlexLayout

final class SearchDetailInfoCell: BaseTableViewCell {
    // MARK: - Constants
    typealias Reactor = SearchItemCellReactor
    
    // MARK: - UI
    let searchImageView: UIImageView = UIImageView().then {
        $0.cornerRadius = 8
    }
    let searchTitleLabel: UILabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 20)
    }
    let searchDescLabel: UILabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 16)
        $0.textColor = .darkGray
    }
    
    private static let downloadbuttonConfig: UIButton.Configuration = UIButton.Configuration.gray()
    private let downloadButton: UIButton = UIButton(configuration: SearchDetailInfoCell.downloadbuttonConfig).then {
        $0.setTitle("받기", for: .normal)
        $0.setContentHuggingPriority(.required, for: .horizontal)
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


private extension SearchDetailInfoCell {
    // MARK: - setupUI
    func setupUI() {
    }
    
    // MARK: - setupConstraints
    func setupConstraints() {
        self.contentView.flex.padding(20).define { flex in
            flex.addItem().direction(.row).alignItems(.start).define { row in
                row.addItem(self.searchImageView).size(100)

                row.addItem().direction(.column).marginLeft(8).grow(1).shrink(1).define { col in
                    col.addItem(self.searchTitleLabel).height(24)
                    col.addItem(self.searchDescLabel).height(20)
                    col.addItem(self.downloadButton)
                }
            }
        }
    }
}

extension SearchDetailInfoCell: ReactorKit.View {
    func bind(reactor: Reactor) {
        // MARK: - Action
//        self.downloadButton.rx.tap
//            .throttle(.milliseconds(600), scheduler: MainScheduler.asyncInstance)
//            .observe(on: MainScheduler.asyncInstance)
//            .subscribe(onNext: { URLNavigatorHelper.shared.alert(title: "내 마음속에", message: "저장!") })
//            .disposed(by: self.disposeBag)
        
        // MARK: - State
        reactor.state.map { $0.model.trackName }
            .distinctUntilChanged()
            .bind(to: self.searchTitleLabel.rx.text)
            .disposed(by: self.disposeBag)
        
        reactor.state.map { $0.model.description }
            .distinctUntilChanged()
            .bind(to: self.searchDescLabel.rx.text)
            .disposed(by: self.disposeBag)
        
        reactor.state.map { $0.model.artworkUrl512 }
            .distinctUntilChanged()
            .compactMap { URLHelper.createEncodedURL(url: $0) }
            .bind(to: self.searchImageView.kf.rx.image())
            .disposed(by: self.disposeBag)
    }
}
