//
//  Bundle+Extension.swift
//  NewsFit
//
//  Created by 임정현 on 10/29/24.
//

import Foundation

extension Bundle {
  static var baseURL: String {
    return Bundle.main.object(forInfoDictionaryKey: "BASE_URL") as? String ?? ""
  }
  static var token: String {
    return Bundle.main.object(forInfoDictionaryKey: "TOKEN") as? String ?? ""
  }
  static var NAVER_OAUTH_CLIENT_ID: String {
    return Bundle.main.object(forInfoDictionaryKey: "NAVER_OAUTH_CLIENT_ID") as? String ?? ""
  }
  static var KAKAO_OAUTH_CLIENT_ID: String {
    return Bundle.main.object(forInfoDictionaryKey: "KAKAO_OAUTH_CLIENT_ID") as? String ?? ""
  }
  static var GOOGLE_OAUTH_CLIENT_ID: String {
    return Bundle.main.object(forInfoDictionaryKey: "GOOGLE_OAUTH_CLIENT_ID") as? String ?? ""
  }
}
