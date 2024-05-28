import Foundation
import XCTest

final class LoginPageObject {
    private let app: XCUIApplication
    
    init(app: XCUIApplication) {
        self.app = app
    }
    
    var naverLoginButton: XCUIElement {
        app.buttons[PageConstants.naverLoginButton.rawValue]
    }
    
    var kakaoLoginButton: XCUIElement {
        app.buttons[PageConstants.kakaoLoginButton.rawValue]
    }
    
    var appleLoginButton: XCUIElement {
        app.buttons[PageConstants.appleLoginButton.rawValue]
    }
    
    var naverRegistrationButton: XCUIElement {
        app.buttons[PageConstants.naverRegistrationButton.rawValue]
    }
    
    var kakaoRegistrationButton: XCUIElement {
        app.buttons[PageConstants.kakaoRegistrationButton.rawValue]
    }
    
    var appleRegistrationButton: XCUIElement {
        app.buttons[PageConstants.appleRegistrationButton.rawValue]
    }
    
    var nextButton: XCUIElement {
        app.buttons[PageConstants.nextButton.rawValue]
    }
    
    var nameTextField: XCUIElement {
        app.buttons[PageConstants.nameTextField.rawValue]
    }
    
}

fileprivate enum PageConstants: String {
    case naverLoginButton
    case kakaoLoginButton
    case appleLoginButton
    case naverRegistrationButton
    case kakaoRegistrationButton
    case appleRegistrationButton
    case nextButton
    case nameTextField
    case emailTextField
    case phoneTextField
    case maleCheckBox
    case femaleCheckBox
    case birthdayTextField
    case newsTopicCollectionView
    case newsTopicButton
    case pressSubscribeTableView
    case pressSubscribeButton
}
