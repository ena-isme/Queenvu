//
//  SearchNavigationView.swift
//  Queenvu
//
//  Created by 신지원 on 3/3/25.
//

import UIKit

import SnapKit
import Then

final class SearchNavigationView: UIView {
    
    //MARK: - UI Components
    
    private let navigationTitleLabel = UILabel()
    let navigationBackButton = UIButton()
    
    //MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
        setHierarchy()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Setup UI
    
    private func setUI() {
        self.backgroundColor = .demurePink2

        navigationBackButton.do {
            $0.setImage(.backArrow.withRenderingMode(.alwaysOriginal).withTintColor(.gray1), for: .normal)
        }
        
        navigationTitleLabel.do {
            $0.text = "공주는\n   누가 궁금할까나 𓂃⊹ ִֶָ"
            $0.numberOfLines = 2
            $0.textColor = .hotPink1
            $0.font = .extraBold(size: 25)
        }
    }
    
    private func setHierarchy() {
        [navigationBackButton,
         navigationTitleLabel].forEach {
            addSubview($0)
        }
    }
    
    private func setLayout() {
        navigationBackButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(20)
            $0.size.equalTo(50)
        }
        
        navigationTitleLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.centerX.equalToSuperview().offset(20)
        }
    }
}
