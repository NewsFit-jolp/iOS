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
        
        let kakaoRegistrationButton = loginPageObject.kakaoRegistrationButton
        
        _ = kakaoRegistrationButton.waitForExistence(timeout: 1)
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

/// 추가 정보 입력란에서 유저가 정보를 제대로 입력했는지 검사
/// 성별 디폴트 선택이 남성인지 + 성별을 하나만 선택할 수 있는지 검사
/// 성공: 생일을 제대로 입력하면 다음 버튼 활성화 및 넘어가기 됨
/// 실패: 생일을 이상하게 입력하거나 입력하지 않으면 다음 버튼 비활성화
final class when_user_put_additional_information: XCTestCase {
    
    private var app: XCUIApplication!
    private var loginPageObject: LoginPageObject!
    
    override func setUp() {
        app = .init()
        continueAfterFailure = false
        
        loginPageObject = .init(app: app)
        
        app.launch()
        
        let kakaoRegistrationButton = loginPageObject.kakaoRegistrationButton
        
        _ = kakaoRegistrationButton.waitForExistence(timeout: 1)
        loginPageObject.kakaoRegistrationButton.tap()
        
        let emailTextField = loginPageObject.emailTextField
        let phoneTextField = loginPageObject.phoneTextField
        
        _ = emailTextField.waitForExistence(timeout: 1)
        
        emailTextField.tap()
        emailTextField.typeText("newsfit@goodemail.com")
        
        phoneTextField.tap()
        phoneTextField.typeText("01012341234")
        
        loginPageObject.nextButton.tap()
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
        
        XCTAssertTrue(loginPageObject.newsTopicButton(at: 0).waitForExistence(timeout: 1))
    }
    
    override func tearDown() {
        print("test done")
    }
}

/// 뉴스 주제를 3개이상 선택했는지 검사
/// 성공: 3개이상 선택 -> 다음 버튼 활성화
/// 실패1: 목록에 항목이 3개 이상 있는지 검사 -> 3개 미만은 무조건 실패
/// 실패2: 활성화 & 비활성화 토글 안될경우 실패
/// 실패3: 아무것도 선택 안했는데 -> 다음 버튼 활성화되어 있으면 실패 + 에러 메시지 출력
/// 실패4: 3개 미만 선택 -> 다음버튼 활성화되어 있으면 실패 + 에러 메시지 출력
final class when_user_select_news_topics: XCTestCase {
    
    private var app: XCUIApplication!
    private var loginPageObject: LoginPageObject!
    private let errorMessage = "최소 3개 주제를 선택하세요."
    
    override func setUp() {
        app = .init()
        continueAfterFailure = false
        
        loginPageObject = .init(app: app)
        
        app.launch()
        
        let kakaoRegistrationButton = loginPageObject.kakaoRegistrationButton
        
        _ = kakaoRegistrationButton.waitForExistence(timeout: 1)
        loginPageObject.kakaoRegistrationButton.tap()
        
        let emailTextField = loginPageObject.emailTextField
        let phoneTextField = loginPageObject.phoneTextField
        
        _ = emailTextField.waitForExistence(timeout: 1)
        
        emailTextField.tap()
        emailTextField.typeText("newsfit@goodemail.com")
        
        phoneTextField.tap()
        phoneTextField.typeText("01012341234")
        
        loginPageObject.nextButton.tap()
        
        let birthdayTextField = loginPageObject.birthdayTextField
        
        _ = birthdayTextField.waitForExistence(timeout: 1)
        birthdayTextField.tap()
        birthdayTextField.typeText("20240101")
        
        loginPageObject.nextButton.tap()
    }
    
    // 성공
    func test_should_navigate_to_presss_selection_for_success() {
        loginPageObject.newsTopicButton(at: 0).tap()
        loginPageObject.newsTopicButton(at: 1).tap()
        loginPageObject.newsTopicButton(at: 2).tap()
        
        XCTAssertTrue(loginPageObject.nextButton.isEnabled)
        XCTAssertEqual(loginPageObject.newsTopicMessageLabel.label, "")
        
        loginPageObject.nextButton.tap()
        
        XCTAssertTrue(loginPageObject.pressSubscribeTableView.waitForExistence(timeout: 1))
    }
    
    // 실패1
    func test_should_check_if_there_are_more_than_three_topics() {
        XCTAssertTrue(loginPageObject.newsTopicButton(at: 0).exists)
        XCTAssertTrue(loginPageObject.newsTopicButton(at: 1).exists)
        XCTAssertTrue(loginPageObject.newsTopicButton(at: 2).exists)
    }
    
    // 실패2
    func test_should_be_able_to_toggle_topic_selections() {
        let btn1 = loginPageObject.newsTopicButton(at: 0)
        XCTAssertFalse(btn1.isSelected)
        btn1.tap()
        XCTAssertTrue(btn1.isSelected)
        btn1.tap()
        XCTAssertFalse(btn1.isSelected)
    }
    
    // 실패3
    func test_should_display_error_message_without_selection() {
        XCTAssertFalse(loginPageObject.nextButton.isEnabled)
        XCTAssertEqual(loginPageObject.newsTopicMessageLabel.label, self.errorMessage)
    }
    
    // 실패4
    func test_should_display_error_message_less_than_three_topics() {
        let btn1 = loginPageObject.newsTopicButton(at: 0)
        let btn2 = loginPageObject.newsTopicButton(at: 1)
        let msg = loginPageObject.newsTopicMessageLabel
        
        btn1.tap()
        XCTAssertFalse(loginPageObject.nextButton.isEnabled)
        XCTAssertEqual(msg.label, self.errorMessage)
        
        btn2.tap()
        XCTAssertFalse(loginPageObject.nextButton.isEnabled)
        XCTAssertEqual(msg.label, self.errorMessage)
        
        btn1.tap()
        btn2.tap()
        XCTAssertFalse(loginPageObject.nextButton.isEnabled)
        XCTAssertEqual(msg.label, self.errorMessage)
    }
    
    
    override func tearDown() {
        print("test done")
    }
}

/// 신문사를 3개 이상 구독했는지 검사
/// 성공: 3개이상 선택 -> 다음 번튼 활성화
/// 실패1: 목록에 항목이 3개 이상 있는지 검사 -> 3개 미만은 무조건 실패
/// 실패2: 활성화 & 비활성화 토글 안될경우 실패
/// 실패3: 아무것도 선택 안했는데 -> 다음 버튼 활성화되어 있으면 실패 + 에러 메시지 출력
/// 실패4: 3개 미만 선택 -> 다음버튼 활성화되어 있으면 실패 + 에러 메시지 출력
final class when_user_subscribe_presses: XCTestCase {
    
    private var app: XCUIApplication!
    private var loginPageObject: LoginPageObject!
    private let errorMessage = "최소 3개 언론사를 구독하세요."
    
    override func setUp() {
        app = .init()
        continueAfterFailure = false
        
        loginPageObject = .init(app: app)
        
        app.launch()
        
        let kakaoRegistrationButton = loginPageObject.kakaoRegistrationButton
        
        _ = kakaoRegistrationButton.waitForExistence(timeout: 1)
        loginPageObject.kakaoRegistrationButton.tap()
        
        let emailTextField = loginPageObject.emailTextField
        let phoneTextField = loginPageObject.phoneTextField
        
        _ = emailTextField.waitForExistence(timeout: 1)
        
        emailTextField.tap()
        emailTextField.typeText("newsfit@goodemail.com")
        
        phoneTextField.tap()
        phoneTextField.typeText("01012341234")
        
        loginPageObject.nextButton.tap()
        
        let birthdayTextField = loginPageObject.birthdayTextField
        
        _ = birthdayTextField.waitForExistence(timeout: 1)
        birthdayTextField.tap()
        birthdayTextField.typeText("20240101")
        
        loginPageObject.nextButton.tap()
        
        loginPageObject.newsTopicButton(at: 0).tap()
        loginPageObject.newsTopicButton(at: 1).tap()
        loginPageObject.newsTopicButton(at: 2).tap()
        
        loginPageObject.nextButton.tap()
    }
    
    // 성공
    func test_should_navigate_to_complete_page_for_success() {
        loginPageObject.pressSubscribeButton(at: 0).tap()
        loginPageObject.pressSubscribeButton(at: 1).tap()
        loginPageObject.pressSubscribeButton(at: 2).tap()
        
        XCTAssertEqual(loginPageObject.pressSubscribeMessageLabel.label, "")
        XCTAssertTrue(loginPageObject.nextButton.isEnabled)
        
        loginPageObject.nextButton.tap()
        
        XCTAssertTrue(loginPageObject.completePageMessageLabel.waitForExistence(timeout: 1))
    }
    
    // 실패1
    func test_should_check_if_there_are_more_than_three_presses() {
        XCTAssertTrue(loginPageObject.pressSubscribeButton(at: 0).exists)
        XCTAssertTrue(loginPageObject.pressSubscribeButton(at: 1).exists)
        XCTAssertTrue(loginPageObject.pressSubscribeButton(at: 2).exists)
    }
    
    // 실패2
    func test_should_be_able_to_toggle_press_subscription_selections() {
        let btn1 = loginPageObject.pressSubscribeButton(at: 0)
        XCTAssertFalse(btn1.isSelected)
        btn1.tap()
        XCTAssertTrue(btn1.isSelected)
        btn1.tap()
        XCTAssertFalse(btn1.isSelected)
    }
    
    // 실패3
    func test_should_display_error_message_without_selection() {
        XCTAssertFalse(loginPageObject.nextButton.isEnabled)
        XCTAssertEqual(loginPageObject.pressSubscribeMessageLabel.label, self.errorMessage)
    }
    
    // 실패4
    func test_should_display_error_message_select_less_than_three_presses() {
        let btn1 = loginPageObject.pressSubscribeButton(at: 0)
        let btn2 = loginPageObject.pressSubscribeButton(at: 1)
        let msg = loginPageObject.pressSubscribeMessageLabel
        
        btn1.tap()
        XCTAssertFalse(loginPageObject.nextButton.isEnabled)
        XCTAssertEqual(msg.label, self.errorMessage)
        
        btn2.tap()
        XCTAssertFalse(loginPageObject.nextButton.isEnabled)
        XCTAssertEqual(msg.label, self.errorMessage)
        
        btn1.tap()
        btn2.tap()
        XCTAssertFalse(loginPageObject.nextButton.isEnabled)
        XCTAssertEqual(msg.label, self.errorMessage)
    }
    
    override func tearDown() {
        print("test done")
    }
}
