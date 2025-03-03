//
//  HomeViewController.swift
//  Queenvu
//
//  Created by 신지원 on 3/2/25.
//

import UIKit

import RxSwift
import RxCocoa

final class HomeViewController: UIViewController {
    
    //MARK: - Properties
    
    private let disposeBag = DisposeBag()
    private let email: String
    private let isMyProfile: Bool
    private let isFriend: Bool
    
    //MARK: - UI Components
    
    private let rootView = HomeView()
    
    //MARK: - Initializer
    
    init(email: String, isMyProfile: Bool = true, isFriend: Bool = false) {
        self.email = email
        self.isMyProfile = isMyProfile
        self.isFriend = isFriend
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Life Cycle
    
    override func loadView() {
        self.view = rootView
        rootView.tabView.navigationBackButton.isHidden = isMyProfile
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let name = UserDefaults.standard.string(forKey: "userName") ?? "예뿐"
        rootView.tabView.configure(name: name)
        bindAction()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        viewWillAppearAction()
    }
    
    //MARK: - Action
    
    private func viewWillAppearAction() {
        navigationController?.navigationBar.isHidden = true
    }
    
    private func bindAction() {
        rootView.tabView.diaryButton.rx.tap
            .bind { [weak self] in
                let friendsViewController = FriendsViewController()
                self?.navigationController?.pushViewController(friendsViewController, animated: true)
            }
            .disposed(by: disposeBag)
        
        rootView.tabView.heartButton.rx.tap
            .bind { [weak self] in
                let heartViewController = SelectHeartViewController(isMyProfile: self?.isMyProfile ?? true)
                self?.navigationController?.pushViewController(heartViewController, animated: true)
            }
            .disposed(by: disposeBag)
        
        rootView.tabView.glassesButton.rx.tap
            .bind { [weak self] in
                let searchViewController = SearchViewController()
                self?.navigationController?.pushViewController(searchViewController, animated: true)
            }
            .disposed(by: disposeBag)
        
        rootView.tabView.navigationBackButton.rx.tap
            .bind { [weak self] in
                self?.navigationController?.popViewController(animated: true)
            }
            .disposed(by: disposeBag)
    }
}
