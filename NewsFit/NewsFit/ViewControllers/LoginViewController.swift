//
//  LoginViewController.swift
//  NewsFit
//
//  Created by User on 6/25/24.
//

import UIKit
import AuthenticationServices

//MARK: - LoginViewController
final class LoginViewController: UIViewController {
    //MARK: - Properties
    private let naverLoginButton: NFButton = {
        let btn = NFButton(with: .naverLogin(isSmall: false))
        
        // add Views to button
        let img = UIImageView(image: .init(named: "naver_logo_white"))
        img.frame = .init(x: 0, y: 0, width: 16, height: 16)
        img.contentMode = .scaleAspectFill
        
        let lb = NFLabel()
        lb.setText("네이버 로그인", with: .button)
        
        btn.setTitle(views: [img, lb], spacing: 10)
        return btn
    }()
    private let kakaoLoginButton: NFButton =  {
        let btn = NFButton(with: .kakaoLogin(isSmall: false))
        let img = UIImageView(image: .init(named: "kakao_logo"))
        img.frame = .init(x: 0, y: 0, width: 18, height: 18)
        img.contentMode = .scaleAspectFill
        
        let lb = NFLabel()
        lb.setText("카카오 로그인", with: .button)
        
        btn.setTitle(views: [img, lb], spacing: 10)
        return btn
    }()
    private let appleLoginButton: ASAuthorizationAppleIDButton = {
        let btn = ASAuthorizationAppleIDButton(authorizationButtonType: .continue, authorizationButtonStyle: .black)
        btn.cornerRadius = 8
        
        return btn
    }()
    
    private let naverRegisterButton: NFButton = {
        let btn = NFButton(with: .naverLogin(isSmall: true))
        return btn
    }()
    private let kakaoRegisterButton: NFButton = {
        let btn = NFButton(with: .kakaoLogin(isSmall: true))
        return btn
    }()
    private let appleRegisterButton: NFButton = {
        let btn = NFButton(with: .appleLogin(isSmall: true))
        return btn
    }()
    
    private let logo: UIImageView = {
        let uv = UIImageView(image: UIImage(named: "NFLogo"))
        uv.contentMode = .scaleAspectFit
        uv.frame = .init(x: 0, y: 0, width: 105, height: 105)
        return uv
    }()
    private let appImage: UIImageView = {
        let uv = UIImageView(image: UIImage(named: "AppIcon"))
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
//        appleLoginButton.addTarget(action: #selector(naverLoginTapped))
        
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
            make.width.equalTo(190)
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
            make.width.equalTo(331)
        }
        
        
        // 3. 회원가입 버튼들을 설정한다.
    }
    
    //MARK: - Selectors
    @objc private func naverLoginTapped() {
        // login Logics Here
        print(#function)
        // Turn to next page
        turnToNext()
    }
    
    @objc private func naverRegisterTapped() {
        // login Logics Here
        print(#function)
        
        // Turn to next page
        turnToNext()
    }
    
    private func turnToNext() {
        self.navigationController?.pushViewController(.init(), animated: true)
    }
}

