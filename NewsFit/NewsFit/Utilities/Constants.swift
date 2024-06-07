//
//  Constants.swift
//  NewsFit
//
//  Created by 임정현 on 6/7/24.
//

import Foundation

// MARK: - NanumGothicFontName
public enum NanumGothicFontName {
    private static let familiy: String = "NanumGothic Font-"
    static var regular: String {
        Self.familiy + "NanumGothic"
    }
    static var bold: String {
        Self.familiy + "NanumGothicBold"
    }
    static var extraBold: String {
        Self.familiy + "NanumGothicExtraBold"
    }
    static var light: String {
        Self.familiy + "NanumGothicLight"
    }
}
