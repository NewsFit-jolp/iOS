import SwiftUI

extension Text {
  init(_ date: Date) {
    let formatStyle = Date.RelativeFormatStyle(presentation: .numeric, locale: .init(identifier: "ko_KR"))
    let string = formatStyle.format(date)
    
    self.init(string)
  }
}
