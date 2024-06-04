//
//  NewsSearchPageObject.swift
//  NewsFitUITests
//
//  Created by User on 6/3/24.
//

import XCTest

final class NewsSearchPageObject {
    private var app: XCUIApplication
    
    init(app: XCUIApplication) {
        self.app = app
    }
    
    var newsSearchTextField: XCUIElement {
        app.searchFields[PageConstants.newsSearchTextField.rawValue]
    }
    
    var newsSearchButton: XCUIElement {
        app.searchFields[PageConstants.newsSearchButton.rawValue]
    }
    
    var newsResultMessageLabel: XCUIElement {
        app.staticTexts[PageConstants.newsResultMessageLabel.rawValue]
    }
    
    var newsCategoryCollectionVeiw: XCUIElement {
        app.searchFields[PageConstants.newsCategoryCollectionVeiw.rawValue]
    }
    
    func newsCategoryCell(at idx: Int) -> XCUIElement {
        newsCategoryCollectionVeiw.cells.element(boundBy: idx)
    }
    
    var newsListCollectionView: XCUIElement {
        app.searchFields[PageConstants.newsListCollectionView.rawValue]
    }
    
    func newsListCell(at idx: Int) -> XCUIElement {
        newsListCollectionView.cells.element(boundBy: idx)
    }
    
}

fileprivate enum PageConstants: String {
    case newsSearchTextField
    case newsSearchButton
    
    case newsResultMessageLabel
    
    case newsCategoryCollectionVeiw
    case newsListCollectionView
}
