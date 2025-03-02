//
//  SelectHeartCell.swift
//  Queenvu
//
//  Created by 신지원 on 3/2/25.
//

import UIKit

import SnapKit
import Then

final class SelectHeartCell: UITableViewCell {
    
    //MARK: - Properties
    
    static let identifier = "SelectHeartCell"
    
    //MARK: - UI Components
    
    private let cellView = UIView()
    private let cellImageView = UIImageView()
    private let cellTitleLabel = UILabel()
    private let cellDescriptionLabel = UILabel()
    private let cellSeletedImageView = UIImageView()
    
    //MARK: - Initializer
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setUI()
        setHierarchy()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Setup UI
    
    private func setUI() {
        self.do {
            $0.backgroundColor = .clear
            $0.selectionStyle = .none
        }
        
        cellView.do {
            $0.layer.cornerRadius = 8
            $0.backgroundColor = .white
        }
        
        cellImageView.do {
            $0.contentMode = .scaleAspectFill
        }
        
        cellTitleLabel.do {
            $0.textColor = .black1
            $0.font = .bold(size: 20)
        }
        
        cellDescriptionLabel.do {
            $0.textColor = .gray1
            $0.font = .normal(size: 17)
        }
        
        cellSeletedImageView.do {
            $0.image = .checkPng
            $0.contentMode = .scaleAspectFit
            $0.isHidden = true
        }
    }
    
    private func setHierarchy() {
        contentView.addSubview(cellView)
        [cellImageView,
         cellTitleLabel,
         cellDescriptionLabel,
         cellSeletedImageView].forEach {
            cellView.addSubview($0)
        }
    }
    
    private func setLayout() {
        cellView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.bottom.equalToSuperview().inset(10)
        }
        
        cellImageView.snp.makeConstraints {
            $0.top.leading.bottom.equalToSuperview().inset(20)
            $0.size.equalTo(45)
        }
        
        cellTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(20)
            $0.leading.equalTo(cellImageView.snp.trailing).offset(15)
            $0.trailing.equalToSuperview().inset(20)
        }
        
        cellDescriptionLabel.snp.makeConstraints {
            $0.top.equalTo(cellTitleLabel.snp.bottom).offset(5)
            $0.leading.equalTo(cellImageView.snp.trailing).offset(15)
            $0.trailing.equalToSuperview().inset(20)
        }
        
        cellSeletedImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(20)
            $0.size.equalTo(40)
        }
    }
    
    //MARK: - Bind Data
    
    func configure(data: HeartEntity) {
        cellImageView.image = data.heartImage
        cellTitleLabel.text = data.title
        cellDescriptionLabel.text = data.description
    }
    
    func selectedCell() {
        cellView.backgroundColor = .hotPink1
        cellTitleLabel.textColor = .white
        cellDescriptionLabel.textColor = .white
        cellSeletedImageView.isHidden = false
    }
    
    func deselectedCell() {
        cellView.backgroundColor = .white
        cellTitleLabel.textColor = .black1
        cellDescriptionLabel.textColor = .gray1
        cellSeletedImageView.isHidden = true
    }
}
