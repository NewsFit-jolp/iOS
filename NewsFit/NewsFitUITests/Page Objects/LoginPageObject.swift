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
        app.textFields[PageConstants.nameTextField.rawValue]
    }
    
    var emailTextField: XCUIElement {
        app.textFields[PageConstants.emailTextField.rawValue]
    }
    
    var emailMessageLabel: XCUIElement {
        app.staticTexts[PageConstants.emailMessageLabel.rawValue]
    }
    
    var phoneTextField: XCUIElement {
        app.textFields[PageConstants.phoneTextField.rawValue]
    }
    
    var phoneMessageLabel: XCUIElement {
        app.staticTexts[PageConstants.phoneMessageLabel.rawValue]
    }
    
    var maleCheckBox: XCUIElement {
        app.buttons[PageConstants.maleCheckBox.rawValue]
    }
    
    var femaleCheckBox: XCUIElement {
        app.buttons[PageConstants.femaleCheckBox.rawValue]
    }
    
    var birthdayTextField: XCUIElement {
        app.textFields[PageConstants.birthdayTextField.rawValue]
    }
    
    var newsTopicCollectionView: XCUIElement {
        app.collectionViews[PageConstants.newsTopicCollectionView.rawValue]
    }
    
    func newsTopicButton(at idx: Int) -> XCUIElement {
        newsTopicCollectionView.cells.element(boundBy: idx)
            .buttons[PageConstants.newsTopicButton.rawValue]
    }
    
    var newsTopicMessageLabel: XCUIElement {
        app.staticTexts[PageConstants.newsTopicMessageLabel.rawValue]
    }
    
    var pressSubscribeTableView: XCUIElement {
        app.tables[PageConstants.pressSubscribeTableView.rawValue]
    }
    
    func pressSubscribeButton(at idx: Int) -> XCUIElement {
        pressSubscribeTableView.cells.element(boundBy: idx)
            .buttons[PageConstants.pressSubscribeButton.rawValue]
    }
    
    var mainLogoImage: XCUIElement {
        app.images[PageConstants.mainLogoImage.rawValue]
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
    case emailMessageLabel
    case phoneTextField
    case phoneMessageLabel
    
    case maleCheckBox
    case femaleCheckBox
    case birthdayTextField
    
    case newsTopicCollectionView
    case newsTopicButton
    case newsTopicMessageLabel
    
    case pressSubscribeTableView
    case pressSubscribeButton
    
    case mainLogoImage
    
}
