//
//  Constants.swift
//  NewsFit
//
//  Created by 임정현 on 6/7/24.
//

import Foundation

// MARK: - NanumGothicFontName
public enum NanumGothicFontName {
    private static let familiy: String = "NanumGothic"
    static var regular: String {
        Self.familiy + ""
    }
    static var bold: String {
        Self.familiy + "Bold"
    }
    static var extraBold: String {
        Self.familiy + "ExtraBold"
    }
    static var light: String {
        Self.familiy + "Light"
    }
}
