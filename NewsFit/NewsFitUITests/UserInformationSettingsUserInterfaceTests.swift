//
//  UserInformationSettingUserInterfaceTests.swift
//  NewsFitUITests
//
//  Created by User on 6/4/24.
//

import XCTest

//MARK: - About Push notification settings
///음 이거는 만들고 할꼐요 ㅋㅋㅋ 푸시를 아직 잘 몰라..


//MARK: - About Logout
/// 로그아웃 클릭하면 우째야 하나?
/// 확인 누르면 로그인화면으로 이동
///
final class when_user_click_on_logout_cell: XCTestCase {
    private var app: XCUIApplication!
    private var settingPageObject: UserInformationSettingsPageObject!
    private let menuCount = 6
    
    override func setUp() {
        app = .init()
        continueAfterFailure = false
        
        settingPageObject = .init(app: app)
        let loginPageObject = LoginPageObject(app: app)
        let newsPageObject = NewsFitNewsPageObject(app: app)
        
        app.launchEnvironment = ["ENV" : "DEV"]
        
        app.launch()
        
        let kakaoLoginButton = loginPageObject.kakaoLoginButton
        
        _ = kakaoLoginButton.waitForExistence(timeout: 1)
        kakaoLoginButton.tap()
        
        _ = loginPageObject.mainLogoImage.waitForExistence(timeout: 0.5)
        
        let myInfoNavButton = newsPageObject.myInfoNavButton
        myInfoNavButton.tap()
    }
    
    func test_should_display_login_page_with_confirm() {
        let logoutButton = settingPageObject.myInfoCell(at: menuCount-2)
        _ = logoutButton.waitForExistence(timeout: 1)
        
        logoutButton.tap()
        
        let confirmButton = settingPageObject.confirmButton
        _ = confirmButton.waitForExistence(timeout: 1)
        
        confirmButton.tap()
        
        let kakaoLoginButton = LoginPageObject(app: app).kakaoLoginButton
        XCTAssertTrue(kakaoLoginButton.waitForExistence(timeout: 3))
    }
}

//MARK: - About Withdrawal

/// 회원탈퇴 기능 테스트
/// 확인 누르면 -> 로그인 화면으로 나가짐
/// 취소 누르면 설정화면으로 이동
final class when_user_click_on_withdrawal_cell: XCTestCase {
    private var app: XCUIApplication!
    private var settingPageObject: UserInformationSettingsPageObject!
    private let menuCount = 6
    
    override func setUp() {
        app = .init()
        continueAfterFailure = false
        
        settingPageObject = .init(app: app)
        let loginPageObject = LoginPageObject(app: app)
        let newsPageObject = NewsFitNewsPageObject(app: app)
        
        app.launchEnvironment = ["ENV" : "DEV"]
        
        app.launch()
        
        let kakaoLoginButton = loginPageObject.kakaoLoginButton
        
        _ = kakaoLoginButton.waitForExistence(timeout: 1)
        kakaoLoginButton.tap()
        
        _ = loginPageObject.mainLogoImage.waitForExistence(timeout: 0.5)
        
        let myInfoNavButton = newsPageObject.myInfoNavButton
        myInfoNavButton.tap()
    }
    
    func test_should_display_login_page_with_confirm() {
        let withdrawalButton = settingPageObject.myInfoCell(at: menuCount-1)
        _ = withdrawalButton.waitForExistence(timeout: 1)
        
        withdrawalButton.tap()
        
        let confirmButton = settingPageObject.confirmButton
        _ = confirmButton.waitForExistence(timeout: 1)
        
        confirmButton.tap()
        
        let realConfirmButton = settingPageObject.confirmButton
        _ = realConfirmButton.waitForExistence(timeout: 1)
        
        realConfirmButton.tap()
        
        let kakaoLoginButton = LoginPageObject(app: app).kakaoLoginButton
        XCTAssertTrue(kakaoLoginButton.waitForExistence(timeout: 3))
    }
    
    func test_should_navigate_to_my_information_page_with_cancel() {
        let withdrawalButton = settingPageObject.myInfoCell(at: menuCount-1)
        _ = withdrawalButton.waitForExistence(timeout: 1)
        
        withdrawalButton.tap()
        
        let confirmButton = settingPageObject.confirmButton
        _ = confirmButton.waitForExistence(timeout: 1)
        
        confirmButton.tap()
        
        let cancelButton = settingPageObject.cancelButton
        _ = cancelButton.waitForExistence(timeout: 1)
        
        cancelButton.tap()
        
        XCTAssertTrue(withdrawalButton.waitForExistence(timeout: 1))
    }
}
