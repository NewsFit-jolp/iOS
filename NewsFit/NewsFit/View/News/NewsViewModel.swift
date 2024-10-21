import Foundation

struct NewsViewModel: NewsPresentable, PressImagePresentable {
  let title: String
  let press: String
  var date: String {
    let formatStyle = Date.RelativeFormatStyle(presentation: .numeric, locale: .init(identifier: "ko_KR"))
    return formatStyle.format(createdDate)
  }
  var imageURL: URL?
  var pressImageURL: URL?
  private let createdDate: Date
  
  init(title: String, press: String, imageURL: URL? = nil, pressImageURL: URL? = nil, createdDate: Date) {
    self.title = title
    self.press = press
    self.imageURL = imageURL
    self.pressImageURL = pressImageURL
    self.createdDate = createdDate
  }
}
