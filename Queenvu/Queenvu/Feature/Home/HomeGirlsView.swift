//
//  HomeGirlsView.swift
//  Queenvu
//
//  Created by 신지원 on 3/2/25.
//

import UIKit

import SnapKit
import Then

final class HomeGirlsView: UIView {
    
    //MARK: - Properties
    
    private let girlsImageList: [UIImage] = [.lovely, .cute, .pretty, .sexy]
    
    //MARK: - UI Components
    
    private let girlImageView = UIImageView()
    private let bubbleImageView = UIImageView()
    private let bubbleTextLabel = UILabel()
    
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

        girlImageView.do {
            $0.image = girlsImageList.randomElement()
            $0.contentMode = .scaleAspectFit
        }
        
        bubbleImageView.do {
            $0.image = .bubble
            $0.contentMode = .scaleAspectFit
        }
        
        bubbleTextLabel.do {
            $0.text = "방명록 써 Baby"
            $0.font = .bold(size: 25)
            $0.textColor = .white
        }
    }
    
    private func setHierarchy() {
        [girlImageView,
         bubbleImageView].forEach {
            addSubview($0)
        }
        bubbleImageView.addSubview(bubbleTextLabel)
    }
    
    private func setLayout() {
        girlImageView.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(-50)
            $0.bottom.equalToSuperview().inset(-70)
            $0.height.equalTo(550)
            $0.width.equalTo(350)
        }
        
        bubbleImageView.snp.makeConstraints {
            $0.bottom.equalTo(girlImageView.snp.top).offset(110)
            $0.leading.equalTo(girlImageView.snp.leading).offset(-100)
            $0.height.equalTo(200)
            $0.width.equalTo(280)
            
            bubbleTextLabel.snp.makeConstraints {
                $0.centerY.equalToSuperview().offset(-18)
                $0.centerX.equalToSuperview()
            }
        }
    }
}
