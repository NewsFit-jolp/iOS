//
//  NewsFitUITests.swift
//  NewsFitUITests
//
//  Created by User on 5/28/24.e
//

import XCTest

final class when_user_click_on_login_button: XCTestCase {
    
    private var app: XCUIApplication!
    private var loginPageObject: LoginPageObject!
    
    override func setUp() {
        app = .init()
        continueAfterFailure = false
        
        loginPageObject = .init(app: app)
        
        app.launch()
    }
    
    
    
    
    override func tearDown() {
        print("test done")
    }
    
}


final class when_user_click_on_registration_button: XCTestCase {
    
    private var app: XCUIApplication!
    private var loginPageObject: LoginPageObject!
    
    override func setUp() {
        app = .init()
        continueAfterFailure = false
        
        loginPageObject = .init(app: app)
        
        app.launch()
    }
    
    
    
    
    override func tearDown() {
        print("test done")
    }
    
    
}
