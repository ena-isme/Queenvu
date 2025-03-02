//
//  SelectHeartViewController.swift
//  Queenvu
//
//  Created by 신지원 on 3/2/25.
//

import UIKit

import RxSwift
import RxCocoa

final class SelectHeartViewController: UIViewController {
    
    //MARK: - Properties
    
    private let data = heartData
    private var selectedIndex: IndexPath?
    private let disposeBag = DisposeBag()
    
    //MARK: - UI Components
    
    private let rootView = SelectHeartView()
    
    //MARK: - Life Cycle
    
    override func loadView() {
        self.view = rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setDelegate()
        setRegister()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        viewWillAppearAction()
    }
    
    private func setDelegate() {
        rootView.selectHeartTableView.delegate = self
        rootView.selectHeartTableView.dataSource = self
    }
    
    private func setRegister() {
        rootView.selectHeartTableView.register(SelectHeartCell.self,
                                               forCellReuseIdentifier: SelectHeartCell.identifier)
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

extension SelectHeartViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SelectHeartCell.identifier, for: indexPath) as! SelectHeartCell
        cell.configure(data: data[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if let previousIndex = selectedIndex, let previousCell = tableView.cellForRow(at: previousIndex) as? SelectHeartCell {
            previousCell.deselectedCell()
        }
        
        if selectedIndex == indexPath {
            selectedIndex = nil
        } else {
            selectedIndex = indexPath
            if let cell = tableView.cellForRow(at: indexPath) as? SelectHeartCell {
                cell.selectedCell()
            }
        }
    }
}
