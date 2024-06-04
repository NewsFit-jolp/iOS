//
//  UserInformationSettingsPageObject.swift
//  NewsFitUITests
//
//  Created by User on 6/4/24.
//

import XCTest

final class UserInformationSettingsPageObject {
    private let app: XCUIApplication
    
    init(app: XCUIApplication) {
        self.app = app
    }
    
    var myInfoTableView: XCUIElement {
        app.tables[PageConstants.myInfoTableView.rawValue]
    }
    
    func myInfoCell(at idx: Int) -> XCUIElement {
        myInfoTableView.cells.element(boundBy: idx)
    }
    
    var confirmButton: XCUIElement {
        app.buttons[PageConstants.confirmButton.rawValue]
    }
    var cancelButton: XCUIElement {
        app.buttons[PageConstants.cancelButton.rawValue]
    }
    
    var pushSettingTableView: XCUIElement {
        app.tables[PageConstants.myInfoTableView.rawValue]
    }
    func pushSettingCell(at idx: Int) -> XCUIElement {
        pushSettingTableView.cells.element(boundBy: idx)
    }
    var pushSettingTitle: XCUIElement {
        app.staticTexts[PageConstants.pushSettingTitle.rawValue]
    }
    var toggleButton: XCUIElement {
        app.buttons[PageConstants.toggleButton.rawValue]
    }
    
    var alertTitleLabel: XCUIElement {
        app.staticTexts[PageConstants.alertTitleLabel.rawValue]
    }
}

fileprivate enum PageConstants: String {
    case myInfoTableView
    
    case confirmButton
    case cancelButton
    
    case pushSettingTableView
    case pushSettingTitle
    case toggleButton
    
    case alertTitleLabel
}
