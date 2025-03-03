//
//  HomeTabView.swift
//  Queenvu
//
//  Created by 신지원 on 3/2/25.
//

import UIKit

import SnapKit
import Then

final class HomeTabView: UIView {
    
    //MARK: - UI Components
    
    let nameLabel = UILabel()
    let navigationBackButton = UIButton()
    
    private let stackView = UIStackView()
    let diaryButton = UIButton()
    let visitorsButton = UIButton()
    let heartButton = UIButton()
    let glassesButton = UIButton()
    
    private let spacer1 = UIView()
    private let spacer2 = UIView()
    private let spacer3 = UIView()
    private let spacer4 = UIView()
    private let spacer5 = UIView()
    
    private let bottomSpacer = UIView()
    
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
        self.do {
            $0.backgroundColor = .demurePink2
            $0.isUserInteractionEnabled = true
        }
        
        navigationBackButton.do {
            $0.setImage(.backArrow.withRenderingMode(.alwaysOriginal).withTintColor(.gray1), for: .normal)
            $0.isHidden = true
        }
        
        nameLabel.do {
            $0.font = .extraBold(size: 20)
            $0.textColor = .hotPink1
            $0.numberOfLines = 2
            $0.textAlignment = .center
        }
        
        stackView.do {
            $0.axis = .horizontal
            $0.distribution = .fillProportionally
        }
        
        diaryButton.do {
            $0.setImage(.diary, for: .normal)
        }
        
        visitorsButton.do {
            $0.setImage(.pencil, for: .normal)
        }
        
        glassesButton.do {
            $0.setImage(.glasses, for: .normal)
        }
        
        heartButton.do {
            $0.setImage(.heart, for: .normal)
        }
    }
    
    private func setHierarchy() {
        [navigationBackButton,
         nameLabel,
         stackView,
         bottomSpacer].forEach {
            addSubview($0)
        }
        [spacer1,
         diaryButton,
         spacer2,
         visitorsButton,
         spacer3,
         glassesButton,
         spacer4,
         heartButton,
         spacer5].forEach {
            stackView.addArrangedSubview($0)
        }
    }
    
    private func setLayout() {
        nameLabel.snp.makeConstraints {
            $0.top.centerX.equalToSuperview()
        }
        
        navigationBackButton.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(20)
            $0.centerY.equalTo(nameLabel.snp.centerY)
            $0.size.equalTo(50)
        }
        
        stackView.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(70)
        }
        [diaryButton,
         visitorsButton,
         glassesButton,
         heartButton].forEach {
            $0.snp.makeConstraints {
                $0.width.equalTo(75)
            }
        }
        
        let screenWidth = UIScreen.main.bounds.width
        let spacerWidth = (screenWidth - 75*4) / 5
        [spacer1,
         spacer2,
         spacer3,
         spacer4,
         spacer5].forEach {
            $0.snp.makeConstraints {
                $0.width.equalTo(spacerWidth)
            }
        }
        
        bottomSpacer.snp.makeConstraints {
            $0.top.equalTo(stackView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(10)
        }
    }
    
    func configure(name: String) {
        nameLabel.text = "\(name) 공주님의 하우스\n — ˗ˋ ୨୧ ˊ˗ —"
    }
}
