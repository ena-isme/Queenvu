//
//  FriendsViewController.swift
//  Queenvu
//
//  Created by 신지원 on 3/3/25.
//

import UIKit

import RxSwift
import RxCocoa

final class FriendsViewController: UIViewController {
    
    //MARK: - Properties
    
    private var selectedIndex: IndexPath?
    private let disposeBag = DisposeBag()
    private let friendList = BehaviorRelay<[DummyFriend]>(value: [])
    
    //MARK: - UI Components
    
    private let rootView = FriendsView()
    
    //MARK: - Life Cycle
    
    override func loadView() {
        self.view = rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setRegister()
        bindTableView()
        bindAction()
        loadFriendData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        viewWillAppearAction()
    }
    
    private func setRegister() {
        rootView.friendsTableView.register(FriendsCell.self,
                                           forCellReuseIdentifier: FriendsCell.identifier)
    }
    
    private func loadFriendData() {
        let dummyFriends = createDummyFriends()
        friendList.accept(dummyFriends)
    }
    
    //MARK: - Action
    
    private func viewWillAppearAction() {
        navigationController?.navigationBar.isHidden = true
    }
    
    private func bindAction() {
        rootView.navigationView.navigationBackButton.rx.tap
            .bind { [weak self] in
                self?.navigationController?.popViewController(animated: true)
            }
            .disposed(by: disposeBag)
    }
    
    //MARK: - Data Handling
    
    private func bindTableView() {
        friendList
            .bind(to: rootView.friendsTableView.rx.items(cellIdentifier: FriendsCell.identifier, cellType: FriendsCell.self)) { _, model, cell in
                
                guard model.heart >= 0, model.heart < heartData.count else {
                    cell.configure(nickname: model.email, cellHeartImage: nil)
                    return
                }
                
                let heartImage = heartData[model.heart].heartImage
                cell.configure(nickname: model.email, cellHeartImage: heartImage)
            }
            .disposed(by: disposeBag)
        
        rootView.friendsTableView.rx.modelSelected(DummyFriend.self)
            .subscribe(onNext: { [weak self] selectedFriend in
                let homeViewController = HomeViewController(email: selectedFriend.email,
                                                            isMyProfile: false,
                                                            isFriend: false)
                self?.navigationController?.pushViewController(homeViewController, animated: true)
            })
            .disposed(by: disposeBag)
    }
    
    private func handleFriendSelection(friend: DummyFriend) {
        if let index = friendList.value.firstIndex(where: { $0.email == friend.email }) {
            let indexPath = IndexPath(row: index, section: 0)
            selectedIndex = indexPath
        }
    }
}
