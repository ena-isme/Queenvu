//
//  SearchCell.swift
//  Queenvu
//
//  Created by 신지원 on 3/3/25.
//

import UIKit

import SnapKit
import Then

final class SearchCell: UITableViewCell {
    
    //MARK: - Properties
    
    static let identifier = "SearchCell"
    
    //MARK: - UI Components
    
    private let cellView = UIView()
    private let cellTitleLabel = UILabel()
    private let cellSeletedLabel = UILabel()
    
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
        
        cellTitleLabel.do {
            $0.textColor = .black1
            $0.font = .bold(size: 25)
        }
        
        cellSeletedLabel.do {
            $0.text = "GO"
            $0.textColor = .white
            $0.font = .bold(size: 27)
            $0.isHidden = true
        }
    }
    
    private func setHierarchy() {
        contentView.addSubview(cellView)
        [cellTitleLabel,
         cellSeletedLabel].forEach {
            cellView.addSubview($0)
        }
    }
    
    private func setLayout() {
        cellView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.height.equalTo(50)
            $0.leading.trailing.bottom.equalToSuperview().inset(10)
        }
        
        cellTitleLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(20)
        }

        cellSeletedLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(20)
        }
    }
    
    //MARK: - Bind Data
    
    func configure(nickname: String) {
        cellTitleLabel.text = nickname
    }
    
    func selectedCell() {
        cellView.backgroundColor = .hotPink1
        cellTitleLabel.textColor = .white
        cellSeletedLabel.isHidden = false
    }
    
    func deselectedCell() {
        cellView.backgroundColor = .white
        cellTitleLabel.textColor = .black1
        cellSeletedLabel.isHidden = true
    }
}
