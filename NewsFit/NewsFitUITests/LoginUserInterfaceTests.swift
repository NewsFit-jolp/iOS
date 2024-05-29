//
//  NewsFitUITests.swift
//  NewsFitUITests
//
//  Created by User on 5/28/24.e
//

import XCTest

final class when_user_click_on_social_login_button: XCTestCase {
    
    private var app: XCUIApplication!
    private var loginPageObject: LoginPageObject!
    
    override func setUp() {
        app = .init()
        continueAfterFailure = false
        
        loginPageObject = .init(app: app)
        
        app.launchEnvironment = ["ENV" : "DEV"]
        
        app.launch()
    }
    
    func test_should_display_news_home_for_success_with_kakao_login() {
        loginPageObject.kakaoLoginButton.tap()
        
        XCTAssertTrue(loginPageObject.mainLogoImage.waitForExistence(timeout: 0.5))
    }
    func test_should_display_news_home_for_success_with_naver_login() {
        loginPageObject.naverLoginButton.tap()
        
        XCTAssertTrue(loginPageObject.mainLogoImage.waitForExistence(timeout: 0.5))
    }
    func test_should_display_news_home_for_success_with_apple_login() {
        loginPageObject.appleLoginButton.tap()
        
        XCTAssertTrue(loginPageObject.mainLogoImage.waitForExistence(timeout: 0.5))
    }
    
    func test_should_not_do_anything_for_failure_with_kakao_login() {
        loginPageObject.kakaoLoginButton.tap()
        
        XCTAssertTrue(loginPageObject.kakaoLoginButton.waitForExistence(timeout: 0.5))
    }
    func test_should_not_do_anything_for_failure_with_naver_login() {
        loginPageObject.naverLoginButton.tap()
        
        XCTAssertTrue(loginPageObject.kakaoLoginButton.waitForExistence(timeout: 0.5))
    }
    func test_should_not_do_anything_for_failure_with_apple_login() {
        loginPageObject.appleLoginButton.tap()
        
        XCTAssertTrue(loginPageObject.kakaoLoginButton.waitForExistence(timeout: 0.5))
    }
    
    override func tearDown() {
        print("test done")
    }
    
}

final class when_user_click_on_social_registration_button: XCTestCase {
    
    private var app: XCUIApplication!
    private var loginPageObject: LoginPageObject!
    
    override func setUp() {
        app = .init()
        continueAfterFailure = false
        
        loginPageObject = .init(app: app)
        
        app.launch()
    }
    
    func test_should_display_news_home_for_success_with_kakao_registration() {
        loginPageObject.kakaoRegistrationButton.tap()
        
        XCTAssertTrue(loginPageObject.nameTextField.waitForExistence(timeout: 0.5))
    }
    func test_should_display_news_home_for_success_with_naver_registration() {
        loginPageObject.naverRegistrationButton.tap()
        
        XCTAssertTrue(loginPageObject.nameTextField.waitForExistence(timeout: 0.5))
    }
    func test_should_display_news_home_for_success_with_apple_registration() {
        loginPageObject.appleRegistrationButton.tap()
        
        XCTAssertTrue(loginPageObject.nameTextField.waitForExistence(timeout: 0.5))
    }
    
    func test_should_not_do_anything_for_failure_with_kakao_registration() {
        loginPageObject.kakaoRegistrationButton.tap()
        
        XCTAssertTrue(loginPageObject.kakaoRegistrationButton.waitForExistence(timeout: 0.5))
    }
    func test_should_not_do_anything_for_failure_with_naver_registration() {
        loginPageObject.naverRegistrationButton.tap()
        
        XCTAssertTrue(loginPageObject.naverRegistrationButton.waitForExistence(timeout: 0.5))
    }
    func test_should_not_do_anything_for_failure_with_apple_registration() {
        loginPageObject.appleRegistrationButton.tap()
        
        XCTAssertTrue(loginPageObject.appleRegistrationButton.waitForExistence(timeout: 0.5))
    }
    
    override func tearDown() {
        print("test done")
    }
    
    
}
