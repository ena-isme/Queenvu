//
//  LoginViewController.swift
//  Queenvu
//
//  Created by 신지원 on 3/2/25.
//

import UIKit
import AuthenticationServices

import RxSwift
import RxCocoa

final class LoginViewController: UIViewController {
    
    //MARK: - Properties
    
    private let coreDataManager = CoreDataManager.shared
    
    //MARK: - UI Components
    
    private let rootView = LoginView()
    
    //MARK: - Life Cycle
    
    override func loadView() {
        self.view = rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        checkAutoLogin()
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
        rootView.appleLoginButton.addTarget(self,
                                            action: #selector(handleAppleSignInButtonTapped),
                                            for: .touchUpInside)
    }
    
    private func checkAutoLogin() {
        let email = UserDefaults.standard.string(forKey: "userEmail")
        print("✅ 자동 로그인: \(email)")
        let homeViewController = HomeViewController(email: email ?? "")
        navigationController?.pushViewController(homeViewController, animated: true)
    }
    
    @objc
    private func handleAppleSignInButtonTapped() {
        let request = ASAuthorizationAppleIDProvider().createRequest()
        request.requestedScopes = [.fullName, .email]
        
        let controller = ASAuthorizationController(authorizationRequests: [request])
        controller.delegate = self
        controller.presentationContextProvider = self
        controller.performRequests()
    }
}

extension LoginViewController: ASAuthorizationControllerDelegate {
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            let userID = appleIDCredential.user
            let fullName = appleIDCredential.fullName?.givenName ?? ""
            let email = appleIDCredential.email ?? ""
            
            let newUser = UserEntity(context: coreDataManager.context)
            newUser.userID = userID
            newUser.fullName = fullName
            newUser.email = email
            
            print(userID)
            print(fullName)
            print(email)
            UserDefaults.standard.set(fullName, forKey: "userName")
            UserDefaults.standard.set(email, forKey: "userEmail")
            coreDataManager.saveUser(userData: newUser)
            
            let homeViewController = HomeViewController(email: email)
            navigationController?.pushViewController(homeViewController, animated: true)
        }
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print("❌ 애플 로그인 실패: \(error.localizedDescription)")
    }
}

extension LoginViewController: ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return view.window!
    }
}
