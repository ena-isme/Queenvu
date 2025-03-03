//
//  SearchViewController.swift
//  Queenvu
//
//  Created by 신지원 on 3/3/25.
//

import UIKit

import RxSwift
import RxCocoa

final class SearchViewController: UIViewController {
    
    //MARK: - Properties
    
    private var selectedIndex: IndexPath?
    private let disposeBag = DisposeBag()
    private let friendList = BehaviorRelay<[UserEntity]>(value: [])
    
    //MARK: - UI Components
    
    private let rootView = SearchView()
    
    //MARK: - Life Cycle
    
    override func loadView() {
        self.view = rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setRegister()
        bindAction()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        viewWillAppearAction()
    }
    
    private func setRegister() {
        rootView.searchTableView.register(SearchCell.self,
                                          forCellReuseIdentifier: SearchCell.identifier)
    }

    private func loadFriendData() {
        let friends = CoreDataManager.shared.fetchUserList()
        friendList.accept(friends)
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
}

//MARK: - UITableViewDataSource & UITableViewDelegate

extension SearchViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friendList.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchCell.identifier, for: indexPath) as! SearchCell
        let user = friendList.value[indexPath.row]
        cell.configure(nickname: user.fullName ?? "")
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        if let previousIndex = selectedIndex, let previousCell = tableView.cellForRow(at: previousIndex) as? SearchCell {
            previousCell.deselectedCell()
        }

        if selectedIndex == indexPath {
            selectedIndex = nil
        } else {
            selectedIndex = indexPath
            if let cell = tableView.cellForRow(at: indexPath) as? SearchCell {
                cell.selectedCell()
            }
        }
        
        let selectedUser = friendList.value[indexPath.row]
        let homeViewController = HomeViewController(email: selectedUser.email ?? "",
                                                    isMyProfile: false,
                                                    isFriend: false)
        navigationController?.pushViewController(homeViewController, animated: true)
    }
}
