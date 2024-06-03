//
//  NewsFitHomePageObject.swift
//  NewsFitUITests
//
//  Created by User on 6/3/24.
//

import XCTest

final class NewsFitHomePageObject {
    private let app: XCUIApplication
    
    init(app: XCUIApplication) {
        self.app = app
    }
    
    var headlineCollectionView: XCUIElement {
        app.collectionViews[PageConstants.headlineCollectionView.rawValue]
    }
    func headlineCell(at idx: Int) -> XCUIElement {
        self.headlineCollectionView.cells.element(boundBy: idx)
    }
    
    var newsListCollectionView: XCUIElement {
        app.collectionViews[PageConstants.newsListCollectionView.rawValue]
    }
    func newsListCell(at idx: Int) -> XCUIElement {
        self.newsListCollectionView.cells.element(boundBy: idx)
    }
    
    var tabBarNavigator: XCUIElement {
        app.tabBars[PageConstants.tabBarNavigator.rawValue]
    }
    
    var homeNavButton: XCUIElement {
        tabBarNavigator.buttons[PageConstants.homeNavButton.rawValue]
    }
    
    var searchNavButton: XCUIElement {
        tabBarNavigator.buttons[PageConstants.searchNavButton.rawValue]
    }
    
    var myInfoNavButton: XCUIElement {
        tabBarNavigator.buttons[PageConstants.myInfoNavButton.rawValue]
    }
    
    var newsSheetAiSummaryButton: XCUIElement {
        app.buttons[PageConstants.newsSheetAiSummaryButton.rawValue]
    }
    var newsSheetCommentsButton: XCUIElement {
        app.buttons[PageConstants.newsSheetCommentsButton.rawValue]
    }
    var newsSheetLikeButton: XCUIElement {
        app.buttons[PageConstants.newsSheetLikeButton.rawValue]
    }
    var newsSheetLikeCount: XCUIElement {
        app.staticTexts[PageConstants.newsSheetLikeCount.rawValue]
    }
    var newsSheetLikeImage: XCUIElement {
        app.images[PageConstants.newsSheetLikeImage.rawValue]
    }
    
    
    var summarizedNewsLabel: XCUIElement {
        app.staticTexts[PageConstants.summarizedNewsLabel.rawValue]
    }
    
    var newsCommentTextField: XCUIElement {
        app.textFields[PageConstants.newsCommentTextField.rawValue]
    }
    var newsCommentSendButton: XCUIElement {
        app.buttons[PageConstants.newsCommentSendButton.rawValue]
    }
    var newsCommentTableView: XCUIElement {
        app.tables[PageConstants.newsCommentTableView.rawValue]
    }
    func newsCommentCell(at idx: Int) -> XCUIElement {
        self.newsCommentTableView.cells.element(boundBy: idx)
    }
}

fileprivate enum PageConstants: String {
    case headlineCollectionView
    case newsListCollectionView
    
    case tabBarNavigator
    case homeNavButton
    case searchNavButton
    case myInfoNavButton
    
    case newsSheetAiSummaryButton
    case newsSheetCommentsButton
    
    case newsSheetLikeButton
    case newsSheetLikeCount
    case newsSheetLikeImage
    
    case summarizedNewsLabel
    
    case newsCommentTextField
    case newsCommentSendButton
    case newsCommentTableView
    
}
