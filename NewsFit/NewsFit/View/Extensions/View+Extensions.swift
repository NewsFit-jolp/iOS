//
//  Extensions.swift
//  NewsFit
//
//  Created by user on 11/13/24.
//

import Foundation

extension Date {
  var koTime: String {
    let formatStyle = Date.RelativeFormatStyle(presentation: .numeric, locale: .init(identifier: "ko_KR"))
    return formatStyle.format(self)
  }
}
