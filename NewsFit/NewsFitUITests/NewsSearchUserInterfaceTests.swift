//
//  NewsSearchUserInterfaceTests.swift
//  NewsFitUITests
//
//  Created by User on 6/3/24.
//

import XCTest

/// 1. 검색하여 -> 결과 리스트 구성
/// 2. 검색어 지울시 -> 카테고리별 정리된 화면 구성
/// 3. 카테고리 아이템 클릭시 바텀시트 출력
/// 4. 검색 결과 리스트 아이템 클릭시 바텀시트 출력

/// 카테고리 뉴스를 눌렀을 경우 -> news시트 나와야함
final class when_user_click_on_one_of_catecorized_item: XCTestCase {
    
    private var app: XCUIApplication!
    private var searchPageObject: NewsSearchPageObject!
    
    override func setUp() {
        app = .init()
        continueAfterFailure = false
        
        searchPageObject = .init(app: app)
        let loginPageObject = LoginPageObject(app: app)
        let newsPageObject = NewsFitNewsPageObject(app: app)
        
        app.launchEnvironment = ["ENV" : "DEV"]
        
        app.launch()
        
        let kakaoLoginButton = loginPageObject.kakaoLoginButton
        
        _ = kakaoLoginButton.waitForExistence(timeout: 1)
        kakaoLoginButton.tap()
        
        _ = loginPageObject.mainLogoImage.waitForExistence(timeout: 0.5)
        
        let searchNavBtn = newsPageObject.searchNavButton
        searchNavBtn.tap()
    }
    
    func test_should_display_news_sheet() {
        let item = searchPageObject.newsCategoryCell(at: 0)
        item.tap()
        
        let newsSheetAiSummaryButton = NewsFitNewsPageObject(app: app).newsSheetAiSummaryButton
        
        XCTAssertTrue(newsSheetAiSummaryButton.waitForExistence(timeout: 1))
    }
    
    override func tearDown() {
        print("test done")
    }
}

/// 유저가 뉴스를 검색했을 때
/// 결과가 1개 이상이면 -> 결과 리스트 출력
/// 결과가 0개면 -> 검색결과 없음을 알림
final class when_user_search_news_by_keyword: XCTestCase {
    
    private var app: XCUIApplication!
    private var searchPageObject: NewsSearchPageObject!
    
    override func setUp() {
        app = .init()
        continueAfterFailure = false
        
        searchPageObject = .init(app: app)
        let loginPageObject = LoginPageObject(app: app)
        let newsPageObject = NewsFitNewsPageObject(app: app)
        
        app.launchEnvironment = ["ENV" : "DEV"]
        
        app.launch()
        
        let kakaoLoginButton = loginPageObject.kakaoLoginButton
        
        _ = kakaoLoginButton.waitForExistence(timeout: 1)
        kakaoLoginButton.tap()
        
        _ = loginPageObject.mainLogoImage.waitForExistence(timeout: 0.5)
        
        let searchNavBtn = newsPageObject.searchNavButton
        searchNavBtn.tap()
    }
    
    func test_should_display_search_list_for_success() {
        let searchButton = searchPageObject.newsSearchButton
        let searchTextField = searchPageObject.newsSearchTextField
        
        searchTextField.tap()
        searchTextField.typeText("성공검색어")
        
        searchButton.tap()
        
        let searchList = searchPageObject.newsListCollectionView
        
        XCTAssertTrue(searchList.waitForExistence(timeout: 1))
        XCTAssertEqual(searchPageObject.newsResultMessageLabel.label, "\"성공검색어\"에 대한 뉴스")
    }
    
    func test_should_display_error_message_for_success() {
        let searchButton = searchPageObject.newsSearchButton
        let searchTextField = searchPageObject.newsSearchTextField
        
        searchTextField.tap()
        searchTextField.typeText("실패검색어")
        
        searchButton.tap()
        
        let searchList = searchPageObject.newsListCollectionView
        
        XCTAssertFalse(searchList.waitForExistence(timeout: 1))
        XCTAssertEqual(searchPageObject.newsResultMessageLabel.label, "\"실패검색어\"에 대한 뉴스 검색 결과가 없습니다.")
    }
    
    override func tearDown() {
        print("test done")
    }
}

final class when_user_click_on_one_of_search_newses: XCTestCase {
    
    private var app: XCUIApplication!
    private var searchPageObject: NewsSearchPageObject!
    
    override func setUp() {
        app = .init()
        continueAfterFailure = false
        
        searchPageObject = .init(app: app)
        let loginPageObject = LoginPageObject(app: app)
        let newsPageObject = NewsFitNewsPageObject(app: app)
        
        app.launchEnvironment = ["ENV" : "DEV"]
        
        app.launch()
        
        let kakaoLoginButton = loginPageObject.kakaoLoginButton
        
        _ = kakaoLoginButton.waitForExistence(timeout: 1)
        kakaoLoginButton.tap()
        
        _ = loginPageObject.mainLogoImage.waitForExistence(timeout: 0.5)
        
        let searchNavBtn = newsPageObject.searchNavButton
        searchNavBtn.tap()
        
        let searchButton = searchPageObject.newsSearchButton
        let searchTextField = searchPageObject.newsSearchTextField
        
        _ = searchButton.waitForExistence(timeout: 1)
        
        searchTextField.tap()
        searchTextField.typeText("성공검색어")
        
        searchButton.tap()
    }
    
    func test_should_display_news_sheet() {
        let item = searchPageObject.newsListCell(at: 0)
        item.tap()
        
        let newsSheetAiSummaryButton = NewsFitNewsPageObject(app: app).newsSheetAiSummaryButton
        
        XCTAssertTrue(newsSheetAiSummaryButton.waitForExistence(timeout: 1))
    }
    
    override func tearDown() {
        print("test done")
    }
}
