//
//  SearchView.swift
//  Queenvu
//
//  Created by 신지원 on 3/3/25.
//

import UIKit

import SnapKit
import Then

final class SearchView: UIView {
    
    //MARK: - UI Components
    
    let navigationView = SearchNavigationView()
    let searchBar = UISearchBar()
    let searchTableView = UITableView()
    
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
        
        searchBar.do {
            $0.placeholder = ""
            $0.barStyle = .default
            $0.backgroundColor = .clear
            $0.backgroundImage = UIImage()
            $0.searchTextField.backgroundColor = .hotPink1
            $0.searchTextField.textColor = .white
            $0.tintColor = .white
            
            let attributes: [NSAttributedString.Key: Any] = [
                .foregroundColor: UIColor.white,
                .font: UIFont.boldSystemFont(ofSize: 14)
            ]
            $0.searchTextField.attributedPlaceholder = NSAttributedString(string: "", attributes: attributes)
        }
        
        searchTableView.do {
            $0.backgroundColor = .demurePink2
            $0.separatorStyle = .none
            $0.showsVerticalScrollIndicator = false
        }
    }
    
    private func setHierarchy() {
        [navigationView,
         searchBar,
         searchTableView].forEach {
            addSubview($0)
        }
    }
    
    private func setLayout() {
        navigationView.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide.snp.top)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(65)
        }
        
        searchBar.snp.makeConstraints {
            $0.top.equalTo(navigationView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(80)
        }
        
        searchTableView.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom).offset(10)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
}
