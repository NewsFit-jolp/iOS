//
//  NewsFitUITests.swift
//  NewsFitUITests
//
//  Created by User on 5/28/24.e
//

import XCTest

/// 로그인 제대로 되는지 확인하는 테스트
/// kakao, naver, apple 로그인 각각 확인
/// 성공 / 실패의 경우 탐지
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

/// 회원가입 제대로 되는지 확인하는 테스트
/// kakao, naver, apple 회원가입 각각 확인
/// 성공 / 실패의 경우 탐지
final class when_user_click_on_social_registration_button: XCTestCase {
    
    private var app: XCUIApplication!
    private var loginPageObject: LoginPageObject!
    
    override func setUp() {
        app = .init()
        continueAfterFailure = false
        
        loginPageObject = .init(app: app)
        
        app.launch()
    }
    
    func test_should_navigate_to_basic_info_for_success_with_kakao_registration() {
        loginPageObject.kakaoRegistrationButton.tap()
        
        XCTAssertTrue(loginPageObject.nameTextField.waitForExistence(timeout: 1))
    }
    func test_should_navigate_to_basic_info_for_success_with_naver_registration() {
        loginPageObject.naverRegistrationButton.tap()
        
        XCTAssertTrue(loginPageObject.nameTextField.waitForExistence(timeout: 1))
    }
    func test_should__navigate_to_basic_info_for_success_with_apple_registration() {
        loginPageObject.appleRegistrationButton.tap()
        
        XCTAssertTrue(loginPageObject.nameTextField.waitForExistence(timeout: 1))
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

/// 이름, 이메일, 전화번호가 유효하게 입력되었는지 확인하는 테스트
/// 실패 == 값이 입력되지 않았을 경우 || 올바르지 않은 값이 들어왔을 경우
/// 성공 -> 다음화면으로 넘어감
/// 실패 -> 에러메시지 출력 + 다음버튼 비활성화
final class when_user_put_basic_information: XCTestCase {
    
    private var app: XCUIApplication!
    private var loginPageObject: LoginPageObject!
    
    override func setUp() {
        app = .init()
        continueAfterFailure = false
        
        loginPageObject = .init(app: app)
        
        app.launch()
        
        loginPageObject.kakaoRegistrationButton.tap()
    }
    
    func test_should_display_error_message_for_missing_required_fields() {
        //        let nameTextField = loginPageObject.nameTextField
        let emailTextField = loginPageObject.emailTextField
        let phoneTextField = loginPageObject.phoneTextField
        
        let emailMessageLabel = loginPageObject.emailMessageLabel
        let phoneMessageLabel = loginPageObject.phoneMessageLabel
        
        //        nameTextField.tap()
        //        nameTextField.typeText("")
        
        // 이메일 검사
        emailTextField.tap()
        emailTextField.typeText("")
        
        XCTAssertEqual(emailMessageLabel.label, "이메일 형식이 올바르지 않습니다.")
        
        // 전화번호 검사
        phoneTextField.tap()
        phoneTextField.typeText("")
        
        XCTAssertEqual(phoneMessageLabel.label, "전화번호 형식이 올바르지 않습니다.")
        
        // 다음버튼 검사
        XCTAssertFalse(loginPageObject.nextButton.isEnabled)
    }
    
    
    func test_should_display_error_message_for_invalid_required_fields() {
        //        let nameTextField = loginPageObject.nameTextField
        let emailTextField = loginPageObject.emailTextField
        let phoneTextField = loginPageObject.phoneTextField
        
        let emailMessageLabel = loginPageObject.emailMessageLabel
        let phoneMessageLabel = loginPageObject.phoneMessageLabel
        
        //        nameTextField.tap()
        //        nameTextField.typeText("")
        
        // 이메일 검사
        emailTextField.tap()
        emailTextField.typeText("wrong@Hello")
        
        XCTAssertEqual(emailMessageLabel.label, "이메일 형식이 올바르지 않습니다.")
        
        // 전화번호 검사
        phoneTextField.tap()
        phoneTextField.typeText("010123834")
        
        XCTAssertEqual(phoneMessageLabel.label, "전화번호 형식이 올바르지 않습니다.")
        
        // 다음버튼 검사
        XCTAssertFalse(loginPageObject.nextButton.isEnabled)
    }
    
    func test_should_navigate_to_additional_info_for_success() {
        // let nameTextField = loginPageObject.nameTextField
        let emailTextField = loginPageObject.emailTextField
        let phoneTextField = loginPageObject.phoneTextField
        
        let emailMessageLabel = loginPageObject.emailMessageLabel
        let phoneMessageLabel = loginPageObject.phoneMessageLabel
        
        // nameTextField.tap()
        // nameTextField.typeText("")
        
        // 이메일 검사
        emailTextField.tap()
        emailTextField.typeText("newsfit@goodemail.com")
        
        XCTAssertEqual(emailMessageLabel.label, "")
        
        // 전화번호 검사
        phoneTextField.tap()
        phoneTextField.typeText("01012341234")
        
        XCTAssertEqual(phoneMessageLabel.label, "")
        
        let nextButton = loginPageObject.nextButton
        // 다음버튼 검사
        XCTAssertTrue(nextButton.isEnabled)
        nextButton.tap()
        
        XCTAssertTrue(loginPageObject.maleCheckBox.waitForExistence(timeout: 1))
    }
    
    override func tearDown() {
        print("test done")
    }
}

final class when_user_put_additional_information: XCTestCase {
    
    private var app: XCUIApplication!
    private var loginPageObject: LoginPageObject!
    
    override func setUp() {
        app = .init()
        continueAfterFailure = false
        
        loginPageObject = .init(app: app)
        
        app.launch()
        
        loginPageObject.kakaoRegistrationButton.tap()
        
        let emailTextField = loginPageObject.emailTextField
        let phoneTextField = loginPageObject.phoneTextField
        emailTextField.tap()
        emailTextField.typeText("newsfit@goodemail.com")
        
        // 전화번호 검사
        phoneTextField.tap()
        phoneTextField.typeText("01012341234")
        
        let nextButton = loginPageObject.nextButton
        nextButton.tap()
    }
    
    func test_should_be_checked_sex_on_male_by_default() {
        XCTAssertTrue(loginPageObject.maleCheckBox.isSelected)
    }
    
    func test_should_select_only_one_sex() {
        let maleCheckBox = loginPageObject.maleCheckBox
        let femaleCheckBox = loginPageObject.femaleCheckBox
        
        maleCheckBox.tap()
        XCTAssertTrue(maleCheckBox.isSelected)
        XCTAssertFalse(femaleCheckBox.isSelected)
        
        femaleCheckBox.tap()
        XCTAssertFalse(maleCheckBox.isSelected)
        XCTAssertTrue(femaleCheckBox.isSelected)
    }
    
    func test_should_not_activate_next_button_for_missing_required_fields() {
        let birthdayTextField = loginPageObject.birthdayTextField
        
        birthdayTextField.tap()
        birthdayTextField.typeText("")
        
        // 다음버튼 검사
        XCTAssertFalse(loginPageObject.nextButton.isEnabled)
    }
    
    func test_should_not_activate_next_button_for_invalid_required_fields() {
        let birthdayTextField = loginPageObject.birthdayTextField
        
        birthdayTextField.tap()
        birthdayTextField.typeText("20129999")
        
        // 다음버튼 검사
        XCTAssertFalse(loginPageObject.nextButton.isEnabled)
    }
    
    func test_should_navigate_to_topic_selection_for_success() {
        let birthdayTextField = loginPageObject.birthdayTextField
        
        birthdayTextField.tap()
        birthdayTextField.typeText("20240101")
        
        let nextButton = loginPageObject.nextButton
        // 다음버튼 검사
        XCTAssertTrue(nextButton.isEnabled)
        nextButton.tap()
        
        XCTAssertTrue(loginPageObject.newsTopicButton.waitForExistence(timeout: 1))
    }
    
    override func tearDown() {
        print("test done")
    }
}

