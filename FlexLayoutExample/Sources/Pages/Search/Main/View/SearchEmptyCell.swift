//
//  SearchEmptyCell.swift
//  AppStoreSearch
//
//  Created by HYUN SUNG on 9/14/24.
//

import UIKit
import FlexLayout

final class SearchEmptyCell: BaseTableViewCell {
    let descLabel: UILabel = UILabel().then {
        $0.font = UIFont.boldSystemFont(ofSize: 25)
        $0.text = "결과 없음"
        $0.textAlignment = .center
    }
    let keywordLabel: UILabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 16)
        $0.textColor = UIColor.lightGray
        $0.textAlignment = .center
    }
        
    //MARK: - Init
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

extension SearchEmptyCell {
    func updateKeywordTitle(keyword: String?) {
        self.keywordLabel.text = "'\(keyword ?? "")'"
    }
}

//MARK: - UI
private extension SearchEmptyCell {
    func setupUI() {
    }
    
    func setupConstraints() {
        
        self.contentView.flex.direction(.column).define { flex in
            flex.addItem(descLabel)
                .height(29)
                .marginBottom(8)
                .alignSelf(.stretch) // leading, trailing == 0

            flex.addItem(keywordLabel)
                .alignSelf(.stretch)
        }
//        self.containerView.snp.makeConstraints { make in
//            make.edges.equalToSuperview().inset(20)
//        }
//        
//        self.descLabel.snp.makeConstraints { make in
//            make.top.leading.trailing.equalToSuperview()
//            make.height.equalTo(29)
//        }
//        
//        self.keywordLabel.snp.makeConstraints { make in
//            make.top.equalTo(self.descLabel.snp.bottom).offset(8)
//            make.leading.trailing.bottom.equalToSuperview()
//        }
    }
}
