//
//  MyHeartView.swift
//  Queenvu
//
//  Created by 신지원 on 3/3/25.
//

import UIKit

import SnapKit
import Then

final class MyHeartView: UIView {
    
    //MARK: - UI Components
    
    let navigationView = MyHeartNavigationView()
    let heartImageView = UIImageView()
    private let cellTitleLabel = UILabel()
    private let cellDescriptionLabel = UILabel()
    
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

        heartImageView.do {
            $0.image = .pinkHeart
            $0.contentMode = .scaleAspectFit
        }
        
        cellTitleLabel.do {
            $0.text = "분홍색 하트"
            $0.textColor = .black1
            $0.font = .bold(size: 25)
        }
        
        cellDescriptionLabel.do {
            $0.text = "너를 사모해"
            $0.textColor = .gray1
            $0.font = .normal(size: 20)
        }
    }
    
    private func setHierarchy() {
        [navigationView,
         heartImageView,
         cellTitleLabel,
         cellDescriptionLabel].forEach {
            addSubview($0)
        }
    }
    
    private func setLayout() {
        navigationView.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(65)
        }
        
        heartImageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(navigationView.snp.bottom).offset(100)
            $0.width.equalTo(300)
        }
        
        cellTitleLabel.snp.makeConstraints {
            $0.top.equalTo(heartImageView.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
        }
        
        cellDescriptionLabel.snp.makeConstraints {
            $0.top.equalTo(cellTitleLabel.snp.bottom).offset(10)
            $0.centerX.equalToSuperview()
        }
    }
}
