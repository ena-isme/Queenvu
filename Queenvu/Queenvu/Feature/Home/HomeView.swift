//
//  HomeView.swift
//  Queenvu
//
//  Created by 신지원 on 3/2/25.
//

import UIKit

import SnapKit
import Then

final class HomeView: UIView {
    
    //MARK: - UI Components
    
    private let safeAreaView = UIView()
    let tabView = HomeTabView()
    let girlsView = HomeGirlsView()
    
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
        self.backgroundColor = .white
        
        safeAreaView.do {
            $0.backgroundColor = .demurePink2
        }
    }
    
    private func setHierarchy() {
        [safeAreaView,
         tabView,
         girlsView].forEach {
            addSubview($0)
        }
    }
    
    private func setLayout() {
        safeAreaView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(safeAreaLayoutGuide.snp.top).offset(10)
        }
        
        tabView.snp.makeConstraints {
            $0.top.equalTo(safeAreaView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(80 + 50)
        }
        
        girlsView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
}
