//
//  NewsFitHomeInterfaceTests.swift
//  NewsFitUITests
//
//  Created by User on 6/3/24.
//

import XCTest

/// 홈 화면에서 뉴스 눌렀을 때 테스트할 것
/// 헤드라인 중에 뭐 항목 누른다고 하자.
/// 테스트1: bottomSheet 올라와야 하고
/// 테스트2: 아무것도 선택되어 있으면 안됨
final class when_user_click_on_one_of_headlines: XCTestCase {
    
    private var app: XCUIApplication!
    private var homePageObject: NewsFitHomePageObject!
    
    override func setUp() {
        app = .init()
        continueAfterFailure = false
        
        homePageObject = .init(app: app)
        let loginPageObject = LoginPageObject(app: app)
        
        app.launchEnvironment = ["ENV" : "DEV"]
        
        app.launch()
        
        let kakaoLoginButton = loginPageObject.kakaoLoginButton
        
        _ = kakaoLoginButton.waitForExistence(timeout: 1)
        kakaoLoginButton.tap()
    }
    
    func test_should_display_news_bottom_sheet() {
        let headline = homePageObject.headlineCell(at: 0)
        headline.tap()
        
        let aibutton = homePageObject.newsSheetAiSummaryButton
        XCTAssertTrue(aibutton.waitForExistence(timeout: 1))
    }
    
    func test_should_not_selected_any_buttons_by_default() {
        let headline = homePageObject.headlineCell(at: 0)
        headline.tap()
        
        let aiBtn = homePageObject.newsSheetAiSummaryButton
        let commentBtn = homePageObject.newsSheetCommentsButton
        let likeBtn = homePageObject.newsSheetLikeButton
        
        _ = aiBtn.waitForExistence(timeout: 1)
        
        XCTAssertFalse(aiBtn.isSelected)
        XCTAssertFalse(commentBtn.isSelected)
        XCTAssertFalse(likeBtn.isSelected)
    }
    
    override func tearDown() {
        print("test done")
    }
}


/// AI요약 버튼 누르면 요약문구 나와야 함
/// 테스트1: 누르면 요약문구 등장
final class when_user_click_on_ai_summary_button: XCTestCase {
    private var app: XCUIApplication!
    private var homePageObject: NewsFitHomePageObject!
    
    override func setUp() {
        app = .init()
        continueAfterFailure = false
        
        homePageObject = .init(app: app)
        let loginPageObject = LoginPageObject(app: app)
        
        app.launchEnvironment = ["ENV" : "DEV"]
        
        app.launch()
        
        let kakaoLoginButton = loginPageObject.kakaoLoginButton
        
        _ = kakaoLoginButton.waitForExistence(timeout: 1)
        kakaoLoginButton.tap()
        
        let headline = homePageObject.headlineCell(at: 0)
        _ = headline.waitForExistence(timeout: 1)
        headline.tap()
    }
    
    func test_should_display_summarized_news_label() {
        XCTAssertTrue(homePageObject.summarizedNewsLabel.waitForExistence(timeout: 1))
    }
    
    override func tearDown() {
        print("test done")
    }
}



/// 테스트2: 댓글 버튼 누르면 댓글이 나와야 함
final class when_user_click_on_comments_button: XCTestCase {
    private var app: XCUIApplication!
    private var homePageObject: NewsFitHomePageObject!
    
    override func setUp() {
        app = .init()
        continueAfterFailure = false
        
        homePageObject = .init(app: app)
        let loginPageObject = LoginPageObject(app: app)
        
        app.launchEnvironment = ["ENV" : "DEV"]
        
        app.launch()
        
        let kakaoLoginButton = loginPageObject.kakaoLoginButton
        
        _ = kakaoLoginButton.waitForExistence(timeout: 1)
        kakaoLoginButton.tap()
        
        let headline = homePageObject.headlineCell(at: 0)
        _ = headline.waitForExistence(timeout: 1)
        headline.tap()
    }
    
    func test_should_display_comments() {
        XCTAssertTrue(homePageObject.newsCommentTableView.waitForExistence(timeout: 1))
    }
    
    override func tearDown() {
        print("test done")
    }
}



/// 테스트3: 좋아요 버튼 누르면 좋아요 되어야 함
/// - 좋아요 개수가 증가해야 함
final class when_user_click_on_like_button: XCTestCase {
    private var app: XCUIApplication!
    private var homePageObject: NewsFitHomePageObject!
    
    override func setUp() {
        app = .init()
        continueAfterFailure = false
        
        homePageObject = .init(app: app)
        let loginPageObject = LoginPageObject(app: app)
        
        app.launchEnvironment = ["ENV" : "DEV"]
        
        app.launch()
        
        let kakaoLoginButton = loginPageObject.kakaoLoginButton
        
        _ = kakaoLoginButton.waitForExistence(timeout: 1)
        kakaoLoginButton.tap()
        
        let headline = homePageObject.headlineCell(at: 0)
        _ = headline.waitForExistence(timeout: 1)
        headline.tap()
    }
    
    func test_should_increase_like_count_if_unliked() {
        let likeCount = homePageObject.newsSheetLikeCount
        
        let prev = Int(likeCount.label)!
        homePageObject.newsSheetLikeButton.tap()
        
        let now = Int(likeCount.label)!
        
        XCTAssertEqual(prev + 1, now)
    }
    
    func test_should_decrease_like_count_if_liked() {
        let likeCount = homePageObject.newsSheetLikeCount
        
        homePageObject.newsSheetLikeButton.tap()
        let prev = Int(likeCount.label)!
        
        homePageObject.newsSheetLikeButton.tap()
        let now = Int(likeCount.label)!
        
        XCTAssertEqual(prev - 1, now)
    }
    
    override func tearDown() {
        print("test done")
    }
}
