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
}
