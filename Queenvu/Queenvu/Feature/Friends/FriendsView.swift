//
//  FriendsView.swift
//  Queenvu
//
//  Created by 신지원 on 3/3/25.
//

import UIKit

import SnapKit
import Then

final class FriendsView: UIView {
    
    //MARK: - UI Components
    
    let navigationView = FriendsNavigationView()
    let friendsTableView = UITableView()
    
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
        
        friendsTableView.do {
            $0.backgroundColor = .demurePink2
            $0.separatorStyle = .none
            $0.showsVerticalScrollIndicator = false
        }
    }
    
    private func setHierarchy() {
        [navigationView,
         friendsTableView].forEach {
            addSubview($0)
        }
    }
    
    private func setLayout() {
        navigationView.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(65)
        }
        
        friendsTableView.snp.makeConstraints {
            $0.top.equalTo(navigationView.snp.bottom).offset(20)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
}
