//
//  LoginView.swift
//  Queenvu
//
//  Created by 신지원 on 3/2/25.
//

import UIKit
import AuthenticationServices

import SnapKit
import Then

final class LoginView: UIView {
    
    //MARK: - UI Components
    
    private let loginLabel = UILabel()
    let appleLoginButton = ASAuthorizationAppleIDButton(type: .signIn, style: .black)
    
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

        loginLabel.do {
            $0.text = "환영해,,,\n   공주들의 놀이터"
            $0.font = .extraBold(size: 30)
            $0.textColor = .hotPink1
            $0.numberOfLines = 2
        }
        
        appleLoginButton.cornerRadius = 25
    }
    
    private func setHierarchy() {
        [loginLabel,
         appleLoginButton].forEach {
            addSubview($0)
        }
    }
    
    private func setLayout() {
        loginLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().offset(-100)
        }
        
        appleLoginButton.snp.makeConstraints {
            $0.top.equalTo(loginLabel.snp.bottom).offset(100)
            $0.leading.trailing.equalToSuperview().inset(40)
            $0.height.equalTo(60)
        }
    }
}
