//
//  SearchDetailInfoCell.swift
//  AppStoreSearch
//
//  Created by HYUN SUNG on 9/14/24.
//
import UIKit
import ReactorKit

final class SearchDetailInfoCell: BaseTableViewCell {
    // MARK: - Constants
    typealias Reactor = SearchItemCellReactor
    
    // MARK: - UI
    let searchImageView: UIImageView = UIImageView().then {
        $0.cornerRadius = 8
    }
    private lazy var infoStackView: UIStackView = UIStackView().then {
        $0.axis = .vertical
        $0.addArrangedSubview(self.searchTitleLabel)
        $0.addArrangedSubview(self.searchDescLabel)
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
}


private extension SearchDetailInfoCell {
    // MARK: - setupUI
    func setupUI() {
        self.contentView.addSubview(self.searchImageView)
        self.contentView.addSubview(self.infoStackView)
        self.contentView.addSubview(self.downloadButton)
    }
    
    // MARK: - setupConstraints
    func setupConstraints() {
//        self.searchImageView.snp.makeConstraints { make in
//            make.top.leading.bottom.equalToSuperview().inset(20)
//            make.size.equalTo(100)
//        }
//        
//        self.infoStackView.snp.makeConstraints { make in
//            make.top.equalTo(self.searchImageView.snp.top)
//            make.leading.equalTo(self.searchImageView.snp.trailing).offset(8)
//            make.trailing.equalToSuperview().inset(20)
//        }
//        
//        self.searchTitleLabel.snp.makeConstraints { make in
//            make.height.equalTo(24)
//        }
//        
//        self.searchDescLabel.snp.makeConstraints { make in
//            make.height.equalTo(20)
//        }
//        
//        self.downloadButton.snp.makeConstraints { make in
//            make.leading.equalTo(self.searchImageView.snp.trailing).offset(8)
//            make.bottom.equalTo(self.searchImageView.snp.bottom)
//        }
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
