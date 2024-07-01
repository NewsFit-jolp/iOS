//
//  LoginViewController.swift
//  NewsFit
//
//  Created by User on 6/25/24.
//

import UIKit

//MARK: - LoginViewController
final class LoginViewController: UIViewController {
    //MARK: - Properties
    private let naverLoginButton = NFButton(with: .naverLogin(isSmall: false))
    private let kakaoLoginButton = NFButton(with: .kakaoLogin(isSmall: false))
    private let appleLoginButton = NFButton(with: .appleLogin(isSmall: false))
    
    private let naverRegisterButton = NFButton(with: .naverLogin(isSmall: true))
    private let kakaoRegisterButton = NFButton(with: .kakaoLogin(isSmall: true))
    private let appleRegisterButton = NFButton(with: .appleLogin(isSmall: true))
    
    private let logo: UIImageView = {
        let uv = UIImageView(image: UIImage(named: "NFLogo")!)
        uv.contentMode = .scaleAspectFit
        uv.frame = .init(x: 0, y: 0, width: 105, height: 105)
        return uv
    }()
    private let appImage: UIImageView = {
        let uv = UIImageView(image: UIImage(named: "AppIcon")!)
        uv.contentMode = .scaleAspectFill
        uv.frame = .init(x: 0, y: 0, width: 190, height: 68)
        return uv
    }()
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        setup()
    }
    
    //MARK: - Helper
    private func setup() {
        setupButtons()
        configureViews()
    }
    
    private func setupButtons() {
        //login buttons
        naverLoginButton.addTarget(action: #selector(naverLoginTapped))
        kakaoLoginButton.addTarget(action: #selector(naverLoginTapped))
        appleLoginButton.addTarget(action: #selector(naverLoginTapped))
        
        // register buttons
        naverRegisterButton.addTarget(action: #selector(naverRegisterTapped))
        kakaoRegisterButton.addTarget(action: #selector(naverRegisterTapped))
        appleRegisterButton.addTarget(action: #selector(naverRegisterTapped))
    }
    
    private func configureViews() {
        // 1. logo를 설정한다.
        let logoStack = UIStackView(arrangedSubviews: [appImage, logo])
        logoStack.axis = .vertical
        logoStack.spacing = 1
        logoStack.alignment = .center
        logoStack.distribution = .fillProportionally
        view.addSubview(logoStack)
        logoStack.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(137)
        }
        // 2. 로그인 버튼들을 설정한다.
        let loginStack = UIStackView(arrangedSubviews: [naverLoginButton, kakaoLoginButton, appleLoginButton])
        loginStack.axis = .vertical
        logoStack.spacing = 15
        loginStack.alignment = .center
        loginStack.distribution = .fillEqually
        view.addSubview(loginStack)
        loginStack.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(logoStack.snp.bottom).offset(115)
        }
        
        
        // 3. 회원가입 버튼들을 설정한다.
    }
    
    //MARK: - Selectors
    @objc private func naverLoginTapped() {
        // login Logics Here
        
        // Turn to next page
        turnToNext()
    }
    
    @objc private func naverRegisterTapped() {
        // login Logics Here
        
        // Turn to next page
        turnToNext()
    }
    
    private func turnToNext() {
        self.navigationController?.pushViewController(.init(), animated: true)
    }
}

