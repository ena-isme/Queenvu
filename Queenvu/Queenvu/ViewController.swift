//
//  ViewController.swift
//  Queenvu
//
//  Created by 신지원 on 3/2/25.
//

import UIKit

import Then
import SnapKit

final class ViewController: UIViewController {

    let testLabel: UILabel = {
        let label = UILabel()
        label.text = "Hello, World!"
        label.font = UIFont(name: "PFStardust", size: 20)
        label.textColor = .black
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        view.addSubview(testLabel)
        testLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
}

